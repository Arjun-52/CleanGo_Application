import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/home_content.dart';
import 'package:clean_go/features/location/providers/location_provider.dart';
import 'package:clean_go/features/orders/providers/order_provider.dart';
import 'package:clean_go/features/booking/providers/booking_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<LocationProvider>().loadAddresses();
      context.read<OrderProvider>().loadActiveOrders();
      context.read<BookingProvider>().loadServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: HomeContent());
  }
}
