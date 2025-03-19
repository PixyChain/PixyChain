import "package:flutter/material.dart";
import "package:pixy_chain/homepage.dart";
import "package:pixy_chain/main_screen.dart";
//import "package:pixy_chain/main_screen.dart";
import "package:pixy_chain/super_users_screen.dart";
class Masterloginscreen extends StatefulWidget {
 const  Masterloginscreen({super.key});

  @override
  _MyloginscreenState createState() => _MyloginscreenState();
}

class _MyloginscreenState extends State<Masterloginscreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<void> _login() async {
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );

  //     User? user = userCredential.user;
  //     if (user != null && user.emailVerified) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => MainScreen()),
  //       );
  //     } else {
  //       user?.sendEmailVerification();
  //       ScaffoldMessenger.of(context).showSnackBar(
  //        const  SnackBar(content: Text("Please verify your email and log in.")),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Login failed: ${e.toString()}")),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://raw.githubusercontent.com/FrimpongMauricious/new_images/main/web_3_b.jpg"
,
            ),
            fit: BoxFit.cover, // Ensure the image covers the full screen
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Container(
              //color: Colors.white70,
              width: 400,
              padding:const  EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white54.withOpacity(0.5), // Light background for text readability
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    enableSuggestions: true,
                    style: const TextStyle(
                                fontWeight:FontWeight.bold,
                                fontSize: 16
                              ),
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                      ),
                    ),
                  ),
                 const  SizedBox(height: 15),
                  TextField(
                    style: const TextStyle(
                                fontWeight:FontWeight.bold,
                                fontSize: 16
                              ),
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                 const  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed:(){
                      if(emailController.text=="mauriciousfrimpong@gmail.com"&& passwordController.text=="FAKADOSKY"){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){

                         return  BoardVoteScreen();
                        })
                        );
                      }
                    else if(emailController.text=="starblade1111@gmail.com"&& passwordController.text=="pixychain1234"){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                          return BoardVoteScreen();
                        })
                        );

                      }
                      else if(emailController.text=="christabelbenewaah@gmail.com" && passwordController.text=="Cbenewaa"){
                         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                          return BoardVoteScreen();
                        })
                        );

                      }
                      else if(emailController.text=="meshacknartey@gmail.com" && passwordController.text=="ASHER"){
                         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                          return BoardVoteScreen();
                        })
                        );
                        

                      }
                      else{
                         ScaffoldMessenger.of(context).showSnackBar(
                        const  SnackBar(content: Text("Please you are not a super use so cannot log in as a board member",
                         style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),)));
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                          return const MainScreen();
                        }));
                      }


                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Login"),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const  Text("Don't have an account? ",
                          style: TextStyle(color: Colors.black, fontSize: 11)),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: Text(
                          "Create account",
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
