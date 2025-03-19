import 'package:flutter/material.dart';

class GrantFundScreen extends StatefulWidget {
  const GrantFundScreen({super.key});

  @override
  State<GrantFundScreen> createState() => _ScholarshipScreenState();
}

class _ScholarshipScreenState extends State<GrantFundScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(60.0),
        child: Center(
          child: Column(
            children: [
              Text("Request for an initiative Fund")
            ],
          ),
        ),
      ),
    );
  }
}