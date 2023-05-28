import 'package:housing_society_management/models/property.dart';
import 'package:housing_society_management/models/society.dart';
import 'package:housing_society_management/models/society_expense.dart';
import 'package:housing_society_management/models/society_property_variant.dart';
import 'package:housing_society_management/models/user.dart';
import 'package:housing_society_management/services/api/api_service.dart';
import 'package:housing_society_management/services/property_service.dart';

class SocietyService {
  final ApiService _apiService = ApiService();
  final PropertyService _propertyService = PropertyService();
  // final PropertyVariantService _propertyVariantService =
  //     PropertyVariantService();
  // final ExpenseService _expenseService = ExpenseService();
  // Future<List<Society>> getAllSocieties() async {
  //   // Implement logic to fetch all societies from the backend
  //   // Return a list of Society objects
  //   // You can use the API client or any other method to fetch the data
  //   // Example:
  //   final response = await _apiService.get('/societies');
  //   final List<dynamic> data = response['data'];
  //   final societies = data.map((item) => Society.fromJson(item)).toList();
  //   return societies;
  //   // return [];
  // }

  // Future<List<Society>> getAllSocieties() async {
  //   try {
  //     final List<dynamic> societyData = await _apiService.get('/societies');
  //     final List<Society> societies =
  //         societyData.map((data) => _mapToSociety(data)).toList();
  //     return societies;
  //   } catch (error) {
  //     throw Exception('Failed to fetch societies: $error');
  //   }
  // }

  Future<List<Society>> getAllSocieties() async {
    try {
      final response = await _apiService.get('/societies');
      final data = response['data'];
      return _mapToSocieties(data);
    } catch (error) {
      throw Exception('Failed to fetch societies: $error');
    }
  }

  // Future<Society> getSocietyById(int id) async {
  //   // Implement logic to fetch a society by its ID from the backend
  //   // Return a Society object
  //   // You can use the API client or any other method to fetch the data
  //   // Example:
  //   final response = await _apiService.get('/societies/$id');
  //   final data = response['data'];
  //   final society = Society.fromJson(data);
  //   return society;
  //   // return Society(
  //   //   id: id,
  //   //   name: 'Example Society',
  //   //   address: '123 Main Street',
  //   //   adminId: 1,
  //   //   admin: null,
  //   //   properties: [],
  //   //   propertyVariants: [],
  //   //   expenses: [],
  //   // );
  // }

  // Future<Society> getSocietyById(int id) async {
  //   try {
  //     final dynamic societyData = await _apiService.get('/societies/$id');
  //     final Society society = _mapToSociety(societyData);
  //     return society;
  //   } catch (error) {
  //     throw Exception('Failed to fetch society: $error');
  //   }
  // }

  Future<Society> getSocietyById(int id) async {
    try {
      final response = await _apiService.get('/societies/$id');
      final data = response['data'];
      return _mapToSociety(data);
    } catch (error) {
      throw Exception('Failed to fetch society: $error');
    }
  }

  // Future<void> createSociety(Society society) async {
  //   // Implement logic to create a new society
  //   // You can use the API client or any other method to send the data to the backend
  //   // Example:
  //   final data = society.toJson();
  //   final response = await _apiService.post('/societies', data);
  //   // Handle the response and any errors
  // }

  // Future<Society> createSociety(Society society) async {
  //   try {
  //     final dynamic createdSocietyData =
  //         await _apiService.post('/societies', _mapToApiData(society));
  //     final Society createdSociety = _mapToSociety(createdSocietyData);
  //     return createdSociety;
  //   } catch (error) {
  //     throw Exception('Failed to create society: $error');
  //   }
  // }

  Future<Society> createSociety(
      String name, String address, int adminId) async {
    try {
      final response = await _apiService.post('/societies', {
        'name': name,
        'address': address,
        'adminId': adminId,
      });
      final data = response['data'];
      return _mapToSociety(data);
    } catch (error) {
      throw Exception('Failed to create society: $error');
    }
  }

  // Future<void> updateSociety(Society society) async {
  //   // Implement logic to update an existing society
  //   // You can use the API client or any other method to send the data to the backend
  //   // Example:
  //   final data = society.toJson();
  //   final response = await _apiService.put('/societies/${society.id}', data);
  //   // Handle the response and any errors
  // }

