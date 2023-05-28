import 'package:flutter/material.dart';
import 'package:housing_society_management/services/user_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final UserService _userService = UserService();

  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _sendResetPasswordEmail,
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendResetPasswordEmail() async {
    final email = _emailController.text.trim();

    if (!_validateEmail(email)) {
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid email format'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show a loading indicator
    setState(() {
      _isLoading = true;
    });

    try {
      // Call the API service to send the reset password email
      final response = await _userService.sendResetPasswordEmail(email);

      // Simulating a network delay for demonstration purposes
      Future.delayed(Duration(seconds: 2), () {
        // Check the response status
        if (response.statusCode == 200) {
          // Reset password email sent successfully
          // Show success message to the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password reset email sent to $email'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          // Reset password email failed to send
          // Show error message to the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to send reset password email'),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    } catch (error) {
      // Error occurred while sending reset password email
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred'),
          backgroundColor: Colors.red,
        ),
      );
    }

    // Hide the loading indicator
    setState(() {
      _isLoading = false;
    });
  }

  bool _validateEmail(String email) {
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter your email'),
        ),
      );
      return false;
    }

    // Perform additional email validation if needed
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);

    // return true;
  }

  // void _sendResetPasswordEmail() async {
  //   final email = _emailController.text.trim();

  //   // Validate email
  //   if (!_validateEmail(email)) {
  //     // Show error message to the user
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Invalid email format'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }

  //   // Show a loading indicator
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     // Call the API service to send the reset password email
  //     final response = await _apiService.sendResetPasswordEmail(email);

  //     // Simulating a network delay for demonstration purposes
  //     Future.delayed(Duration(seconds: 2), () {
  //       // Check the response status
  //       if (response.statusCode == 200) {
  //         // Reset password email sent successfully
  //         // Show success message to the user
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Password reset email sent to $email'),
  //             backgroundColor: Colors.green,
  //           ),
  //         );
  //       } else {
  //         // Reset password email failed to send
  //         // Show error message to the user
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Failed to send reset password email'),
  //             backgroundColor: Colors.red,
  //           ),
  //         );
  //       }
  //     });
  //   } catch (error) {
  //     // Error occurred while sending reset password email
  //     // Show error message to the user
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('An error occurred'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }

  //   // Hide the loading indicator
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // bool _validateEmail(String email) {
  //   // Use a regular expression to validate the email format
  //   final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  //   return emailRegex.hasMatch(email);
  // }
}
