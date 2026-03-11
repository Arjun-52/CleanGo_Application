import 'package:clean_go/core/di/injection.dart' as di;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Auth
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/otp_screen.dart';

// Location
import '../features/location/presentation/screens/select_location_screen.dart';
import '../features/location/presentation/screens/confirm_location_screen.dart';
import '../features/location/presentation/screens/address_form_screen.dart';

// Core Screens
import '../features/home/presentation/screens/home_screen.dart';

// Orders
import '../features/orders/presentation/screens/new_order_screen.dart';
import '../features/orders/presentation/screens/order_tracking_screen.dart';
import '../features/orders/presentation/screens/order_history_screen.dart';
import '../features/orders/presentation/screens/order_details_screen.dart';
import '../features/orders/presentation/screens/order_placed_screen.dart';

// Services
import '../features/services/presentation/screens/service_list_screen.dart';
import '../features/services/presentation/screens/service_detail_screen.dart';

// Booking
import '../features/booking/presentation/screens/cart_screen.dart';
import '../features/booking/presentation/screens/booking_summary_screen.dart';
import '../features/payment/presentation/screens/booking_payment_screen.dart';

// Wallet & Profile
import '../features/wallet/presentation/screens/wallet_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/profile/presentation/screens/edit_profile_screen.dart';
import '../features/profile/presentation/screens/saved_addresses_screen.dart';

// Providers
import '../features/booking/presentation/providers/booking_provider.dart';
import '../features/orders/presentation/providers/new_order_provider.dart';
import '../features/wallet/presentation/providers/wallet_provider.dart';

class AppRoutes {
  static const String login = '/login';
  static const String otp = '/otp';
  static const String selectLocation = '/select-location';
  static const String confirmLocation = '/confirm-location';
  static const String addressForm = '/address-form';
  static const String main = '/main';
  static const String home = '/home';
  static const String services = '/services';
  static const String serviceDetail = '/service-detail';
  static const String newOrder = '/new-order';
  static const String orderTracking = '/order-tracking';
  static const String orderHistory = '/order-history';
  static const String orderDetails = '/order-details';
  static const String orderPlaced = '/order-placed';
  static const String cart = '/cart';
  static const String bookingSummary = '/booking-summary';
  static const String payment = '/payment';
  static const String wallet = '/wallet';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String savedAddresses = '/saved-addresses';
}

// MAIN SCREEN WITH NESTED NAVIGATION

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.child});

  final Widget child;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<String> _routes = [
    '/main/home',
    '/main/new-order',
    '/main/order-tracking',
    '/main/wallet',
    '/main/profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;

            context.go(_routes[index]);
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xff0B3C5D),
        unselectedItemColor: const Color(0xff9E9E9E),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: "Track",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: "Wallet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

// ---------------- ROUTE CONFIGURATION ----------------

final appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    // Auth Routes
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '${AppRoutes.otp}/:verificationId',
      builder: (context, state) {
        final verificationId = state.pathParameters['verificationId']!;
        return OtpScreen(verificationId: verificationId);
      },
    ),

    // Location Routes
    GoRoute(
      path: AppRoutes.selectLocation,
      builder: (context, state) => const SelectLocationScreen(),
    ),
    GoRoute(
      path: AppRoutes.confirmLocation,
      builder: (context, state) => const ConfirmLocationScreen(),
    ),
    GoRoute(
      path: AppRoutes.addressForm,
      builder: (context, state) => const AddressFormSheet(),
    ),

    // Main Navigation with Nested Routes
    GoRoute(
      path: AppRoutes.main,
      builder: (context, state) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => di.sl<BookingProvider>()),
          ChangeNotifierProvider(create: (_) => di.sl<NewOrderProvider>()),
          ChangeNotifierProvider(create: (_) => di.sl<WalletProvider>()),
        ],
        child: const MainScreen(child: HomeScreen()),
      ),
      routes: [
        // Home Tab
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const MainScreen(child: HomeScreen()),
        ),

        // Services Tab
        GoRoute(
          path: AppRoutes.services,
          builder: (context, state) =>
              const MainScreen(child: ServiceListScreen()),
        ),
        GoRoute(
          path: '${AppRoutes.serviceDetail}/:serviceId',
          builder: (context, state) {
            final serviceId = state.pathParameters['serviceId']!;
            return const MainScreen(child: ServiceDetailScreen());
          },
        ),

        // Orders Tab
        GoRoute(
          path: AppRoutes.newOrder,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>? ?? {};
            final serviceName = extra['serviceName'] as String? ?? '';
            final isFastTrack = extra['isFastTrack'] as bool? ?? false;

            return ChangeNotifierProvider(
              create: (_) => di.sl<NewOrderProvider>(),
              child: MainScreen(
                child: NewOrderScreen(
                  serviceName: serviceName,
                  isFastTrack: isFastTrack,
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.orderTracking,
          builder: (context, state) => MainScreen(child: OrderTrackingScreen()),
        ),
        GoRoute(
          path: AppRoutes.orderHistory,
          builder: (context, state) =>
              const MainScreen(child: OrderHistoryScreen()),
        ),
        GoRoute(
          path: '${AppRoutes.orderDetails}/:orderId',
          builder: (context, state) {
            final orderId = state.pathParameters['orderId']!;
            return MainScreen(child: OrderDetailsScreen(orderId: orderId));
          },
        ),
        GoRoute(
          path: AppRoutes.orderPlaced,
          builder: (context, state) =>
              const MainScreen(child: OrderPlacedScreen()),
        ),

        // Wallet Tab
        GoRoute(
          path: AppRoutes.wallet,
          builder: (context, state) => const MainScreen(child: WalletScreen()),
        ),

        // Profile Tab
        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => const MainScreen(child: ProfileScreen()),
        ),
        GoRoute(
          path: AppRoutes.editProfile,
          builder: (context, state) => const EditProfileScreen(),
        ),
        GoRoute(
          path: AppRoutes.savedAddresses,
          builder: (context, state) => const SavedAddressesScreen(),
        ),

        // Booking Flow
        GoRoute(
          path: AppRoutes.cart,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => di.sl<BookingProvider>(),
            child: const CartScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.bookingSummary,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => di.sl<BookingProvider>(),
            child: const BookingSummaryScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.payment,
          builder: (context, state) => const PaymentScreen(),
        ),
      ],
    ),
  ],
);

// ---------------- NAVIGATION EXTENSIONS ----------------

extension AppRouterExtension on BuildContext {
  void goLogin() => go(AppRoutes.login);
  void goOtp(String verificationId) => go('${AppRoutes.otp}/$verificationId');
  void goMain() => go(AppRoutes.main);
  void goHome() => go('${AppRoutes.main}${AppRoutes.home}');
  void goServices() => go(AppRoutes.services);
  void goServiceDetail(String serviceId) =>
      go('${AppRoutes.serviceDetail}/$serviceId');
  void goNewOrder({String serviceName = '', bool isFastTrack = false}) {
    go(
      AppRoutes.newOrder,
      extra: {'serviceName': serviceName, 'isFastTrack': isFastTrack},
    );
  }

  void goOrderTracking() => go(AppRoutes.orderTracking);
  void goOrderHistory() => go(AppRoutes.orderHistory);
  void goOrderDetails(String orderId) =>
      go('${AppRoutes.orderDetails}/$orderId');
  void goOrderPlaced() => go(AppRoutes.orderPlaced);
  void goCart() => go(AppRoutes.cart);
  void goBookingSummary() => go(AppRoutes.bookingSummary);
  void goPayment() => go(AppRoutes.payment);
  void goWallet() => go(AppRoutes.wallet);
  void goProfile() => go(AppRoutes.profile);
  void goEditProfile() => go(AppRoutes.editProfile);
  void goSavedAddresses() => go(AppRoutes.savedAddresses);
  void goSelectLocation() => go(AppRoutes.selectLocation);
  void goConfirmLocation() => go(AppRoutes.confirmLocation);
  void goAddressForm() => go(AppRoutes.addressForm);
}
