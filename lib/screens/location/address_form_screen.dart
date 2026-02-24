import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

class AddressFormSheet extends StatefulWidget {
  const AddressFormSheet({super.key});

  @override
  State<AddressFormSheet> createState() => _AddressFormSheetState();
}

class _AddressFormSheetState extends State<AddressFormSheet> {
  String selectedType = "Home";

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff0B3C5D);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LOCATION TITLE
          const Text(
            "Madhapur, Hyderabad",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),

          const SizedBox(height: 4),

          const Text(
            "Bhagya Nagar Colony, Kukatpally, Hyderabad, Telangana",
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 16),
          Divider(color: Colors.grey.shade300),

          const SizedBox(height: 16),

          /// HOUSE NUMBER
          TextField(
            decoration: InputDecoration(
              hintText: "House/Flat Number *",
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// LANDMARK
          TextField(
            decoration: InputDecoration(
              hintText: "Landmark (Optional)",
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// SAVE AS
          const Text("Save as"),

          const SizedBox(height: 8),

          Row(
            children: [
              _typeButton("Home"),
              const SizedBox(width: 10),
              _typeButton("Other"),
            ],
          ),

          const SizedBox(height: 20),

          /// DONE BUTTON
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                onPressed:
                () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.main,
                    (route) => false,
                  );
                };
              },
              child: const Text("Done", style: TextStyle(color: Colors.white)),
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _typeButton(String type) {
    bool selected = selectedType == type;

    return GestureDetector(
      onTap: () => setState(() => selectedType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? const Color(0xff0B3C5D) : Colors.grey.shade300,
          ),
          color: selected ? Colors.blue.shade50 : Colors.transparent,
        ),
        child: Text(
          type,
          style: TextStyle(
            color: selected ? const Color(0xff0B3C5D) : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
