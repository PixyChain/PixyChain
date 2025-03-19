import 'package:flutter/material.dart';
import 'package:pixy_chain/main_screen.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40,),
           const  Text("""
                      PixyChain is a trusted platform that connects people with opportunities.
                      From funding community initiatives to offering scholarships, we empower 
                      individuals and groups to make a real impact. 
                      This platform was engineered by Mauricious Frimpong, Christabel Benewaah,
                      Meshack Nartey Kwame and Benjamin to bring like minded people together
                      On this platform, People can donate, request for funds to materialize 
                      their timeless societal innovation, and apply for scholarships and jobs
                      Organizations or individuals donated money in the form crypto currency.
                      This money collected are used to carry out all these charities stated earlier on.
                       On PixyChain, a pessewa is worth while
                      Join us in building a future where contributions, grants, and scholarships 
                      drive meaningful change.""",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                      const SizedBox(height: 20,),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue

                      ),
                      onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                        return const MainScreen();
                      }));


                    }, child: const Text("Done"))
          ],
        ),
      ),
    );
  }
}