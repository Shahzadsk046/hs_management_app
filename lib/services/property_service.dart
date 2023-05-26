// import 'dart:convert';

import 'dart:convert';

import 'package:housing_society_management/models/property.dart';
// import 'package:housing_society_management/models/user.dart';
import 'package:housing_society_management/services/api/api_service.dart';

class PropertyService {
  final ApiService _apiService = ApiService();

  // PropertyService(this._apiService);

  Future<List<Property>> fetchProperties() async {
    try {
      final response = await _apiService.get('properties');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Property.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch properties');
      }
    } catch (e) {
      throw Exception('Failed to fetch properties: $e');
    }
  }

  Future<Property> fetchPropertyById(int id) async {
    try {
      final response = await _apiService.get('properties/$id');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        return Property.fromJson(data);
      } else {
        throw Exception('Failed to fetch property');
      }
    } catch (e) {
      throw Exception('Failed to fetch property: $e');
    }
  }

  Future<Property> createProperty(Property property) async {
    try {
      final response = await _apiService.post('properties', property.toJson());

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = response.data;
        return Property.fromJson(data);
      } else {
        throw Exception('Failed to create property');
      }
    } catch (e) {
      throw Exception('Failed to create property: $e');
    }
  }

  Future<Property> updateProperty(Property property) async {
    try {
      final response =
          await _apiService.put('properties/${property.id}', property.toJson());

      final propertyJson = response['data'];
      final updatedProperty = Property.fromJson(propertyJson);
      return updatedProperty;
    } catch (e) {
      throw Exception('Failed to update property: $e');
    }
  }

  Future<void> deleteProperty(int id) async {
    try {
      final response = await _apiService.delete('/properties/$id');

      if (response.statusCode != 200) {
        throw Exception('Failed to delete property');
      }
    } catch (e) {
      throw Exception('Failed to delete property: $e');
    }
  }

  Future<List<Property>> getPropertiesOwnedByUser(int userId) async {
    try {
      final response = await _apiService.get('/users/$userId/properties');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Property.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch properties owned by user');
      }
    } catch (e) {
      throw Exception('Failed to fetch properties owned by user: $e');
    }
  }

  Future<List<Property>> filterPropertiesByType(String type) async {
    try {
      final response = await _apiService.get('/properties?type=$type');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Property.fromJson(json)).toList();
      } else {
        throw Exception('Failed to filter properties by type');
      }
    } catch (e) {
      throw Exception('Failed to filter properties by type: $e');
    }
  }

  Future<List<Property>> fetchAvailableProperties() async {
    try {
      final response = await _apiService.get('/properties?is_available=true');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.data);
        return data.map((json) => Property.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch available properties');
      }
    } catch (e) {
      throw Exception('Failed to fetch available properties: $e');
    }
  }

  // List<Property> _properties = [];

  // // Get all properties
  // List<Property> getProperties() {
  //   return _properties;
  // }

  // // Get property by ID
  // Property getPropertyById(int id) {
  //   return _properties.firstWhere((property) => property.id == id,
  //       orElse: () => null);
  // }

  // // Add a new property
  // Property addProperty(Property property) {
  //   property.id = _generateUniqueId();
  //   _properties.add(property);
  //   return property;
  // }

  // // Update an existing property
  // Property updateProperty(Property property) {
  //   final index = _properties.indexWhere((p) => p.id == property.id);
  //   if (index != -1) {
  //     _properties[index] = property;
  //   }
  //   return property;
  // }

  // // Delete a property
  // bool deleteProperty(int id) {
  //   final index = _properties.indexWhere((property) => property.id == id);
  //   if (index != -1) {
  //     _properties.removeAt(index);
  //     return true;
  //   }
  //   return false;
  // }

  // // // Generate a unique ID for a new property
  // int _generateUniqueId() {
  //   // Implement your own logic to generate unique IDs
  //   // You can use a package like `uuid` or generate IDs based on the timestamp
  //   // For simplicity, we'll just use the current timestamp here
  //   return DateTime.now().millisecondsSinceEpoch;
  // }

  // Other methods and business logic specific to property management

  // Example method: Get available properties
  // List<Property> getAvailableProperties() {
  //   return _properties.where((property) => property.isAvailable).toList();
  // }

  // Future<List<Property>> fetchAvailableProperties() async {
  //   // final url = 'http://your-backend-api.com/properties?availability=available';
  //   final response = await _apiService.get('properties?availability=available');

  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = jsonDecode(response.body);
  //     final properties = data.map((json) => Property.fromJson(json)).toList();
  //     return properties;
  //   } else {
  //     throw Exception('Failed to fetch available properties');
  //   }
  // }

  // // Example method: Get properties owned by a user
  // List<Property> getPropertiesOwnedByUser(User owner) {
  //   return _properties.where((property) => property.isOwnedBy(owner)).toList();
  // }

  // // Example method: Filter properties by type
  // List<Property> filterPropertiesByType(PropertyType type) {
  //   return _properties.where((property) => property.type == type).toList();
  // }
}
