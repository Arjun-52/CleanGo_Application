import os
import re

def get_new_path(old_path):
    parts = old_path.replace('\\', '/').split('/')
    if len(parts) >= 4 and parts[0] == 'lib' and parts[1] == 'features':
        feature = parts[2]
        folder = parts[3]
        
        layer = None
        new_folder = folder
        
        if folder in ['screens', 'widgets', 'providers', 'utils']:
            layer = 'presentation'
        elif folder in ['models']:
            layer = 'data'
        elif folder in ['services', 'data']:
            layer = 'data'
            new_folder = 'datasources'
        elif folder in ['repositories']:
            layer = 'domain'
            new_folder = 'repositories'
        elif folder in ['entities']:
            layer = 'domain'
            new_folder = 'entities'
        elif folder in ['usecases', 'order_pricing']:
            layer = 'domain'
            new_folder = 'usecases'
        elif folder in ['order_constans']:
            layer = 'domain'
        else:
            layer = 'domain'
            
        new_parts = parts[:3] + [layer, new_folder] + parts[4:]
        # Simplify if layer and new_folder are redundant?
        # Actually, presentation/screens is fine.
        return '/'.join(new_parts)
    return old_path

def resolve_import(current_file_path, import_str):
    if import_str.startswith('package:clean_go/'):
        return import_str.replace('package:clean_go/', 'lib/', 1)
    elif not import_str.startswith('package:') and not import_str.startswith('dart:'):
        # normalize path
        current_dir = os.path.dirname(current_file_path)
        resolved_path = os.path.normpath(os.path.join(current_dir, import_str)).replace('\\', '/')
        return resolved_path
    return None

def main():
    dart_files = []
    for root, _, files in os.walk('lib'):
        for file in files:
            if file.endswith('.dart'):
                dart_files.append(os.path.join(root, file).replace('\\', '/'))

    path_mapping = {}
    for old_path in dart_files:
        path_mapping[old_path] = get_new_path(old_path)

    file_contents = {}
    for old_path in dart_files:
        try:
            with open(old_path, 'r', encoding='utf-8') as f:
                file_contents[old_path] = f.read()
        except:
            pass

    import_pattern = re.compile(r'''(import|part)\s+(['"])(.*?)\2''')
    
    for old_path, content in file_contents.items():
        new_path = path_mapping[old_path]
        
        def repl(match):
            keyword = match.group(1)
            quote = match.group(2)
            import_str = match.group(3)
            
            resolved_old_path = resolve_import(old_path, import_str)
            if resolved_old_path and resolved_old_path in path_mapping:
                target_new_path = path_mapping[resolved_old_path]
                
                if keyword == 'part':
                    current_new_dir = os.path.dirname(new_path)
                    new_rel = os.path.relpath(target_new_path, current_new_dir).replace('\\', '/')
                    return f"{keyword} {quote}{new_rel}{quote}"
                else:
                    if import_str.startswith('package:'):
                        # Preserve package import format
                        pkg_path = target_new_path.replace('lib/', 'package:clean_go/', 1)
                    else:
                        # Re-calculate relative import
                        current_new_dir = os.path.dirname(new_path)
                        new_rel = os.path.relpath(target_new_path, current_new_dir).replace('\\', '/')
                        # Keep it relative to match the user's implicit preference or just use package:
                        # Let's just use relative since they used relative
                        pkg_path = new_rel
                        if not pkg_path.startswith('.'):
                            pkg_path = './' + pkg_path
                    return f"{keyword} {quote}{pkg_path}{quote}"
                    
            return match.group(0)

        new_content = import_pattern.sub(repl, content)
        
        os.makedirs(os.path.dirname(new_path), exist_ok=True)
        with open(new_path, 'w', encoding='utf-8') as f:
            f.write(new_content)
            
    for old_path in dart_files:
        if old_path != path_mapping[old_path]:
            try:
                os.remove(old_path)
            except:
                pass
                
    for root, dirs, files in os.walk('lib', topdown=False):
        for name in dirs:
            dir_path = os.path.join(root, name)
            try:
                os.rmdir(dir_path)
            except:
                pass

    features_dir = 'lib/features'
    if os.path.exists(features_dir):
        for feature in os.listdir(features_dir):
            feature_path = os.path.join(features_dir, feature)
            if os.path.isdir(feature_path):
                for layer in ['domain/entities', 'domain/repositories', 'domain/usecases', 
                              'data/models', 'data/repositories', 'data/datasources', 
                              'presentation/screens', 'presentation/widgets', 'presentation/providers']:
                    os.makedirs(os.path.join(feature_path, layer.replace('/', os.sep)), exist_ok=True)

    print("Refactoring complete.")

if __name__ == '__main__':
    main()
