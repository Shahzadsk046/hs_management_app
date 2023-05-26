import 'package:housing_society_management/models/property.dart';
import 'package:housing_society_management/models/society_expense.dart';
import 'package:housing_society_management/models/society_property_variant.dart';
import 'package:housing_society_management/models/user.dart';

class Society {
  int id;
  String name;
  String address;
  int adminId;
  User? admin;
  List<Property> properties;
  List<SocietyPropertyVariant> propertyVariants;
  List<SocietyExpense> expenses;

  Society({
    required this.id,
    required this.name,
    required this.address,
    required this.adminId,
    required this.admin,
    required this.properties,
    required this.propertyVariants,
    required this.expenses,
  });

  // Method to convert Society object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'adminId': adminId,
      'admin': admin?.toJson(),
      'properties': properties?.map((property) => property.toJson())?.toList(),
      'propertyVariants':
          propertyVariants?.map((variant) => variant.toJson())?.toList(),
      'expenses': expenses?.map((expense) => expense.toJson())?.toList(),
    };
  }

  // Method to create a Society object from JSON
  factory Society.fromJson(Map<String, dynamic> json) {
    return Society(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      adminId: json['adminId'],
      admin: json['admin'] != null ? User.fromJson(json['admin']) : null,
      properties: json['properties'] != null
          ? List<Property>.from(
              json['properties'].map((property) => Property.fromJson(property)))
          : [],
      propertyVariants: json['propertyVariants'] != null
          ? List<SocietyPropertyVariant>.from(json['propertyVariants']
              .map((variant) => SocietyPropertyVariant.fromJson(variant)))
          : [],
      expenses: json['expenses'] != null
          ? List<SocietyExpense>.from(json['expenses']
              .map((expense) => SocietyExpense.fromJson(expense)))
          : [],
    );
  }

  // ... other methods and validations ...
}
