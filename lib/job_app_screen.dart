

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class JobApplicationForm extends StatefulWidget {
  @override
  _JobApplicationFormState createState() => _JobApplicationFormState();
}

class _JobApplicationFormState extends State<JobApplicationForm> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController fieldOfStudyController = TextEditingController();
  final TextEditingController linkedInController = TextEditingController();
 final TextEditingController email_controler = TextEditingController();
  File? resumeFile;
  File? supportingFile;
  bool isSubmitted = false; // Flag to disable inputs after submission

  Future<void> pickFile(String fileType) async {
    if (isSubmitted) return; // Prevent picking files after submission

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          if (fileType == "resume") resumeFile = File(result.files.single.path!);
          if (fileType == "supporting") supportingFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  void submitApplication() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        fieldOfStudyController.text.isEmpty ||
        linkedInController.text.isEmpty ||
        resumeFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill all required fields and upload your resume."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Application Submitted"),
          content: Text("Thank you for applying! Our board members will review your application."),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  // Disable input fields and reset values
                  isSubmitted = true;
                  firstNameController.clear();
                  lastNameController.clear();
                  fieldOfStudyController.clear();
                  linkedInController.clear();
                  resumeFile = null;
                  supportingFile = null;
                });
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Widget buildFileUploadSection(String label, File? file, VoidCallback onPick) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 5),
        ElevatedButton.icon(
          onPressed: isSubmitted ? null : onPick, // Disable button after submission
          icon: Icon(Icons.upload_file),
          label: Text("Upload $label"),
        ),
        if (file != null)
          ListTile(
            leading: Icon(Icons.insert_drive_file, color: Colors.green),
            title: Text(file.path.split('/').last, overflow: TextOverflow.ellipsis),
          ),
        Divider(),
      ],
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return SizedBox(
      width: 250, // Shortened width
      child: TextFormField(
        controller: controller,
        enabled: !isSubmitted, // Disable input after submission
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("PixyChain Job Application"), backgroundColor: Colors.blueAccent),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("How PixyChain Helps Job Seekers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(
                      "PixyChain provides a secure and reliable platform where job seekers can apply for jobs. "
                      "However, applying does not automatically guarantee a job. Our board members carefully review "
                      "your application and forward it to potential employers for further consideration.",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 20),
                    Image.network(
                      "https://raw.githubusercontent.com/FrimpongMauricious/new_images/main/job_app.jpeg",
                      width: 320,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Application Form", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            if (isSubmitted) // Show success message after submission
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Your application has been received. Application can be submitted once.",
                                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            SizedBox(height: 10),
                            buildTextField("First Name", firstNameController),
                            SizedBox(height: 10),
                            buildTextField("Last Name", lastNameController),
                            SizedBox(height: 10),
                            buildTextField("Field of Study", fieldOfStudyController),
                            SizedBox(height: 10),
                            buildTextField("LinkedIn Profile", linkedInController),
                            SizedBox(height: 10,),

                            buildTextField("Email", email_controler),
                            SizedBox(height: 10),
                            buildFileUploadSection("Resume", resumeFile, () => pickFile("resume")),
                            buildFileUploadSection("Supporting Document (Optional)", supportingFile, () => pickFile("supporting")),
                            SizedBox(height: 15),
                            Center(
                              child: ElevatedButton(
                                onPressed: isSubmitted ? null : submitApplication, // Disable submit button after submission
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isSubmitted ? Colors.grey : Colors.green,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                                ),
                                child: Text("Submit Application", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
