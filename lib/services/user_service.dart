import 'dart:async';

import 'dart:convert';

import 'package:housing_society_management/models/user.dart';
// import 'package:housing_society_management/screens/main/main_screen.dart';
import 'package:housing_society_management/services/api/api_service.dart';
import 'package:http/http.dart' as http;

class UserService {
  final ApiService _apiService = ApiService();
  static const String baseUrl =
      'http://localhost:8000/api'; // Replace with your API base URL

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

    // final url = Uri.parse($baseUrl . '/reset-password');
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

  Future<dynamic> getUsers() async {
    // final response = await _apiService.get('users');
    try {
      // final response = await _apiService.get('users');
      final response = await http.get(Uri.parse('$baseUrl/users'));

      // final response = await ApiService.get('/users');
      print("User Service 154");
      print(response.body);
      // final jsonData = json.decode(response);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print("User Service 157");
        print(jsonData);
        // final users = List<User>.from(
        // jsonData['data'].map((user) => User.fromJson(user)));
        final users = jsonData['data'].map((user) => (user)).toList();
        print("User Service 165");
        print(users);

        return users;
      } else {
        throw Exception('Failed to get users: ${response.statusCode}');
      }
      // // final userData = response;
      // final jsonDataa = jsonDecode(response);
      // print("User Service 160");
      // print(jsonDataa);
      // final usersJson = jsonData as List<dynamic>;
      // print("User Service 160");
      // print(usersJson);
      // return usersJson.map((userJson) => User.fromJson(userJson)).toList();
      // return usersJson.map((usersJson) => User.fromJson(usersJson)).toList();
    } catch (e) {
      throw Exception('Failed to get users: $e');
    }
    // print("User Service 151");
    // print(response);

    // // final response = await http.get(Uri.parse('$baseUrl/users'));
    // print("User Service 155");
    // print(response);
    // print("User Service 157");
    // // print(response.body);
    // print("User Service 159");
    // // print(response.statusCode);
    // // if (response) {
    // print("User Service 156");
    // // print(response as List<User>);
    // final List<dynamic> data = response;
    // //     response.map((item) => User.fromJson(item)).toList();
    // print("User Service 159");
    // print(data);
    // print("User Service 161");
    // print(data.map((item) => (item)));
    // print("User Service 163");
    // print(data.map((item) => (item)).toList());
    // print("User Service 165");
    // print(data.map((item) => (item as User)).toList());
    // return data.map((item) => (item as User)).toList();
    // } else {
    //   throw Exception('Failed to fetch users');
    // }
    // if (response.statusCode == 200) {
    //   final users = (response.data['users'] as List)
    //       .map((userData) => User.fromJson(userData))
    //       .toList();
    //   return users;
    // } else {
    //   throw Exception('Failed to get users');
    // }
    // final jsonData = response['data'] as List<dynamic>;
    // final users = jsonData.map((userJson) => User.fromJson(userJson)).toList();
    // return users;
  }

  // Implement other methods such as createUser, updateUser, deleteUser, etc.
  // Fetch a single user by ID
  Future<User> getUserById(int userId) async {
    // final response = await _apiService.get('users/$userId');

    // final userJson = response['data'];
    // final user = User.fromJson(userJson);
    // return user;
    final response = await _apiService.get('/users/$userId');
    if (response.statusCode == 200) {
      final user = User.fromJson(response.data['user']);
      return user;
    } else {
      throw Exception('Failed to get user');
    }
  }

  // Create a new user
  // Future<User> createUser(User user) async {
  //   print("I am in service 192");
  //   // final response = await _apiService.post('users', user.toJson());

  //   // final userJson = response['data'];
  //   // final createdUser = User.fromJson(userJson);
  //   // return createdUser;
  //   print("I am in service 198");
  //   print(json.encode(user.toJson()));
  //   print("I am in service 200");
  //   print(user.toJson());
  //   print(user);
  //   final response =
  //       await _apiService.post('users', json.encode(user.toJson()));
  //   print("I am in service 203");
  //   print(response + "123123213");
  //   if (response.statusCode == 200) {
  //     final createdUser = User.fromJson(response.data['user']);
  //     return createdUser;
  //   } else {
  //     print('Failed to create user in service');
  //     throw Exception('Failed to create user in service');
  //   }
  // }

  Future<User> createUser(User user) async {
    try {
      print('270');
      print(user);
      final response = await http.post(
        Uri.parse('$baseUrl/users'),
        body: {
          'name': user.name,
          // 'username': user.username,
          'email': user.email,
          'password': user.password,
          'phone': user.phone,
          'role': user.role.toLowerCase(),
        },
      );

      // body: jsonEncode(user.toJson()),
      print('276');
      print(response.headers);
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        print('291');
        // dynamic data = jsonDecode(response.body);
        print('293');
        // print(data);
        print('295');
        // print(User.fromJson(data as dynamic));
        return User.fromJson(jsonDecode(response.body) as dynamic);
      } else {
        print('298');
        throw Exception('Failed to create user');
      }
    } catch (e) {
      print('302 : $e');
      throw Exception('Error occurred: $e');
    }
  }

  // Update an existing user
  Future<User> updateUser(int id, User user) async {
    // final response = await _apiService.put('users/${user.id}', user.toJson());

    // final userJson = response['data'];
    // final updatedUser = User.fromJson(userJson);
    // return updatedUser;
    final response = await _apiService.put('/users/$id', user.toJson());
    if (response.statusCode == 200) {
      final updatedUser = User.fromJson(response.data['user']);
      return updatedUser;
    } else {
      throw Exception('Failed to update user');
    }
  }

  // Delete a user by ID
  Future<void> deleteUser(int userId) async {
    // await _apiService.delete('users/$userId');
    final response = await _apiService.delete('/users/$userId');
    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
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
