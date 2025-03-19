import 'package:flutter/material.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:pixy_chain/transaction_screen.dart';

class CommunityContributionScreen extends StatefulWidget {
  @override
  _CommunityContributionScreenState createState() => _CommunityContributionScreenState();
}

class _CommunityContributionScreenState extends State<CommunityContributionScreen> {
  final _formKey = GlobalKey<FormState>();
  String? contributionType;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController orgNameController = TextEditingController();
  TextEditingController orgWebsiteController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  //TextEditingController amountController = TextEditingController();
  bool isSubmitted = false;

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      print("Contribution Type: $contributionType");
      if (contributionType == "Individual") {
        print("Name: ${firstNameController.text} ${lastNameController.text}");
      } else {
        print("Organization Name: ${orgNameController.text}");
        print("Website: ${orgWebsiteController.text}");
      }
      print("Email: ${emailController.text}");
     // print("Amount: ${amountController.text}");

      setState(() {
        isSubmitted = true;
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return WalletScreen();
        }));
      });

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Contribution submitted successfully!')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[200],
              padding:const  EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://raw.githubusercontent.com/FrimpongMauricious/new_images/main/contibution.jpeg',

                    width: 300,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Your contributions help sponsor education, support initiatives, and create opportunities for individuals in need. Be a part of the change!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                margin: const EdgeInsets.all(16),
                child: Container(
                  width: 450,
                  padding:const  EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("Make a Contribution", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                       const  SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: contributionType,
                          decoration: const InputDecoration(labelText: 'Contributing As', border: OutlineInputBorder()),
                          items: ["Individual", "Organization"].map((String type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          onChanged: isSubmitted ? null : (value) {
                            setState(() {
                              contributionType = value;
                            });
                          },
                          validator: (value) => value == null ? 'Please select contribution type' : null,
                        ),
                        if (contributionType == "Individual") ...[
                          _buildTextField(firstNameController, "First Name"),
                          _buildTextField(lastNameController, "Last Name"),
                          _buildTextField(emailController, "Email Address"),
                        ] else if (contributionType == "Organization") ...[
                          _buildTextField(orgNameController, "Organization Name"),
                          _buildTextField(orgWebsiteController, "Organization Website"),
                          _buildTextField(emailController, "Organization Email"),
                        ],
                       // _buildTextField(amountController, "Contribution Amount", keyboardType: TextInputType.number),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green
                          ),
                          onPressed: isSubmitted ? null : submitForm,
                          child:const  Text('Contribute'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding:const  EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        enabled: !isSubmitted,
        decoration: InputDecoration(
          labelText: label,
          border:const  OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) => value!.isEmpty ? 'Enter $label' : null,
      ),
    );
  }
}
