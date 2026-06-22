import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/colors.dart';
import '../providers/qr_scan_provider.dart';
import '../providers/states/qr_scan_state.dart';
import 'qr_order_details_screen.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _qrController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _scanAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QrScanProvider>().reset();
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _qrController.dispose();
    super.dispose();
  }

  Future<void> _handleScan(String code) async {
    if (code.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter or select a QR code")),
      );
      return;
    }

    final provider = context.read<QrScanProvider>();
    final success = await provider.scanQrCode(code.trim());

    if (success && mounted) {
      final state = provider.state;
      if (state is QrScanSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QrOrderDetailsScreen(order: state.orderDetails),
          ),
        );
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.error ?? "Failed to scan QR code"),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final qrScanProvider = context.watch<QrScanProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Scan Packet QR",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Point the camera at the QR code on the laundry packet",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 30),

              // Scanner view simulation box
              Center(
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white54, width: 2),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Stack(
                    children: [
                      // Scanner overlay simulation corners
                      Positioned(
                        top: 20,
                        left: 20,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Color(0xFF00C8FF), width: 4),
                              left: BorderSide(color: Color(0xFF00C8FF), width: 4),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Color(0xFF00C8FF), width: 4),
                              right: BorderSide(color: Color(0xFF00C8FF), width: 4),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Color(0xFF00C8FF), width: 4),
                              left: BorderSide(color: Color(0xFF00C8FF), width: 4),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Color(0xFF00C8FF), width: 4),
                              right: BorderSide(color: Color(0xFF00C8FF), width: 4),
                            ),
                          ),
                        ),
                      ),

                      // QR Code image / icon in center
                      const Center(
                        child: Icon(
                          Icons.qr_code_scanner_outlined,
                          size: 100,
                          color: Colors.white24,
                        ),
                      ),

                      // Animating scan line
                      AnimatedBuilder(
                        animation: _scanAnimation,
                        builder: (context, child) {
                          return Positioned(
                            top: 40 + (_scanAnimation.value * 200),
                            left: 40,
                            right: 40,
                            child: Container(
                              height: 3,
                              decoration: const BoxDecoration(
                                color: Color(0xFF00C8FF),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF00C8FF),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      // Loading indicator overlay
                      if (qrScanProvider.isLoading)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00C8FF)),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  "Fetching Order...",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Simulation Quick Action Buttons
              const Text(
                "Test Presets:",
                style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 13),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.center,
                children: [
                  ActionChip(
                    backgroundColor: Colors.blueGrey[900],
                    label: const Text(
                      "Valid Test QR",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: qrScanProvider.isLoading
                        ? null
                        : () {
                            _qrController.text = "QR-ORD-8924-abc123";
                            _handleScan("QR-ORD-8924-abc123");
                          },
                  ),
                  ActionChip(
                    backgroundColor: Colors.blueGrey[900],
                    label: const Text(
                      "Invalid QR",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: qrScanProvider.isLoading
                        ? null
                        : () {
                            _qrController.text = "INVALID-QR-CODE";
                            _handleScan("INVALID-QR-CODE");
                          },
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Divider(color: Colors.white24),
              const SizedBox(height: 16),

              // Manual text input
              TextField(
                controller: _qrController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Enter QR Code Text Manually",
                  labelStyle: const TextStyle(color: Colors.white54),
                  hintText: "e.g. QR-ORD-8924-abc123",
                  hintStyle: const TextStyle(color: Colors.white24),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white24),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF00C8FF)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.white54),
                    onPressed: () => _qrController.clear(),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Submit/Scan button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF013E6D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: qrScanProvider.isLoading
                      ? null
                      : () => _handleScan(_qrController.text),
                  child: qrScanProvider.isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          "Submit QR Code",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
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
