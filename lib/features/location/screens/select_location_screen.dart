import 'package:clean_go/core/constants/colors.dart';
import 'package:flutter/material.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> allLocations = [
    "Madhapur, Hyderabad",
    "Gachibowli, Hyderabad",
    "Kukatpally, Hyderabad",
    "Hitech City, Hyderabad",
    "Banjara Hills, Hyderabad",
    "Jubilee Hills, Hyderabad",
  ];

  List<String> filteredLocations = [];

  @override
  void initState() {
    super.initState();
    filteredLocations = allLocations;
  }

  void _filterLocations(String query) {
    setState(() {
      filteredLocations = allLocations
          .where(
            (location) => location.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff0B3C5D);

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              /// HEADER
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Select Location",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              /// SEARCH FIELD
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterLocations,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    hintText: "Search your location",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// CURRENT LOCATION
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/confirm-location');
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.my_location, color: primaryColor, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Use Current Location",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Detect automatically using GPS",
                            style: TextStyle(
                              color: AppColors.grey,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Divider(color: Colors.grey.shade300),

              const SizedBox(height: 20),

              /// SEARCH RESULTS
              Expanded(
                child: filteredLocations.isEmpty
                    ? const Center(child: Text("No locations found"))
                    : ListView.builder(
                        itemCount: filteredLocations.length,
                        itemBuilder: (context, index) {
                          final location = filteredLocations[index];
                          return ListTile(
                            leading: const Icon(Icons.location_on_outlined),
                            title: Text(location),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/confirm-location',
                                arguments: location,
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
