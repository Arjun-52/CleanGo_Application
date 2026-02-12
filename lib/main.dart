import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// Start app at login screen
      initialRoute: AppRoutes.login,

      routes: AppRoutes.routes,
    );
  }
}
