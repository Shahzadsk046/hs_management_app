import 'package:flutter/material.dart';
import 'package:housing_society_management/models/user.dart';
import 'package:housing_society_management/constants/user_roles.dart';
import 'package:housing_society_management/screens/login_screen.dart';
import 'package:housing_society_management/services/api/api_service.dart';
import 'package:housing_society_management/services/user_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final UserService _userService = UserService();

  bool _isLoading = false;

  UserRole _selectedRole = UserRole.owner; // Default role is 'owner'

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
            DropdownButtonFormField<UserRole>(
              value: _selectedRole,
              items: UserRole.values.map((UserRole role) {
                return DropdownMenuItem<UserRole>(
                  value: role,
                  child: Text(role.toString().split('.').last),
                );
              }).toList(),
              onChanged: (UserRole? value) {
                setState(() {
                  _selectedRole = value ?? UserRole.owner;
                });
              },
              decoration: InputDecoration(labelText: 'User Role'),
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
    setState(() {
      _isLoading = true;
    });

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final phone = _phoneController.text.trim();
    final role = _selectedRole.index + 1;
    final selectedRole = _selectedRole;

    final userRoles = mapUserRole(selectedRole.toString());

    print(userRoles.toString().split('.').last);
    print(userRoles.index);

    if (_validateInputs(name, email, password, confirmPassword, phone)) {
      final response = await _userService.register(
          name, email, password, phone, userRoles.index);

      if (response != null) {
        // Successful registration
        // You can handle the success case according to your requirements,
        // such as showing a success message, navigating to the login screen, etc.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User registered successfully'),
          ),
        );
      } else {
        // Registration failed
        // You can handle the error case according to your requirements,
        // such as displaying an error message, resetting the form, etc.
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _navigateToLoginScreen() {
    // Navigator.pushNamed(context, '/');
    Navigator.pushReplacementNamed(context, '/');

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
  ) {
    // Perform validation here based on your requirements
    // You can check for empty fields, password match, email format, etc.
    // Return true if inputs are valid, otherwise return false

    // Check if any of the fields are empty
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty) {
      return false;
    }

    // Check if the password and confirm password match
    if (password != confirmPassword) {
      return false;
    }

    // Check if the email is valid using a regular expression
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegExp.hasMatch(email)) {
      return false;
    }

    // Additional validation rules can be added here based on your requirements

    return true;
  }
}
