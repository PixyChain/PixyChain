
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'test_screen2.dart';

// // void main() {
// //   runApp(ChangeNotifierProvider(
// //     create: (context) => CandidateProvider(),
// //     child: MyApp(),
// //   ));
// // }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SubmitScreen(),
//     );
//   }
// }

// class SubmitScreen extends StatelessWidget {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController schoolController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Submit Candidate")),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(controller: nameController, decoration: InputDecoration(labelText: "Enter Name")),
//             SizedBox(height: 10),
//             TextField(controller: schoolController, decoration: InputDecoration(labelText: "Enter School")),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 if (nameController.text.isNotEmpty && schoolController.text.isNotEmpty) {
//                   Provider.of<CandidateProvider>(context, listen: false).addCandidate(
//                     nameController.text,
//                     schoolController.text,
//                   );
//                   nameController.clear();
//                   schoolController.clear();
//                 }
//               },
//               child: Text("Submit"),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => CandidateListScreen()),
//               ),
//               child: Text("View Candidates"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// } 

