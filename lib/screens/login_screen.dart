// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:housing_society_management/screens/forgot_password_screen.dart';
// import 'package:housing_society_management/screens/main/main_screen.dart';
// import 'package:housing_society_management/screens/register_screen.dart';
// import 'package:housing_society_management/services/user_service.dart';

// // import 'package:your_app_name/api/api_service.dart';
// // import 'package:your_app_name/screens/forgot_password_screen.dart';
// // import 'package:your_app_name/screens/register_screen.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final _secureStorage = FlutterSecureStorage();

//   bool _isLoading = false;

//   Future<void> loginUser(String identifier, String password) async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     final String email = _emailController.text.trim();
//     final String password = _passwordController.text.trim();

//     final userService = UserService();

//     print([email, password]);
//     try {
//       final response = await userService.login(email, password);
//       print(response);

//       if (response != null) {
//         // Successful login
//         final token = response['token'];

//         // Store the token securely
//         await _secureStorage.write(key: 'token', value: token);

//         // Navigate to the home screen or any other desired screen
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (_) => MainScreen()));
//       } else {
//         // Failed login
//         showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//             title: Text('Login Failed'),
//             content: Text('Invalid email or password.'),
//             actions: [
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (error) {
//       // Handle error
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: Text('Login Error'),
//           content: Text('An error occurred during login. Please try again.'),
//           actions: [
//             ElevatedButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }

//     // try {
//     //   var url = Uri.parse('http://localhost:8000/api/login');
//     //   var response = await http.post(url, body: {
//     //     'email': identifier,
//     //     'password': password,
//     //   });

//     //   if (response.statusCode == 200) {
//     //     final responseData = jsonDecode(response.body);
//     //     // final userRole = responseData['role'];
//     //     // Show success message and navigate to the home screen
//     //     // print('User logged in successfully!');
//     //     // context.read<UserProvider>().setUserRole(userRole);

//     //     // Navigator.pushNamed(context, '/home');
//     //     MainScreen();

//     //     // Navigate to the appropriate dashboard based on user role
//     //     // if (userRole == 'admin') {
//     //     //   // Navigate to admin dashboard
//     //     //   Navigator.pushReplacementNamed(context, '/admin-dashboard');
//     //     //   // MainScreen();
//     //     // } else if (userRole == 'owner') {
//     //     //   // Navigate to owner dashboard
//     //     //   Navigator.pushReplacementNamed(context, '/owner-dashboard');
//     //     //   // MainScreen();
//     //     // } else if (userRole == 'tenant') {
//     //     //   // Navigate to tenant dashboard
//     //     //   Navigator.pushReplacementNamed(context, '/tenant-dashboard');
//     //     //   // MainScreen();
//     //     // } else {
//     //     //   // Handle unknown user role
//     //     //   // Display an error message or redirect to an error page
//     //     // }
//     //   } else {
//     //     // Show error message
//     //     final errorResponse = json.decode(response.body);
//     //     final errorMessage = errorResponse['message'];
//     //     ScaffoldMessenger.of(context).showSnackBar(
//     //       SnackBar(content: Text(errorMessage)),
//     //     );
//     //     // print('Error: ${response.statusCode}');
//     //   }
//     // } catch (e) {
//     //   // Show error message
//     //   print('Error: $e');
//     // }
//   }

//   void _navigateToForgotPasswordScreen() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => ForgotPasswordScreen()),
//     );
//   }

//   void _navigateToRegisterScreen() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => RegisterScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login')),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     TextFormField(
//                       controller: _emailController,
//                       decoration: InputDecoration(labelText: 'Email'),
//                       validator: (value) {
//                         if (value == '') {
//                           return 'Please enter your email';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 16.0),
//                     TextFormField(
//                       controller: _passwordController,
//                       decoration: InputDecoration(labelText: 'Password'),
//                       obscureText: true,
//                       validator: (value) {
//                         if (value == '') {
//                           return 'Please enter your password';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 32.0),
//                     ElevatedButton(
//                       onPressed: () {
//                         String identifier = _emailController.text.trim();
//                         String password = _passwordController.text.trim();
//                         loginUser(identifier, password);
//                       },
//                       child: Text('Login'),
//                     ),
//                     SizedBox(height: 16.0),
//                     TextButton(
//                       onPressed: _navigateToForgotPasswordScreen,
//                       child: Text('Forgot Password'),
//                     ),
//                     SizedBox(height: 16.0),
//                     TextButton(
//                       onPressed: _navigateToRegisterScreen,
//                       child: Text('Create Account'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  // const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser(String identifier, String password) async {
    try {
      var url = Uri.parse('http://localhost:8000/api/login');
      var response = await http.post(url, body: {
        'email': identifier,
        'password': password,
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final userRole = responseData['role'];
        // Show success message and navigate to the home screen
        // print('User logged in successfully!');
        // context.read<UserProvider>().setUserRole(userRole);

        // Navigator.pushNamed(context, '/home');

        // Navigate to the appropriate dashboard based on user role
        if (userRole == 'admin') {
          // Navigate to admin dashboard
          Navigator.pushReplacementNamed(context, '/home');
        } else if (userRole == 'owner') {
          // Navigate to owner dashboard
          Navigator.pushReplacementNamed(context, '/home');
        } else if (userRole == 'tenant') {
          // Navigate to tenant dashboard
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // Handle unknown user role
          // Display an error message or redirect to an error page
        }
      } else {
        // Show error message
        final errorResponse = json.decode(response.body);
        final errorMessage = errorResponse['message'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
        // print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Show error message
      // print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Email or Username',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String identifier = _usernameController.text.trim();
                String password = _passwordController.text.trim();
                loginUser(identifier, password);
              },
              child: Text('Log in'),
            ),
            TextButton(
              child: Text('Forgot Password?'),
              onPressed: () {
                // Navigate to forgot password screen
                Navigator.pushNamed(context, '/forgot-password');
              },
            ),
            TextButton(
              child: Text('Not a member? Sign Up now'),
              onPressed: () {
                // Navigate to sign up screen
                Navigator.pushNamed(context, '/register');
              },
            ),
          ],
        ),
      ),
    );
  }
}
