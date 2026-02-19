import 'package:flutter/material.dart';
import 'package:clean_go/widgets/profile_screen_widgets/sheet_handle_bar.dart';
import 'package:clean_go/widgets/profile_screen_widgets/address_map_preview.dart';
import 'package:clean_go/widgets/profile_screen_widgets/address_summary_card.dart';
import 'package:clean_go/widgets/profile_screen_widgets/custom_text_field_box.dart';
import 'package:clean_go/widgets/profile_screen_widgets/address_type_selector.dart';
import 'package:clean_go/widgets/profile_screen_widgets/bottom_primary_button.dart';

class AddAddressSheet extends StatefulWidget {
  const AddAddressSheet({super.key});

  @override
  State<AddAddressSheet> createState() => _AddAddressSheetState();
}

class _AddAddressSheetState extends State<AddAddressSheet> {
  final houseController = TextEditingController(text: 'Plot no.209');
  final landmarkController = TextEditingController();
  String selectedType = 'Home';

  @override
  void dispose() {
    houseController.dispose();
    landmarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SheetHandleBar(),

          const SizedBox(height: 10),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Add Address",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const AddressMapPreview(),

          const SizedBox(height: 20),

          const AddressSummaryCard(),

          const SizedBox(height: 20),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "House/Flat Number *",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 8),

                  CustomTextFieldBox(controller: houseController),

                  const SizedBox(height: 20),

                  const Text(
                    "Landmark (Optional)",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 8),

                  CustomTextFieldBox(controller: landmarkController),

                  const SizedBox(height: 20),

                  const Text(
                    "Save as",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 8),

                  AddressTypeSelector(
                    selectedType: selectedType,
                    onChanged: (value) {
                      setState(() => selectedType = value);
                    },
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          BottomPrimaryButton(
            text: "Enter complete address",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
