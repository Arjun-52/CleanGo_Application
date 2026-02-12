import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'address_form_screen.dart';
import '../home/home_screen.dart';// ✅ Import Home Screen

class ConfirmLocationScreen extends StatelessWidget {
  const ConfirmLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff0B3C5D);

    return Scaffold(
      body: Stack(
        children: [

          /// REAL GOOGLE MAP
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(17.4435, 78.3772),
                zoom: 15,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),

          /// HEADER
          SafeArea(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Confirm Location",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// SEARCH BAR
          Positioned(
            top: 70,
            left: 20,
            right: 20,
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 10),
                  Text(
                    "Search for area, street etc..",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          /// LOCATION PIN CIRCLE
          Center(
            child: Container(
              width: 139,
              height: 139,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0x1A06C167),
                border: Border.all(
                  color: const Color(0xff06C167),
                  width: 1.5,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.location_on,
                  size: 40,
                  color: Colors.red,
                ),
              ),
            ),
          ),

          /// BOTTOM PANEL
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// LOCATION INFO
                  const Row(
                    children: [
                      Icon(Icons.location_on,
                          color: Colors.blueGrey),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hyderabad",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Bhagya Nagar Colony, Kukatpally,\nHyderabad, Telangana",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  /// CONFIRM LOCATION BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // ✅ Navigate to Home Screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const HomeScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Confirm Location",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// ENTER COMPLETE ADDRESS
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor:
                              Colors.transparent,
                          builder: (_) =>
                              AddressFormSheet(),
                        );
                      },
                      child: const Text(
                        "Enter complete address",
                        style: TextStyle(
                            color: primaryColor),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
