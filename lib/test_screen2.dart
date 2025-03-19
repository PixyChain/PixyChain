// import 'package:flutter/material.dart';
// //import 'package:pixy_chain/listen_test.dart';
// import 'package:provider/provider.dart';

// class CandidateListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Candidate List")),
//       body: Consumer<CandidateProvider>(
//         builder: (context, provider, child) {
//           return ListView.builder(
//             itemCount: provider.candidates.length,
//             itemBuilder: (context, index) {
//               final candidate = provider.candidates[index];
//               return ListTile(
//                 title: Text(candidate.name),
//                 subtitle: Text(candidate.school),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.thumb_up, color: candidate.isLiked ? Colors.red : Colors.grey),
//                       onPressed: () {
//                         Provider.of<CandidateProvider>(context, listen: false).toggleLike(index);
//                       },
//                     ),
//                     Text("${candidate.likes}"),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class Candidate {
//   String name;
//   String school;
//   int likes;
//   bool isLiked;

//   Candidate({required this.name, required this.school})
//       : likes = 0,
//         isLiked = false;
// }

// class CandidateProvider extends ChangeNotifier {
//   List<Candidate> candidates = [];

//   void addCandidate(String name, String school) {
//     candidates.add(Candidate(name: name, school: school));
//     notifyListeners();
//   }

//   void toggleLike(int index) {
//     if (candidates[index].isLiked) {
//       candidates[index].likes--;
//     } else {
//       candidates[index].likes++;
//     }
//     candidates[index].isLiked = !candidates[index].isLiked;
//     notifyListeners();
//   }
// }
