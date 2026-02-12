import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff0B3C5D);

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Container(
                height: 69,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.home_outlined),
                        SizedBox(width: 6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Home",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.keyboard_arrow_down, size: 18),
                              ],
                            ),
                            Text(
                              "Madhapur, Hyderabad...",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        const Icon(Icons.notifications_none, size: 26),
                        Positioned(
                          right: 3,
                          top: 3,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// HELLO
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, John!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Fresh clothes, delivered with care",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              /// FAST TRACK
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF008847),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.flash_on, color: Colors.green),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Fast track Mode",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Same-day delivery available!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),

              /// ACTIVE ORDER TITLE
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Text(
                  "Active Order",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),

              /// ACTIVE ORDER CARD (FIXED)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.inventory_2,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "CLN-2026-001",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Processing",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 14,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "On Track",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      LinearProgressIndicator(
                        value: 0.6,
                        color: Colors.green,
                        backgroundColor: Colors.grey.shade300,
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Step 4 of 7",
                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 12),

                      /// DELIVERY INFO
                      Row(
                        children: const [
                          Icon(Icons.access_time, size: 16, color: Colors.grey),
                          SizedBox(width: 6),
                          Text(
                            "Delivery by • ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            "Feb 28, 03:00 PM",
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "-02h - 21m",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// SERVICES TITLE
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Text(
                  "Services",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),

              /// SERVICES GRID
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 161 / 130,
                  children: [
                    ServiceTile(
                      icon: Icons.checkroom,
                      iconColor: Color(0xFF0C8F83),
                      title: "Wash & Iron",
                      subtitle: "Complete care",
                    ),
                    ServiceTile(
                      icon: Icons.local_laundry_service,
                      iconColor: Color(0xFFFFA000),
                      title: "Iron Only",
                      subtitle: "Crisp finish",
                    ),
                    ServiceTile(
                      icon: Icons.auto_awesome,
                      iconColor: Color(0xFF083B66),
                      title: "Dry Clean",
                      subtitle: "Premium care",
                    ),
                    ServiceTile(
                      icon: Icons.checkroom,
                      iconColor: Color(0xFF083B66),
                      title: "Wash & Fold",
                      subtitle: "Quick service",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const ServiceTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/select-location'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(subtitle, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
