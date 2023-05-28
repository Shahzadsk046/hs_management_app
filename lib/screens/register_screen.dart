import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:housing_society_management/models/user.dart';
import 'package:housing_society_management/constants/user_roles.dart';
import 'package:housing_society_management/screens/login_screen.dart';
import 'package:housing_society_management/services/api/api_service.dart';
import 'package:housing_society_management/services/user_service.dart';

const List<String> list = <String>['Owner', 'Tenant'];

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  String userRole = list.first;

  final UserService _userService = UserService();

  bool _isLoading = false;

  // UserRole _selectedRole = UserRole.owner; // Default role is 'owner'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            // DropdownButtonFormField<UserRole>(
            //   value: _selectedRole,
            //   items: UserRole.values.map((UserRole role) {
            //     return DropdownMenuItem<UserRole>(
            //       value: role,
            //       child: Text(role.toString().split('.').last),
            //     );
            //   }).toList(),
            //   onChanged: (UserRole? value) {
            //     setState(() {
            //       _selectedRole = value ?? UserRole.owner;
            //     });
            //   },
            //   decoration: InputDecoration(labelText: 'User Role'),
            // ),

            DropdownButtonFormField<String>(
              value: userRole,
              hint: Text('User Type'),
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  userRole = newValue!;
                  // Handle selected option
                  print('Selected option: $userRole');
                });
              },
              icon: const Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.deepPurple,
              ),
              dropdownColor: Colors.deepPurple.shade50,
              decoration: InputDecoration(
                labelText: "User Type",
                // prefixIcon: Icon(
                //   Icons.accessibility_new_rounded,
                //   color: Colors.deepPurple,
                // )
              ),
            ),
            // Text(),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _register,
              child: Text('Register'),
            ),
            TextButton(
              onPressed: () {
                _navigateToLoginScreen();
              },
              child: Text('Already registered? Login'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _register() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    String phone = _phoneController.text.trim();
    String role = userRole.trim();
    // final selectedRole = _selectedRole;

    // final userRoles = mapUserRole(selectedRole.toString());
    if (_validateInputs(name, email, password, confirmPassword, phone, role)) {
      setState(() {
        print(_validateInputs(
            name, email, password, confirmPassword, phone, role));
        _isLoading = true;
      });

      try {
        // Make API call to register a new user
        var url = Uri.parse('http://localhost:8000/api/register');
        var response = await http.post(url, body: {
          'name': name,
          // 'username': username,
          'email': email,
          'password': password,
          'phone': phone,
          'role': userRole.toLowerCase(),
        });

        print(response.statusCode);
        print(response.body);

        if (response.statusCode == 200) {
          // User registration successful
          print('User registered successfully!');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User registered successfully'),
            ),
          );
          _navigateToLoginScreen();
          // Navigator.pushNamed(context, '/login');
          // Perform any necessary actions (e.g., show success message, navigate to home screen)
        } else {
          // User registration failed
          print('Error: ${response.statusCode}');
          // Handle error (e.g., show error message)
        }
      } catch (e) {
        // Error occurred during API call
        print('Error: $e');
        // Handle error (e.g., show error message)
      }

      setState(() {
        _isLoading = false;
      });

      // print(userRoles.toString().split('.').last);
      // print(userRoles.index);

      // if (_validateInputs(name, email, password, confirmPassword, phone)) {
      //   final response = await _userService.register(
      //       name, email, password, phone, userRoles.toString().split('.').last);

      //   if (response != null) {
      //     // Successful registration
      //     // You can handle the success case according to your requirements,
      //     // such as showing a success message, navigating to the login screen, etc.
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(
      //         content: Text('User registered successfully'),
      //       ),
      //     );
      //   } else {
      //     // Registration failed
      //     // You can handle the error case according to your requirements,
      //     // such as displaying an error message, resetting the form, etc.
      //   }
      // }

      // setState(() {
      //   _isLoading = false;
      // });
    }
  }

  void _navigateToLoginScreen() {
    // Navigator.pushNamed(context, '/');
    Navigator.pushReplacementNamed(context, '/login');

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (_) => LoginScreen()),
    // );
  }

  bool _validateInputs(
    String name,
    String email,
    String password,
    String confirmPassword,
    String phone,
    String role,
  ) {
    // Perform validation here based on your requirements
    // You can check for empty fields, password match, email format, etc.
    // Return true if inputs are valid, otherwise return false

    // Check if any of the fields are empty
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty ||
        role.isEmpty) {
      return false;
    }

    // Check if the password and confirm password match
    // if (password != confirmPassword) {
    //   return false;
    // }

    // // Check if the email is valid using a regular expression
    // final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    // if (!emailRegExp.hasMatch(email)) {
    //   return false;
    // }

    // Additional validation rules can be added here based on your requirements

    return true;
  }
}