  // Future<Society> updateSociety(Society society) async {
  //   try {
  //     final dynamic updatedSocietyData = await _apiService.put(
  //         '/societies/${society.id}', _mapToApiData(society));
  //     final Society updatedSociety = _mapToSociety(updatedSocietyData);
  //     return updatedSociety;
  //   } catch (error) {
  //     throw Exception('Failed to update society: $error');
  //   }
  // }

  Future<Society> updateSociety(int id, String name, String address) async {
    try {
      final response = await _apiService.put('/societies/$id', {
        'name': name,
        'address': address,
      });
      final data = response['data'];
      return _mapToSociety(data);
    } catch (error) {
      throw Exception('Failed to update society: $error');
    }
  }

  // Future<void> deleteSociety(int id) async {
  //   // Implement logic to delete a society by its ID
  //   // You can use the API client or any other method to send the request to the backend
  //   // Example:
  //   final response = await _apiService.delete('/societies/$id');
  //   // Handle the response and any errors
  // }

  Future<void> deleteSociety(int id) async {
    try {
      await _apiService.delete('/societies/$id');
    } catch (error) {
      throw Exception('Failed to delete society: $error');
    }
  }

  // Future<void> deleteSociety(int id) async {
  //   try {
  //     // Fetch the society by ID to check if it exists
  //     final society = await getSocietyById(id);
  //     if (society == null) {
  //       throw Exception('Society not found');
  //     }

  //     // Implement logic to delete the society
  //     // You can use the API client or any other method to send the request to the backend
  //     // Example:
  //     await _apiService.delete('/societies/$id');
  //     // Handle the response and any errors

  //     // Optionally, also delete the related models (properties, property variants, and expenses)
  //     // await deletePropertiesBySocietyId(id);
  //     // await deletePropertyVariantsBySocietyId(id);
  //     // await deleteExpensesBySocietyId(id);

  //     // Display a success message or handle any errors
  //   } catch (error) {
  //     // Handle error
  //     throw Exception('Failed to delete society: $error');
  //   }
  // }

  Future<List<Property>> getPropertiesBySocietyId(int societyId) async {
    // Implement logic to fetch properties by society ID from the backend
    // Return a list of Property objects
    // You can use the API client or any other method to fetch the data
    // Example:
    final response = await _apiService.get('/societies/$societyId/properties');
    final List<dynamic> data = response['data'];
    final properties = data.map((item) => Property.fromJson(item)).toList();
    return properties;
    // return [];
  }

  Future<List<SocietyPropertyVariant>> getPropertyVariantsBySocietyId(
      int societyId) async {
    // Implement logic to fetch property variants by society ID from the backend
    // Return a list of SocietyPropertyVariant objects
    // You can use the API client or any other method to fetch the data
    // Example:
    final response =
        await _apiService.get('/societies/$societyId/property-variants');
    final List<dynamic> data = response['data'];
    final propertyVariants =
        data.map((item) => SocietyPropertyVariant.fromJson(item)).toList();
    return propertyVariants;
    // return [];
  }

  Future<List<SocietyExpense>> getExpensesBySocietyId(int societyId) async {
    // Implement logic to fetch expenses by society ID from the backend
    // Return a list of SocietyExpense objects
    // You can use the API client or any other method to fetch the data
    // Example:
    final response = await _apiService.get('/societies/$societyId/expenses');
    final List<dynamic> data = response['data'];
    final expenses = data.map((item) => SocietyExpense.fromJson(item)).toList();
    return expenses;
    // return [];
  }

  // Society _mapToSociety(dynamic data) {
  //   return Society(
  //     id: data['id'],
  //     name: data['name'],
  //     address: data['address'],
  //     adminId: data['adminId'],
  //     admin: _mapToUser(data['admin']),
  //     properties: (data['properties'] as List<dynamic>)
  //         .map((propertyData) => _mapToProperty(propertyData))
  //         .toList(),
  //     propertyVariants: (data['propertyVariants'] as List<dynamic>)
  //         .map((propertyVariantData) =>
  //             _mapToSocietyPropertyVariant(propertyVariantData))
  //         .toList(),
  //     expenses: (data['expenses'] as List<dynamic>)
  //         .map((expenseData) => _mapToSocietyExpense(expenseData))
  //         .toList(),
  //   );
  // }

  List<Society> _mapToSocieties(List<dynamic> data) {
    return data.map((item) => _mapToSociety(item)).toList();
  }

