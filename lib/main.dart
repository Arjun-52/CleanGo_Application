import 'package:clean_go/features/location/presentation/providers/location_provider.dart';
import 'package:clean_go/features/orders/presentation/providers/new_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:clean_go/core/di/injection.dart' as di;

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import './routes/app_routes.dart';

// Providers
import './features/auth/presentation/providers/auth_provider.dart';
import './features/booking/presentation/providers/booking_provider.dart';
import './features/orders/presentation/providers/order_provider.dart';
import './features/home/presentation/providers/notification_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.login,
        routes: AppRoutes.routes,
      ),
    );
  }
}
