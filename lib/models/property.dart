import 'package:admin/models/user.dart';

class Property {
  int id;
  PropertyType type;
  String title;
  String description;
  double price;
  bool isAvailable;
  int ownerId;
  User? owner;

  Property({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.price,
    required this.isAvailable,
    required this.ownerId,
    required this.owner,
  });

  // Method to convert Property object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'title': title,
      'description': description,
      'price': price,
      'isAvailable': isAvailable,
      'ownerId': ownerId,
      'owner': owner?.toJson(),
    };
  }

  // Method to create a Property object from JSON
  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      type: PropertyTypeExtension.fromString(json['type']),
      title: json['title'],
      description: json['description'],
      price: json['price'],
      isAvailable: json['isAvailable'],
      ownerId: json['ownerId'],
      owner: json['owner'] != null ? User.fromJson(json['owner']) : null,
    );
  }

  // ... other methods and validations ...
}

enum PropertyType {
  Flat,
  Shop,
}

// Extension to convert string to PropertyType enum
extension PropertyTypeExtension on PropertyType {
  static PropertyType fromString(String value) {
    return PropertyType.values.firstWhere(
      (type) =>
          type.toString().split('.').last.toLowerCase() == value.toLowerCase(),
    );
  }

  String getString() {
    return this.toString().split('.').last;
  }
}
