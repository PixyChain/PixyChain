import 'package:flutter/material.dart';

class ContributionScreen extends StatefulWidget {
  const ContributionScreen({super.key});

  @override
  State<ContributionScreen> createState() => _ScholarshipScreenState();
}

class _ScholarshipScreenState extends State<ContributionScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Contribution Screen")
          ],
        ),
      ),
    );
  }
}