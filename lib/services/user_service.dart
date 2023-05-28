// import 'dart:convert';

import 'package:housing_society_management/models/user.dart';
// import 'package:housing_society_management/screens/main/main_screen.dart';
import 'package:housing_society_management/services/api/api_service.dart';
// import 'package:http/http.dart' as http;

class UserService {
  final ApiService _apiService = ApiService();

  // Future<Map<String, dynamic>?> login(String email, String password) async {
  //   // Future<void> login(String email, String password) async {
  //   // final url = Uri.parse('your_login_api_url_here');
  //   final body = {
  //     'email': email,
  //     'password': password,
  //   };

  //   final response = await _apiService.post("login", body);

  //   if (response.statusCode == 200) {
  //     final responseData = json.decode(response.body);
  //     final userRole = responseData['role'];

  //     if (userRole == 'admin') {
  //       // Navigate to admin dashboard
  //       MainScreen();
  //     } else if (userRole == 'owner') {
  //       // Navigate to owner dashboard
  //       // Navigator.pushReplacementNamed(context, '/owner-dashboard');
  //       MainScreen();
  //     } else if (userRole == 'tenant') {
  //       // Navigate to tenant dashboard
  //       // Navigator.pushReplacementNamed(context, '/tenant-dashboard');
  //       MainScreen();
  //     } else {
  //       // Handle unknown user role
  //       // Display an error message or redirect to an error page
  //     }
  //     return responseData;
  //   } else {
  //     // Handle error case, such as displaying error message
  //     return null;
  //   }
  // }

  // Future<dynamic> register(
  //   String name,
  //   String email,
  //   String password,
  //   String phone,
  //   String role,
  // ) async {
  // final url =
  //     'your_api_endpoint/register'; // Replace with your actual registration API endpoint

  // final response = await _apiService.post(
  //   '/register',
  //   {
  //     'name': name,
  //     'email': email,
  //     'password': password,
  //     'phone': phone,
  //     'role': role,
  //   },
  // );

  //   if (response.statusCode == 200) {
  //     // Registration successful
  //     return jsonDecode(response.body);
  //   } else {
  //     // Registration failed
  //     throw Exception('Registration failed: ${response.statusCode}');
  //   }
  // }

  // Future<Map<String, dynamic>> register(
  //   String name,
  //   String email,
  //   String password,
  //   String phone,
  //   String userRoles, // Added userRoles parameter
  // ) async {
  //   // Construct the request body
  //   final body = {
  //     'name': name,
  //     'email': email,
  //     'password': password,
  //     'phone': phone,
  //     'role': userRoles, // Pass the userRole parameter in the request body
  //   };

  //   print(body);

  //   // Make the API request and return the response
  //   final response = await _apiService.post(
  //     '/register',
  //     jsonEncode(body),
  //     // {'Content-Type': 'application/json'},
  //   );

  //   print(response.body);

  //   // Parse the response and return it
  //   return jsonDecode(response.body);
  // }

  Future<dynamic> sendResetPasswordEmail(String email) async {
    // Perform the logic to send the reset password email
    // You can make an HTTP request to your API endpoint using the 'http' package

    // final url = Uri.parse('/reset-password');
    final response = await _apiService.post(
      '/reset-password',
      {'email': email},
    );

    // Handle the response from the API
    if (response.statusCode == 200) {
      // Reset password email sent successfully
      print('Password reset email sent to $email');
    } else {
      // Failed to send reset password email
      print('Failed to send reset password email');
    }
  }

  // Future<List<User>> getUsers() async {
  //   final response = await http.get(Uri.parse(baseUrl));

  //   if (response.statusCode == 200) {
  //     final jsonData = jsonDecode(response.body);
  //     final users = <User>[];

  //     for (var userJson in jsonData) {
  //       users.add(User.fromJson(userJson));
  //     }

  //     return users;
  //   } else {
  //     throw Exception('Failed to fetch users');
  //   }
  // }

  Future<List<User>> getUsers() async {
    final response = await _apiService.get('users');

    final jsonData = response['data'] as List<dynamic>;
    final users = jsonData.map((userJson) => User.fromJson(userJson)).toList();
    return users;
  }

  // Implement other methods such as createUser, updateUser, deleteUser, etc.
  // Fetch a single user by ID
  Future<User> getUserById(int userId) async {
    final response = await _apiService.get('users/$userId');

    final userJson = response['data'];
    final user = User.fromJson(userJson);
    return user;
  }

  // Create a new user
  Future<User> createUser(User user) async {
    final response = await _apiService.post('users', user.toJson());

    final userJson = response['data'];
    final createdUser = User.fromJson(userJson);
    return createdUser;
  }

  // Update an existing user
  Future<User> updateUser(User user) async {
    final response = await _apiService.put('users/${user.id}', user.toJson());

    final userJson = response['data'];
    final updatedUser = User.fromJson(userJson);
    return updatedUser;
  }

  // Delete a user by ID
  Future<void> deleteUser(int userId) async {
    await _apiService.delete('users/$userId');
  }

  // Other methods as per your requirements

  // Example method to login user
  // Future<User> loginUser(String email, String password) async {
  //   final response = await _apiService.post('login', {
  //     'email': email,
  //     'password': password,
  //   });

  //   final userJson = response['data'];
  //   final user = User.fromJson(userJson);
  //   return user;
  // }
}
