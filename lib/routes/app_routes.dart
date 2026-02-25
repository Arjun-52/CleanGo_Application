import 'package:flutter/material.dart';

//  Auth
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/otp_screen.dart';

/// Location
import '../features/location/screens/select_location_screen.dart';
import '../features/location/screens/confirm_location_screen.dart';
import '../features/location/screens/address_form_screen.dart';

/// Core Screens
import '../features/home/screens/home_screen.dart';

/// Orders
import '../features/orders/screens/new_order_screen.dart';
import '../features/orders/screens/order_tracking_screen.dart';

/// Services
import '../features/services/screens/service_list_screen.dart';
import '../features/services/screens/service_detail_screen.dart';

/// Booking
import '../features/booking/screens/cart_screen.dart';
import '../features/booking/screens/booking_summary_screen.dart';
import '../features/payment/screens/booking_payment_screen.dart';

/// Wallet & Profile
import '../features/wallet/screens/wallet_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/profile/screens/edit_profile_screen.dart';
import '../features/profile/screens/saved_addresses_screen.dart';

/// Bottom Nav
import '../core/common_widgets/bottom_navbar.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xff0B3C5D),
        unselectedItemColor: Colors.grey,
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
