import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhoneNumberScreen extends StatefulWidget {
  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _verifyPhoneNumber() async {
    if (_formKey.currentState!.validate()) {
      // Extract the phone number
      String phoneNumber = _phoneNumberController.text;

      // Send a POST request to your Django backend
      final response = await http.post(
        Uri.parse(
            'http://your-django-backend-url/verify-phone/'), // Replace with your URL
        body: {'phone_number': phoneNumber},
      );

      if (response.statusCode == 200) {
        // Handle success (e.g., show a confirmation message or navigate)
        print('Phone number verified successfully!');
        // You might navigate to a new screen to handle OTP entry
      } else {
        // Handle errors (e.g., show an error message)
        print('Error verifying phone number: ${response.body}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _verifyPhoneNumber,
                child: Text('Verify Phone Number'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
