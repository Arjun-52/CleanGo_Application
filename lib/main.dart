import 'package:clean_go/features/location/presentation/providers/location_provider.dart';
import 'package:clean_go/features/orders/presentation/providers/new_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:clean_go/core/di/injection.dart' as di;
import 'package:go_router/go_router.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import './routes/app_router.dart';

// Providers
import './features/auth/presentation/providers/auth_provider.dart';
import './features/booking/presentation/providers/booking_provider.dart';
import './features/orders/presentation/providers/order_provider.dart';
import './features/home/presentation/providers/notification_provider.dart';
import './features/orders/presentation/providers/qr_scan_provider.dart';

import './features/orders/presentation/providers/order_timeline_provider.dart';
import './features/orders/presentation/providers/order_stage_provider.dart';

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
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<LocationProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<NotificationProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<OrderProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<QrScanProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<OrderTimelineProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<OrderStageProvider>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
      ),
    );
  }
}
