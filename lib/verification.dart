import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pixy_chain/main_screen.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  int _secondsRemaining = 60;
  late Timer _timer;
  bool _canResend = false;
  bool _isEmailVerified = false; // Track email verification status
  late Timer _emailCheckTimer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _checkEmailVerified(); // Initial check
    _startEmailVerificationChecker(); // Start periodic email check
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        _timer.cancel();
      }
    });
  }

  void _startEmailVerificationChecker() {
    _emailCheckTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      await _checkEmailVerified();
    });
  }

  Future<void> _checkEmailVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload(); // Refresh user data
    if (user != null && user.emailVerified) {
      setState(() {
        _isEmailVerified = true;
      });
      _emailCheckTimer.cancel(); // Stop checking once verified
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()), // Navigate to MainScreen
      );
    }
  }

  void _resendEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
      setState(() {
        _secondsRemaining = 60;
        _canResend = false;
      });
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _emailCheckTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                """You have been sent an account verification email.\nVerify your account and come back to sign in.""",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Login Button (Only enabled if verified)
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: _isEmailVerified ? Colors.green : Colors.grey,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: _isEmailVerified
                    ? () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const MainScreen()),
                        );
                      }
                    : null, // Disabled if not verified
                child: const Text("Continue to Main Screen"),
              ),

              const SizedBox(height: 20),

              // Resend Email Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive email? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: _canResend ? _resendEmail : null,
                    child: Text(
                      _canResend ? "Resend email" : "Resend email ($_secondsRemaining s)",
                      style: TextStyle(
                        color: _canResend ? Colors.green : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
