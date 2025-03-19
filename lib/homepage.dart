import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pixy_chain/loginscreen.dart';
import 'package:pixy_chain/verification.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? selectedDate;
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showError("All fields are required.");
      return;
    }
    if (password != confirmPassword) {
      _showError("Passwords do not match.");
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.sendEmailVerification();
        
        _showSuccess("Verification email sent! Please verify before logging in.");
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return const  Verification();
        }));
      }
    } catch (e) {
      _showError(e.toString());
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
    ));
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Crypto Scholarships & Jobs'),
      //   centerTitle: true,
      // ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://raw.githubusercontent.com/FrimpongMauricious/new_images/main/webImage.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85), // Slight transparency for better readability
                  borderRadius: BorderRadius.circular(20),
                ),
                width: MediaQuery.of(context).size.width * 0.9, // Reduce form width
                constraints: const BoxConstraints(maxWidth: 500), // Limit max width
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome to Crypto Scholarship & Jobs!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Contribute cryptocurrency to support scholarships or find job opportunities!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 20),

                    // First & Last Name
                    const Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: 150,
                            child: TextField(
                              style: TextStyle(
                                fontWeight:FontWeight.bold,
                                fontSize: 16
                              ),
                              decoration:  InputDecoration(
                                labelText: 'First Name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: 150,
                            child: TextField(
                              style: TextStyle(
                                fontWeight:FontWeight.bold,
                                fontSize: 16
                              ),
                              decoration:  InputDecoration(
                                labelText: 'Last Name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Date of Birth & Gender
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: 150,
                            child: TextField(
                              style:const  TextStyle(
                                fontWeight:FontWeight.bold,
                                fontSize: 16
                              ),
                              controller: dobController,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Date of Birth',
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () => _selectDate(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            width: 150,
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Gender',
                                border: OutlineInputBorder(),
                              ),
                              items: ['Male', 'Female', 'Other'].map((String gender) {
                                return DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(gender),
                                );
                              }).toList(),
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Email & Phone Number
                    Column(
                      children: [
                        TextField(
                          style:const  TextStyle(
                                fontWeight:FontWeight.bold,
                                fontSize: 16
                              ),
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const TextField(
                          style: TextStyle(
                                fontWeight:FontWeight.bold,
                                fontSize: 16
                              ),
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Country & City
                    const Column(
                      children: [
                        TextField(
                          style: TextStyle(
                                fontWeight:FontWeight.bold,
                                fontSize: 16
                              ),
                          decoration:  InputDecoration(
                            labelText: 'Country',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          style: TextStyle(
                                fontWeight:FontWeight.bold,
                                fontSize: 16
                              ),
                          decoration: InputDecoration(
                            labelText: 'City',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Password & Confirm Password
                    Column(
                      children: [
                        TextField(
                          
                         style: const TextStyle(
                                fontWeight:FontWeight.bold,
                                fontSize: 16
                              ),
                          controller: passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                        
                            labelText: 'Password',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          style: const TextStyle(
                                fontWeight:FontWeight.bold,
                                fontSize: 16
                              ),
                          controller: confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          decoration: InputDecoration(
                            
                            labelText: 'Confirm Password',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Sign Up Button
                    ElevatedButton(
                      onPressed: _signUp,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
                      child: const Text('Sign Up ', style: TextStyle(color: Colors.white),),
                    ),
                    const SizedBox(height: 10),

                    // Log in Link
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const  Myloginscreen())),
                      child: const Text("Already have an account? Log in", style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
