import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class FundingRequestScreen extends StatefulWidget {
  @override
  _FundingRequestScreenState createState() => _FundingRequestScreenState();
}

class _FundingRequestScreenState extends State<FundingRequestScreen> {

   final String url = "https://docs.google.com/spreadsheets/d/15alApV-n80--TE-KIbd06_ESKxlfveceqsIvrK8FaCE/edit?usp=sharing";

  Future<void> _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? selectedRegion;
  String? fileName;
  bool isSubmitted = false; // Flag to track submission status

  final List<String> regions = [
    'Ashanti', 'Greater Accra', 'Northern', 'Western', 'Eastern',
    'Volta', 'Central', 'Bono', 'Savannah', 'Oti', 'Upper East', 'Upper West','Ahafo','North East','Western North','Bono East'
    
  ];

  void pickFile() async {
    if (isSubmitted) return; // Prevent picking a file after submission

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'],
    );

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
      });
    }
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      if (fileName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please upload a project document')),
        );
        return;
      }
      

      print("Name: ${nameController.text}");
      print("Phone: ${phoneController.text}");
      print("Email: ${emailController.text}");
      print("Region: $selectedRegion");
      print("Town: ${townController.text}");
      print("Description: ${descriptionController.text}");
      print("File: $fileName");

      setState(() {
        isSubmitted = true; // Disable text fields after submission
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Funding request submitted successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://raw.githubusercontent.com/FrimpongMauricious/new_images/main/fund_process.jpeg',
                          width: constraints.maxWidth * 0.4,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Empowering Innovators: Our funding initiative supports groundbreaking ideas that create impact in society. Apply now to bring your vision to life!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: SingleChildScrollView(
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      margin: EdgeInsets.all(16),
                      child: Container(
                        width: 450,
                        padding: EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Request Funding",
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20),
                              _buildTextField(nameController, "Full Name"),
                              _buildTextField(phoneController, "Phone Contact", keyboardType: TextInputType.phone),
                              _buildTextField(emailController, "Email Address", keyboardType: TextInputType.emailAddress),
                              _buildDropdownField(),
                              _buildTextField(townController, "Town/City"),
                              _buildTextField(descriptionController, "Project Description", maxLines: 10),
                              _buildTextField(descriptionController, "Wallet address", maxLines: 1),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: isSubmitted ? null : pickFile, // Disable button after submission
                                child: Text('Upload Project Document'),
                              ),
                              if (fileName != null)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'File: $fileName',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: isSubmitted ? null : submitForm, // Disable button after submission
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green, foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: Text('Submit Request', style: TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Container(
      width: 340,
      margin: EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        enabled: !isSubmitted, // Disable field after submission
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) => value!.isEmpty ? 'Enter $label' : null,
      ),
    );
  }

  Widget _buildDropdownField() {
    return Container(
      width: 340,
      margin: EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: selectedRegion,
        decoration: InputDecoration(
          labelText: 'Region',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          filled: true,
          fillColor: Colors.white,
        ),
        items: regions.map((String region) {
          return DropdownMenuItem<String>(
            value: region,
            child: Text(region),
          );
        }).toList(),
        onChanged: isSubmitted ? null : (newValue) {
          setState(() {
            selectedRegion = newValue;
          });
        },
        validator: (value) => value == null ? 'Select a region' : null,
      ),
    );
  }
}
