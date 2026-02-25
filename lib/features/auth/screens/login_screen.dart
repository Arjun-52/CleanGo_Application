import 'package:clean_go/routes/app_routes.dart' show AppRoutes;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/constants/colors.dart';
import '../../../core/common_widgets/custom_button.dart';
// ignore: unused_import
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  // ignore: unused_field
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  /// Validate phone number
  bool _isValidPhoneNumber(String phoneNumber) {
    phoneNumber = phoneNumber.replaceAll(' ', '');

    if (phoneNumber.length != 10) return false;
    if (!RegExp(r'^[6-9]').hasMatch(phoneNumber)) return false;
    if (!RegExp(r'^\d+$').hasMatch(phoneNumber)) return false;

    return true;
  }

  /// Send OTP using Firebase
  void _sendOtp() async {
    if (_isLoading) return;

    String phoneNumber = _phoneController.text.trim();
    print("DEBUG: Phone number entered: $phoneNumber");

    if (!_isValidPhoneNumber(phoneNumber)) {
      print("DEBUG: Invalid phone number");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter valid number'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    print("DEBUG: Starting OTP verification for +91$phoneNumber");
    setState(() => _isLoading = true);

    /// TEMPORARY BYPASS FOR TESTING - Remove this when Firebase is configured
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
        print("DEBUG: Bypass - Navigating to OTP screen");
        Navigator.pushNamed(
          context,
          AppRoutes.otp,
          arguments: "test-verification-id",
        );
      }
    });

    /// COMMENTED OUT UNTIL FIREBASE IS CONFIGURED
    /*
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        timeout: const Duration(seconds: 60),

        verificationCompleted: (PhoneAuthCredential credential) async {
          print("DEBUG: Auto-verification completed");
          setState(() => _isLoading = false);
          await _auth.signInWithCredential(credential);
        },

        verificationFailed: (FirebaseAuthException e) {
          print("OTP ERROR: ${e.code} - ${e.message}");
          setState(() => _isLoading = false);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("OTP Failed: ${e.message ?? "Unknown error"}")),
          );
        },

        codeSent: (String verificationId, int? resendToken) {
          print("DEBUG: Code sent successfully. Verification ID: $verificationId");
          setState(() => _isLoading = false);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OtpScreen(verificationId: verificationId),
            ),
          );
        },

        codeAutoRetrievalTimeout: (verificationId) {
          print("DEBUG: Auto retrieval timeout");
          setState(() => _isLoading = false);
        },
      );
    } catch (e) {
      print("DEBUG: Exception in verifyPhoneNumber: $e");
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.checkroom,
                  color: Colors.white,
                  size: 40,
                ),
              ),

              const SizedBox(height: 20),

              /// App Name
              const Text(
                'CleanGo',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 12),

              /// Login Title
              SizedBox(
                width: 200,
                height: 36,
                child: Center(
                  child: Text(
                    'Login or Sign Up',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 48),

              /// Phone Input
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Text('🇮🇳', style: TextStyle(fontSize: 20)),
                          SizedBox(width: 8),
                          Text(
                            '+91',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          hintText: 'Phone Number',
                          border: InputBorder.none,
                          counterText: "",
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// Continue Button
              CustomButton(
                text: _isLoading ? "Sending OTP..." : 'Continue',
                onPressed: _sendOtp,
              ),

              const Spacer(flex: 3),

              /// Footer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text.rich(
                  TextSpan(
                    text: 'By continuing, you agree our ',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    children: const [
                      TextSpan(
                        text: 'Terms and Conditions',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(text: ' & '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
