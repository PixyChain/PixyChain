import 'package:flutter/material.dart';



// class ChatBotScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ChatScreen(),
//     );
//   }
// }

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, String>> messages = []; // Stores chat messages
  TextEditingController _controller = TextEditingController();

  // Predefined FAQ responses
  Map<String, String> faqResponses = {
    "application decision": "After a careful review of your application,\n n email will be sent via the provided email address.\nReview can take a minimum of 1 month.",
    "update my application": "You can send supplementary documents via this\nemail: frimpongmauricious@gmail.com",
    "application status": "After a careful review of your application,\n n email will be sent via the provided email address.\nReview can take a minimum of 1 month.",
    "updates": "After a careful review of your application,\nan email will be sent via the provided email address.\nReview can take a minimum of 1 month.",
    "decision date": "After a careful review of your application,\nan email will be sent via the provided email address.\nReview can take a minimum of 1 month.\nBut there is no fixed date for the decision ",
    "documents": "Incace you would like to update your application with supplementary documents?\nforward them via this email: frimpongmauricious@gmail.com",
    "documents upload": "Incace you would like to update your application with supplementary documents?\nforward them via this email: frimpongmauricious@gmail.com",
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
      backgroundColor: Colors.grey,
      //appBar: AppBar(title: Text("AI Chat Support")),
      body: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(45)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(45)),
              child: Container(
                color: Colors.white,
                
                width: 500,
                height: 670,
                
                child: Column(
                  children: [
                    Expanded(
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
                                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                    padding: EdgeInsets.all(12),
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
                          // FAQ Suggestion at the Bottom
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "We are here for you🥳. Feel free to ask anything that baffles you.\n Sample FAQ: Application status",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700], fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            
                            child: TextField(
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              controller: _controller,
                              decoration: InputDecoration(
                                
                                hintText: "Ask a question...",
                                border: OutlineInputBorder(),
                              ),
                              onSubmitted: (value)=> sendMessage(),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            onPressed: sendMessage,
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
