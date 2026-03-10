import 'package:clean_go/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clean_go/core/di/injection.dart' as di;

import '../features/location/presentation/providers/location_provider.dart';
import '../features/booking/presentation/providers/booking_provider.dart';
import '../features/orders/presentation/providers/order_provider.dart';
import '../features/orders/presentation/providers/new_order_provider.dart';
import '../features/home/presentation/providers/notification_provider.dart';
import '../features/wallet/presentation/providers/wallet_provider.dart';

// Auth
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/otp_screen.dart';

/// Location
import '../features/location/presentation/screens/select_location_screen.dart';
import '../features/location/presentation/screens/confirm_location_screen.dart';
import '../features/location/presentation/screens/address_form_screen.dart';

/// Core Screens
import '../features/home/presentation/screens/home_screen.dart';

/// Orders
import '../features/orders/presentation/screens/new_order_screen.dart';
import '../features/orders/presentation/screens/order_tracking_screen.dart';

/// Services
import '../features/services/presentation/screens/service_list_screen.dart';
import '../features/services/presentation/screens/service_detail_screen.dart';

/// Booking
import '../features/booking/presentation/screens/cart_screen.dart';
import '../features/booking/presentation/screens/booking_summary_screen.dart';
import '../features/payment/presentation/screens/booking_payment_screen.dart';

/// Wallet & Profile
import '../features/wallet/presentation/screens/wallet_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/profile/presentation/screens/edit_profile_screen.dart';
import '../features/profile/presentation/screens/saved_addresses_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String otp = '/otp';

  static const String selectLocation = '/select-location';
  static const String confirmLocation = '/confirm-location';
  static const String addressForm = '/address-form';

  static const String main = '/main';

  static const String services = '/services';
  static const String serviceDetail = '/service-detail';

  static const String cart = '/cart';
  static const String bookingSummary = '/booking-summary';
  static const String payment = '/payment';

  static const String editProfile = '/edit-profile';
  static const String savedAddresses = '/saved-addresses';

  static Map<String, WidgetBuilder> get routes => {
    login: (context) => const LoginScreen(),
    otp: (context) {
      final verificationId =
          ModalRoute.of(context)!.settings.arguments as String;

      return OtpScreen(verificationId: verificationId);
    },

    selectLocation: (context) => ChangeNotifierProvider(
      create: (_) => di.sl<LocationProvider>(),
      child: const SelectLocationScreen(),
    ),
    confirmLocation: (context) => ChangeNotifierProvider(
      create: (_) => di.sl<LocationProvider>(),
      child: const ConfirmLocationScreen(),
    ),
    addressForm: (context) => ChangeNotifierProvider(
      create: (_) => di.sl<LocationProvider>(),
      child: const AddressFormSheet(),
    ),

    /// Main app with bottom navigation
    main: (context) => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<BookingProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<OrderProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<NotificationProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<LocationProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<NewOrderProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<WalletProvider>()),
      ],
      child: const MainScreen(),
    ),

    services: (context) => const ServiceListScreen(),
    serviceDetail: (context) => const ServiceDetailScreen(),

    cart: (context) => ChangeNotifierProvider(
      create: (_) => di.sl<BookingProvider>(),
      child: const CartScreen(),
    ),
    bookingSummary: (context) => ChangeNotifierProvider(
      create: (_) => di.sl<BookingProvider>(),
      child: const BookingSummaryScreen(),
    ),
    payment: (context) => const PaymentScreen(),

    editProfile: (context) => const EditProfileScreen(),
    savedAddresses: (context) => const SavedAddressesScreen(),
  };
}

/// ---------------- MAIN SCREEN ----------------

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const NewOrderScreen(
      serviceName: 'wash and iron',
      isFastTrack: false,
    ), // Orders tab
    OrderTrackingScreen(), // Track tab
    const WalletScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xff0B3C5D),
        unselectedItemColor: AppColors.grey,
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
