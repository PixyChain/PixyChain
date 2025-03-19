import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';




class BoardVoteScreen extends StatefulWidget {
  @override
  State<BoardVoteScreen> createState() => _BoardVoteScreenState();
}

class _BoardVoteScreenState extends State<BoardVoteScreen> {
  final String voteUrl = "https://forms.gle/ipeho4DhifpwZ3HGA";
 // https://forms.gle/ipeho4DhifpwZ3HGA

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(voteUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $voteUrl";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("Board Members Panel"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.how_to_vote,
                    size: 80,
                    color: Colors.blueAccent,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Welcome, Board Member!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Click the button below to cast your vote.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _launchURL,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Vote Now"),
                    ),
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