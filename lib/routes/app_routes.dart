import 'package:flutter/material.dart';

/// Splash & Auth
import '../screens/splash/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/otp_screen.dart';

/// Location
import '../screens/location/select_location_screen.dart';
import '../screens/location/confirm_location_screen.dart';
import '../screens/location/address_form_screen.dart';

/// Core Screens
import '../screens/home/home_screen.dart';

/// Orders
import '../screens/orders/new_order_screen.dart';
import '../screens/orders/order_tracking_screen.dart';

/// Services
import '../screens/services/service_list_screen.dart';
import '../screens/services/service_detail_screen.dart';

/// Booking
import '../screens/booking/cart_screen.dart';
import '../screens/booking/booking_summary_screen.dart';
import '../screens/booking/payment_screen.dart';

/// Wallet & Profile
import '../screens/wallet/wallet_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/edit_profile_screen.dart';
import '../screens/profile/saved_addresses_screen.dart';

/// Bottom Nav
import '../widgets/bottom_navbar.dart';

class AppRoutes {
  static const String splash = '/';
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
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    otp: (context) => OtpScreen(verificationId: ''),

    selectLocation: (context) => const SelectLocationScreen(),
    confirmLocation: (context) => const ConfirmLocationScreen(),
    addressForm: (context) => const AddressFormSheet(),

    /// Main app with bottom navigation
    main: (context) => const MainScreen(),

    services: (context) => const ServiceListScreen(),
    serviceDetail: (context) => const ServiceDetailScreen(),

    cart: (context) => const CartScreen(),
    bookingSummary: (context) => const BookingSummaryScreen(),
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
    const NewOrderScreen(), // Orders tab
    const OrderTrackingScreen(), // Track tab
    const WalletScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
