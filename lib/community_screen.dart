import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _ScholarshipScreenState();
}

class _ScholarshipScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Community support  Screen")
          ],
        ),
      ),
    );
  }
}