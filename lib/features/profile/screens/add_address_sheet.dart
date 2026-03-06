import 'package:flutter/material.dart';
import 'package:clean_go/core/constants/colors.dart';
import '../widgets/custom_text_field_box.dart';
import '../widgets/address_type_selector.dart';
import '../widgets/bottom_primary_button.dart';
import '../widgets/sheet_handle_bar.dart';

class AddAddressSheet extends StatefulWidget {
  const AddAddressSheet({super.key});

  @override
  State<AddAddressSheet> createState() => _AddAddressSheetState();
}

class _AddAddressSheetState extends State<AddAddressSheet> {
  final houseController = TextEditingController(text: "Plot no.209");
  final landmarkController = TextEditingController();

  String selectedType = "Home";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const SheetHandleBar(),

          /// MAP PREVIEW
          Container(
            height: 120,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade200,
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/map.png",
                    fit: BoxFit.cover,
                  ),
                ),

                const Center(
                  child: Icon(
                    Icons.location_on,
                    size: 30,
                    color: Color(0xff0B3C5D),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// ADDRESS TITLE
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Madhapur, Hyderabad",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),

          const SizedBox(height: 6),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Plot no.209, Kavuri Hills, Madhapur, Telangana 500033\nPh: +91234567890",
                style: TextStyle(fontSize: 13, color: Color(0xff64748B)),
              ),
            ),
          ),

          const SizedBox(height: 12),
          const Divider(),

          const SizedBox(height: 12),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomTextFieldBox(
                    controller: houseController,
                    labelText: "House / Flat Number",
                  ),

                  const SizedBox(height: 14),

                  CustomTextFieldBox(
                    controller: landmarkController,
                    labelText: "Landmark (Optional)",
                  ),

                  const SizedBox(height: 16),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Save as",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),

                  const SizedBox(height: 8),

                  AddressTypeSelector(
                    selectedType: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: BottomPrimaryButton(
              text: "Enter complete address",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
