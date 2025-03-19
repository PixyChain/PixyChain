import 'package:flutter/material.dart';
import 'package:pixy_chain/about.dart';
import 'package:pixy_chain/contribution.dart';
import 'package:pixy_chain/fund_form.dart';
import 'package:pixy_chain/homepage.dart';
import 'package:pixy_chain/job_app_screen.dart';
import 'package:pixy_chain/master_class_login.dart';
import 'package:pixy_chain/profile.dart';
import 'package:pixy_chain/scholarship_form.dart';
import "package:url_launcher/url_launcher.dart";


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
   final String url = "https://docs.google.com/spreadsheets/d/15alApV-n80--TE-KIbd06_ESKxlfveceqsIvrK8FaCE/edit?usp=sharing";

  Future<void> _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
  List<Map<String, String>> messages = []; // Stores chat messages
  TextEditingController _controller = TextEditingController();

  // Predefined FAQ responses
  Map<String, String> faqResponses = {
    "application decision": "After a careful review of your application,\nan email will be sent via the provided email address.\nReview can take a minimum of 1 month.",
    "update my application": "You can send supplementary documents via this\nemail: frimpongmauricious@gmail.com",
    "application status": "After a careful review of your application,\nan email will be sent via the provided email address.\nReview can take a minimum of 1 month.",
    "updates": "After a careful review of your application,\nan email will be sent via the provided email address.\nReview can take a minimum of 1 month.",
    "decision date": "After a careful review of your application,\nan email will be sent via the provided email address.\nReview can take a minimum of 1 month.\nBut there is no fixed date for the decision ",
    "documents": "Incace you would like to update your application with supplementary documents?\nforward them via this email: frimpongmauricious@gmail.com",
    "documents upload": "Incace you would like to update your application with supplementary documents?\nforward them via this email: frimpongmauricious@gmail.com",
    "payment method":"Upon winnig a scholarship or being granted a fund\na cryto currency would be sent via your wallet address\n",
    "payment":"Upon winnig a scholarship or being granted a fund\na cryto currency would be sent via your wallet address\n",
    "Fund recieve":"Upon winnig a scholarship or being granted a fund\na cryto currency would be sent via your wallet address\n"

  };

  // Function to process user input and get a response
  String getResponse(String userInput) {
    userInput = userInput.toLowerCase(); // Convert to lowercase

    for (var keyword in faqResponses.keys) {
      if (userInput.contains(keyword)) {
        return faqResponses[keyword]!;
      }
    }
    return "We couldn't find an answer to your question.\nPlease contact us via email: mauriciousfrimpong@gmail.com or call +233 531 850 867 for an \nimmediate resolution";
  }

  // Function to handle sending a message
  void sendMessage() {
    String userMessage = _controller.text.trim();
    if (userMessage.isNotEmpty) {
      setState(() {
        messages.add({"sender": "user", "text": userMessage});
        messages.add({"sender": "bot", "text": getResponse(userMessage)});
      });
      _controller.clear(); // Clear input field after sending
    }
  }

  @override
  Widget build(BuildContext context) {
  
    

    return Scaffold(
      appBar: AppBar(
      title: const Text("PixyChain", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),
      
      ),
      centerTitle: true,
      backgroundColor: Colors.white54,

      actions: [
        // IconButton(onPressed: (){
          

        // }, 
        // icon: const Icon(Icons.menu))
        DropdownButton(
          dropdownColor: Colors.black45,
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 10,
          value: " ",
          items: const  [
          DropdownMenuItem(
          
            value: " ",
            child: Text(" "),
          
          ),
          DropdownMenuItem(
            value: "Log in",
            child: Text("Log in as a board member",style: TextStyle(color: Colors.white),),
          
          
          ),
           DropdownMenuItem(
            value: "Log out",
            child: Text("Log out", style: TextStyle(color: Colors.white),),
           
           ),
          // DropdownMenuItem(child: Text("Log in as a board member")),
          // DropdownMenuItem(child: Text("Log in as a board member")),
        
        ], 
        onChanged: (value){
          value=value;
          if(value=="Log out"){
            
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
              return HomePage();
            }));
          }
          if(value=="Log in"){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return  const  Masterloginscreen();
          }));
            
          }

        }),
        IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return ProfileScreen();
          }));
          

        },
         icon: const Icon(Icons.settings))


      ],
    ),
    
    
      backgroundColor: Colors.white,
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15,),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome to PixyChain",
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "PixyChain is a trusted platform that connects people with opportunities. "
                      "From funding community initiatives to offering scholarships, we empower individuals and groups to make a real impact. "
                      "Join us in building a future where contributions, grants, and scholarships drive meaningful change.",
                      style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return const About();
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.shade700,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      child: const Text("Learn More", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                    const SizedBox(height: 20),
                    Image.network(
                      "https://raw.githubusercontent.com/FrimpongMauricious/new_images/main/graduate_enhanced.jpeg",
                      width: 420,
                      height: 340,
                      fit: BoxFit.cover,
                    ),

                  

                    
                    const SizedBox(height: 20,),
                   

  Container(
   width: 440,
  height: 300,
  color: Colors.white,
  child: Column(
    children: [
      Expanded(
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            bool isUser = messages[index]["sender"] == "user";
            return Align(
              alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding:const  EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isUser ? Colors.blue : Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  messages[index]["text"]!,
                  style: TextStyle(color: isUser ? Colors.white : Colors.black),
                ),
              ),
            );
          },
        ),
      ),
      Padding(
        padding:const  EdgeInsets.all(8.0),
        child: Text(
          "We are here for you🥳. Feel free to ask anything that baffles you.\nSample FAQ: 'Application status' ",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800], fontSize: 16),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                controller: _controller,
                decoration:const  InputDecoration(
                  hintText: "Ask a question...",
                  focusColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2
                    )
                  ),
                  border: OutlineInputBorder(
                    
                    borderSide: BorderSide(
                      color: Colors.black
                    ), 
                    
                  
                  ),
                ),
                onSubmitted: (value) => sendMessage(),
              
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.blue,),
              onPressed: sendMessage,
            ),
          ],
        ),
      ),
      const SizedBox(height: 25,),
                        ElevatedButton(onPressed: (){
                          _launchURL();

                        }, 
                        style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.green),
                        child: const Text("View standing", ))
    ],
  ),
),

                  ]
                ),
              ),
            ),

        


                            
                            const SizedBox(width: 20),
                            const SizedBox(height: 15,),
                            Expanded(
                flex: 1,
                child: GridView.count(
                  crossAxisCount: 1,
                  shrinkWrap: true,
                  mainAxisSpacing: 15,
                  childAspectRatio: 2.8,
                  children: [
                    _buildInitiativeCard(
                      context: context,
                      title: "Contributions",
                      description: "Make a donation and impact lives.",
                      icon: Icons.volunteer_activism,
                      color: Colors.green.shade600,
                      navigateTo:  CommunityContributionScreen(),
                    ),
                    _buildInitiativeCard(
                      context: context,
                      title: "Scholarships",
                      description: "Apply for life-changing scholarships.",
                      icon: Icons.school,
                      color: Colors.blue.shade600,
                      navigateTo: ScholarshipApplicationForm(),
                    ),
                    _buildInitiativeCard(
                      context: context,
                      title: "Fund Requests",
                      description: "Submit a grant request.",
                      icon: Icons.monetization_on,
                      color: Colors.orange.shade600,
                      navigateTo:  FundingRequestScreen(),
                    ),
                    _buildInitiativeCard(
                      context: context,
                      title: "Job Applications",
                      description: "Find and apply for jobs easily.",
                      icon: Icons.work,
                      color: Colors.teal.shade600,
                      navigateTo:  JobApplicationForm(),
                    ),

                      
                  ],
                ),
                            ),
                          ],
                        ),
                ),
              );
            
        
      

  }

                     
                

                  
          
          

    
  

  Widget _buildInitiativeCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required Widget navigateTo,
  }) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color, size: 40),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Text(description, style: const TextStyle(fontSize: 13, color: Colors.black54)),
        trailing: Icon(Icons.arrow_forward_ios, color: color),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => navigateTo));
        },
      ),
    );
  }
}
