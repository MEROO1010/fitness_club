import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VerifyIdentityScreen extends StatefulWidget {
  @override
  _VerifyIdentityScreenState createState() => _VerifyIdentityScreenState();
}

class _VerifyIdentityScreenState extends State<VerifyIdentityScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedMethod = 'email';
  String _verificationCode = '';
  bool _isLoading = false;

  Future<void> _sendVerificationCode() async {
    setState(() {
      _isLoading = true;
    });

    // Send a request to your Django backend
    final url = Uri.parse('http://your-django-backend.com/api/send_code/');
    final response = await http.post(url, body: {
      'method': _selectedMethod,
      'email': _selectedMethod == 'email'
          ? 'user@example.com'
          : '', // Replace with email or phone number
    });

    if (response.statusCode == 200) {
      // Verification code sent successfully
      setState(() {
        _isLoading = false;
      });
      // Show a message or navigate to a verification input screen
    } else {
      // Handle error
      setState(() {
        _isLoading = false;
      });
      // Display error message to the user
    }
  }

  Future<void> _verifyCode() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://your-django-backend.com/api/verify_code/');
    final response = await http.post(url, body: {
      'method': _selectedMethod,
      'verification_code': _verificationCode,
    });

    if (response.statusCode == 200) {
      // Verification successful
      setState(() {
        _isLoading = false;
      });
      // Navigate to the next screen or show a success message
    } else {
      // Handle error
      setState(() {
        _isLoading = false;
      });
      // Display error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Your Identity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButton<String>(
                value: _selectedMethod,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedMethod = newValue!;
                  });
                },
                items: <String>['email', 'phone']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Verification Code'),
                onChanged: (value) {
                  _verificationCode = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the verification code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _sendVerificationCode,
                child: Text(_isLoading ? 'Sending...' : 'Send Code'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _verifyCode,
                child: Text(_isLoading ? 'Verifying...' : 'Verify Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
