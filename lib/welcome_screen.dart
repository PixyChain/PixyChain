import 'package:flutter/material.dart';
//import 'package:pixy_chain/homepage.dart';
import 'package:pixy_chain/loginscreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image from URL (Updated)
          Positioned.fill(
            child: Image.network(
              'https://raw.githubusercontent.com/FrimpongMauricious/new_images/main/welcome_image.webp',
              fit: BoxFit.cover,
            ),
          ),

          // Dark Overlay to Enhance Text Readability
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),

          // Scrollable Content
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome to PixyChain",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                const Text(
                  """
🚀 Welcome to PixyChain! 🎉

We’re thrilled to have you here! PixyChain is the ultimate platform where like-minded individuals come together to collaborate, support, and grow as a community. 

Whether you are looking to connect with others, contribute to meaningful causes, or explore academic opportunities, this platform is designed to empower you.

At PixyChain, we believe in the power of collective support. You have the opportunity to donate and make a difference in the lives of those in need. 

Your contributions can go a long way in supporting the community, funding important initiatives, and helping individuals achieve their dreams.
                  """,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                // Continue Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return const  Myloginscreen();
                      }),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Get started",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