  // Society _mapToSociety(dynamic data) {
  //   return Society(
  //     id: data['id'],
  //     name: data['name'],
  //     address: data['address'],
  //     adminId: data['adminId'],
  //     admin: _mapToUser(data['admin']),
  //     properties: [], // Add the necessary properties here
  //     propertyVariants: [], // Add the necessary property variants here
  //     expenses: [], // Add the necessary expenses here
  //   );
  // }

  Society _mapToSociety(dynamic data) {
    final int societyId = data['id'];

    // Fetch properties from data source based on societyId
    // final List<Property> properties =
    //     _propertyService.getPropertiesBySocietyId(societyId);

    // // Fetch property variants from data source based on societyId
    // final List<SocietyPropertyVariant> propertyVariants =
    //     _propertyVariantService.getPropertyVariantsBySocietyId(societyId);

    // // Fetch expenses from data source based on societyId
    // final List<SocietyExpense> expenses =
    //     _expenseService.getExpensesBySocietyId(societyId);

    return Society(
      id: societyId,
      name: data['name'],
      address: data['address'],
      adminId: data['adminId'],
      admin: _mapToUser(data['admin']),
      properties: [],
      propertyVariants: [],
      expenses: [],
      // properties: properties,
      // propertyVariants: propertyVariants,
      // expenses: expenses,
    );
  }

  User _mapToUser(dynamic data) {
    return User(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      password: data['password'],
      user_role_id: data['user_role_id'],
      phone: data['phone'],
    );
  }

  // Property _mapToProperty(dynamic data) {
  //   return Property(
  //     id: data['id'],
  //     title: data['title'],
  //     type: data['type'],
  //     description: data['description'],
  //     price: data['price'],
  //     isAvailable: data['isAvailable'],
  //     owner: _mapToUser(data['owner']),
  //     society: _mapToSociety(data['society']),
  //   );
  // }

  // SocietyPropertyVariant _mapToSocietyPropertyVariant(dynamic data) {
  //   return SocietyPropertyVariant(
  //     id: data['id'],
  //     name: data['name'],
  //     description: data['description'],
  //     societyId: data['societyId'],
  //     society: _mapToSociety(data['society']),
  //   );
  // }

  // SocietyExpense _mapToSocietyExpense(dynamic data) {
  //   return SocietyExpense(
  //     id: data['id'],
  //     title: data['title'],
  //     description: data['description'],
  //     amount: data['amount'],
  //     createdBy: data['createdBy'],
  //     societyId: data['societyId'],
  //     creator: _mapToUser(data['creator']),
  //     society: _mapToSociety(data['society']),
  //   );
  // }

  // dynamic _mapToApiData(Society society) {
  //   return {
  //     'id': society.id,
  //     'name': society.name,
  //     'address': society.address,
  //     'adminId': society.adminId,
  //     'admin': _mapToApiUserData(society.admin),
  //     'properties': society.properties
  //         .map((property) => _mapToApiPropertyData(property))
  //         .toList(),
  //     'propertyVariants': society.propertyVariants
  //         .map((propertyVariant) =>
  //             _mapToApiPropertyVariantData(propertyVariant))
  //         .toList(),
  //     'expenses': society.expenses
  //         .map((expense) => _mapToApiExpenseData(expense))
  //         .toList(),
  //   };
  // }

  // dynamic _mapToApiUserData(User? user) {
  //   return {
  //     'id': user!.id,
  //     'name': user.name,
  //   };
  // }

  // dynamic _mapToApiPropertyData(Property property) {
  //   return {
  //     'id': property.id,
  //     'title': property.title,
  //     'society': _mapToApiSocietyData(property.society),
  //   };
  // }

  // dynamic _mapToApiPropertyVariantData(SocietyPropertyVariant propertyVariant) {
  //   return {
  //     'id': propertyVariant.id,
  //     'name': propertyVariant.name,
  //     'society': _mapToApiSocietyData(propertyVariant.society),
  //   };
  // }

  // dynamic _mapToApiExpenseData(SocietyExpense expense) {
  //   return {
  //     'id': expense.id,
  //     'name': expense.name,
  //     'society': _mapToApiSocietyData(expense.society),
  //   };
  // }

  // dynamic _mapToApiSocietyData(Society society) {
  //   return {
  //     'id': society.id,
  //     'name': society.name,
  //     'address': society.address,
  //     'adminId': society.adminId,
  //     'admin': _mapToApiUserData(society.admin),
  //   };
  // }
}
