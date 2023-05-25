import 'dart:convert';
import 'package:admin/models/user.dart';
import 'package:admin/services/api/api_service.dart';
import 'package:http/http.dart' as http;

class UserService {
  final ApiService _apiService = ApiService();

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
  Future<User> loginUser(String email, String password) async {
    final response = await _apiService.post('login', {
      'email': email,
      'password': password,
    });

    final userJson = response['data'];
    final user = User.fromJson(userJson);
    return user;
  }
}
