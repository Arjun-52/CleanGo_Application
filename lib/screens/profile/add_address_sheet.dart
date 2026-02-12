import 'package:flutter/material.dart';

class AddAddressSheet extends StatefulWidget {
  const AddAddressSheet({super.key});

  @override
  State<AddAddressSheet> createState() => _AddAddressSheetState();
}

class _AddAddressSheetState extends State<AddAddressSheet> {
  final _houseController = TextEditingController(text: 'Plot no.209');
  final _landmarkController = TextEditingController();
  String _selectedType = 'Home';

  @override
  void dispose() {
    _houseController.dispose();
    _landmarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          /// Handle Bar
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          /// Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Row(
              children: [
                Text(
                  "Add Address",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff1F2A44),
                  ),
                ),
                Spacer(),
                Icon(Icons.close, color: Color(0xff64748B)),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// Map View
          Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                /// Map Placeholder
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map, size: 40, color: Color(0xff64748B)),
                        SizedBox(height: 8),
                        Text(
                          "Map View",
                          style: TextStyle(
                            color: Color(0xff64748B),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Location Pin
                const Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Icon(
                      Icons.location_on,
                      size: 40,
                      color: Color(0xff0B3C5D),
                    ),
                  ),
                ),

                /// Location Info
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      "Madhapur, Hyderabad",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff0B3C5D),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// Address Summary
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xff0B3C5D).withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Plot no.209, Kavuri Hills, Madhapur, Telangana 500033",
                  style: TextStyle(fontSize: 14, color: Color(0xff1F2A44)),
                ),
                SizedBox(height: 4),
                Text(
                  "Ph: +91234567890",
                  style: TextStyle(fontSize: 12, color: Color(0xff64748B)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// Form Fields
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// House/Flat Number
                  const Text(
                    "House/Flat Number *",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff1F2A44),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: _houseController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Landmark
                  const Text(
                    "Landmark (Optional)",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff1F2A44),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: _landmarkController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Save As Type
                  const Text(
                    "Save as",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff1F2A44),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      /// Home Option
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedType = 'Home'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _selectedType == 'Home'
                                  ? const Color(0xff0B3C5D)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Text(
                              "Home",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _selectedType == 'Home'
                                    ? Colors.white
                                    : const Color(0xff1F2A44),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      /// Other Option
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedType = 'Other'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _selectedType == 'Other'
                                  ? const Color(0xff0B3C5D)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Text(
                              "Other",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _selectedType == 'Other'
                                    ? Colors.white
                                    : const Color(0xff1F2A44),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          /// Bottom Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.black12)),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0B3C5D),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Enter complete address",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
