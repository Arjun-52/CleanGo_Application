import 'package:clean_go/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  OtpScreen({super.key, required this.verificationId}) {
    print(
      "DEBUG: OtpScreen constructor called with verificationId: $verificationId",
    );
  }

  @override
  State<OtpScreen> createState() {
    print("DEBUG: OtpScreen createState called");
    return _OtpScreenState();
  }
}

class _OtpScreenState extends State<OtpScreen> {
  // ignore: unused_field
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    print("DEBUG: _OtpScreenState initState called");
    print("DEBUG: Verification ID from widget: ${widget.verificationId}");
  }

  void moveNext(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }
  }

  String getOtp() => controllers.map((c) => c.text).join();

  void verifyOtp() async {
    String otp = getOtp();

    if (otp.length != 6) {
      showError("Enter valid OTP");
      return;
    }

    print("DEBUG: OTP entered: $otp");
    setState(() => isLoading = true);

    /// TEMPORARY BYPASS FOR TESTING - Remove this when Firebase is configured
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => isLoading = false);
        print("DEBUG: Bypass - Navigating to main screen");
        Navigator.pushReplacementNamed(context, AppRoutes.main);
      }
    });

    /// COMMENTED OUT UNTIL FIREBASE IS CONFIGURED
    /*
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      setState(() => isLoading = false);

      Navigator.pushReplacementNamed(context, AppRoutes.main);
    } catch (e) {
      setState(() => isLoading = false);
      showError("Invalid OTP");
    }
    */
  }

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Widget otpBox(int index) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xff0B3C5D), width: 2),
          ),
        ),
        onChanged: (value) => moveNext(index, value),
      ),
    );
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
            children: [
              const SizedBox(height: 10),

              /// Header
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "OTP Verification",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              const SizedBox(height: 80),

              /// Message
              const Text(
                "We have sent a verification code to",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "+91 9347830977",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 40),

              /// Enter code text
              const Text(
                "Enter the Code",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 30),

              /// OTP boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, otpBox),
              ),

              const SizedBox(height: 40),

              /// Continue button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: isLoading ? null : verifyOtp,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 25),

              /// Resend OTP
              const Text(
                "Didn’t receive the OTP? Resend OTP",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
