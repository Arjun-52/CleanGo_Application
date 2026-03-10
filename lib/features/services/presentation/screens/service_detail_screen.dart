import 'package:clean_go/features/services/presentation/widgets/service_header_card.dart';
import 'package:clean_go/features/services/presentation/widgets/service_item_list.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/common_widgets/custom_button.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Service Details')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                ServiceHeaderCard(),
                SizedBox(height: 16),

                Text(
                  'Select Items',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 12),

                ServiceItemList(),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: CustomButton(
              text: AppStrings.addToCart,
              onPressed: () => Navigator.pushNamed(context, '/cart'),
            ),
          ),
        ],
      ),
    );
  }
}
