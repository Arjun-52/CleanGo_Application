import 'package:get_it/get_it.dart';

import 'package:clean_go/features/auth/data/datasources/auth_service.dart';
import 'package:clean_go/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_go/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:clean_go/features/auth/domain/usecases/auth_usecases.dart';
import 'package:clean_go/features/auth/presentation/providers/auth_provider.dart';

import 'package:clean_go/features/booking/data/datasources/booking_service.dart';
import 'package:clean_go/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:clean_go/features/booking/domain/repositories/i_booking_repository.dart';
import 'package:clean_go/features/booking/domain/usecases/booking_usecases.dart';
import 'package:clean_go/features/booking/presentation/providers/booking_provider.dart';

import 'package:clean_go/features/location/data/datasources/location_service.dart';
import 'package:clean_go/features/location/data/repositories/location_repository_impl.dart';
import 'package:clean_go/features/location/domain/repositories/i_location_repository.dart';
import 'package:clean_go/features/location/domain/usecases/location_usecases.dart';
import 'package:clean_go/features/location/presentation/providers/location_provider.dart';

import 'package:clean_go/features/orders/data/datasources/order_service.dart';
import 'package:clean_go/features/orders/data/repositories/order_repository_impl.dart';
import 'package:clean_go/features/orders/domain/repositories/i_order_repository.dart';
import 'package:clean_go/features/orders/domain/usecases/order_usecases.dart';
import 'package:clean_go/features/orders/presentation/providers/order_provider.dart';
import 'package:clean_go/features/orders/presentation/providers/new_order_provider.dart';

import 'package:clean_go/features/home/presentation/providers/notification_provider.dart';

import 'package:clean_go/core/services/payment_service.dart';
import 'package:clean_go/features/wallet/presentation/providers/wallet_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // --------------------------------------------------------------------------
  // Core Services
  // --------------------------------------------------------------------------
  sl.registerLazySingleton<PaymentService>(() => PaymentService());

  // --------------------------------------------------------------------------
  // Data Sources
  // --------------------------------------------------------------------------
  sl.registerLazySingleton<AuthService>(() => AuthService());
  sl.registerLazySingleton<BookingService>(() => BookingService());
  sl.registerLazySingleton<LocationService>(() => LocationService());
  sl.registerLazySingleton<OrderService>(() => OrderService());

  // --------------------------------------------------------------------------
  // Repositories
  // --------------------------------------------------------------------------
  sl.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<IBookingRepository>(
    () => BookingRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ILocationRepository>(
    () => LocationRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<IOrderRepository>(() => OrderRepositoryImpl(sl()));

  // --------------------------------------------------------------------------
  // UseCases
  // --------------------------------------------------------------------------
  sl.registerLazySingleton<AuthUseCases>(() => AuthUseCases(sl()));
  sl.registerLazySingleton<BookingUseCases>(() => BookingUseCases(sl()));
  sl.registerLazySingleton<LocationUseCases>(() => LocationUseCases(sl()));
  sl.registerLazySingleton<OrderUseCases>(() => OrderUseCases(sl()));

  // --------------------------------------------------------------------------
  // Providers
  // --------------------------------------------------------------------------
  sl.registerFactory<AuthProvider>(() => AuthProvider(sl()));
  sl.registerFactory<BookingProvider>(() => BookingProvider(sl()));
  sl.registerFactory<LocationProvider>(() => LocationProvider(sl()));
  sl.registerFactory<OrderProvider>(() => OrderProvider(sl()));
  sl.registerFactory<NewOrderProvider>(() => NewOrderProvider());
  sl.registerFactory<NotificationProvider>(() => NotificationProvider());
  sl.registerFactory<WalletProvider>(() => WalletProvider(sl()));
}
