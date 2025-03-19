import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import "package:url_launcher/url_launcher.dart";

class ScholarshipApplicationForm extends StatefulWidget {
  @override
  _ScholarshipApplicationFormState createState() => _ScholarshipApplicationFormState();
}

class _ScholarshipApplicationFormState extends State<ScholarshipApplicationForm> {

  final String url = "https://docs.google.com/spreadsheets/d/15alApV-n80--TE-KIbd06_ESKxlfveceqsIvrK8FaCE/edit?usp=sharing";

  Future<void> _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController essayController = TextEditingController();
  String? selectedEducationLevel;

  File? resumeFile;
  File? transcriptFile;

  Future<void> pickFile(String fileType) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          if (fileType == "resume") resumeFile = File(result.files.single.path!);
          if (fileType == "transcript") transcriptFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  Widget buildFileUploadSection(String label, File? file, VoidCallback onPick) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style:const  TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 5),
        ElevatedButton.icon(
          
          onPressed: onPick,
          
          icon: const Icon(Icons.upload_file),
          label: Text("Upload $label"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
          ),
        ),
        if (file != null)
          ListTile(
            leading: const Icon(Icons.insert_drive_file, color: Colors.green),
            title: Text(file.path.split('/').last, overflow: TextOverflow.ellipsis),
          ),
       const  Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: AppBar(title: Text("Scholarship Application"), backgroundColor: Colors.blueAccent),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const  Text(
                    "Scholarship Opportunities",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Scholarships provide financial support to students who may otherwise struggle to afford education. They help reduce financial burdens, allowing students to focus on academic and personal growth. Obtaining a scholarship can open doors to better career opportunities and create a pathway for success.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Image.network(
                    "https://raw.githubusercontent.com/FrimpongMauricious/new_images/main/graduate_enhanced.jpeg",
                    width: 300,  // Increased width
                    height: 250, // Increased height
                    fit: BoxFit.cover,
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
          ),
          const SizedBox(width: 10,),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding:const  EdgeInsets.all(18),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Personal Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                           const  SizedBox(height: 10),
                            SizedBox(
                              width: 450, // Reduced width
                              child: TextFormField(
                                controller: firstNameController,
                                decoration: InputDecoration(
                                  labelText: "First Name",
                                  prefixIcon:const  Icon(Icons.person),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                style:  const TextStyle(fontSize: 14),
                                maxLength: 20,
                              ),
                            ),
                           const  SizedBox(height: 10),
                            SizedBox(
                              width: 450, // Reduced width
                              child: TextFormField(
                                controller: lastNameController,
                                decoration: InputDecoration(
                                  labelText: "Last Name",
                                  prefixIcon: const Icon(Icons.person_outline),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                style: const TextStyle(fontSize: 14),
                                maxLength: 20,
                              ),
                            ),
                           const  SizedBox(height: 10),
                            SizedBox(
                              width: 450, // Reduced width
                              child: TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "Email Address",
                                  prefixIcon:const  Icon(Icons.email),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                style:const  TextStyle(fontSize: 14),
                                maxLength: 30,
                              ),
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                              width: 450, // Reduced width
                              child: TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "Wallet address",
                                  prefixIcon:const  Icon(Icons.email),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                style:const  TextStyle(fontSize: 14),
                                maxLength: 30,
                              ),
                            ),
                           const  SizedBox(height: 10),
                            SizedBox(
                              width: 450, // Reduced width
                              child: DropdownButtonFormField<String>(
                                value: selectedEducationLevel,
                                decoration: InputDecoration(
                                  labelText: "Current Level of Education",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                items: ["Undergraduate", "Master's", "PhD"].map((level) {
                                  return DropdownMenuItem(
                                    value: level,
                                    child: Text(level, style:const TextStyle(fontSize: 14)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedEducationLevel = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                   const  SizedBox(height: 20),
                    buildFileUploadSection("Resume", resumeFile, () => pickFile("resume")),
                    buildFileUploadSection("Transcript", transcriptFile, () => pickFile("transcript")),
                    const SizedBox(height: 13,),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.green),
                        onPressed: (){}, 
                      child: const Text("Submit Application")),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
