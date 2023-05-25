import 'package:admin/models/society.dart';

class SocietyPropertyVariant {
  int id;
  String name;
  String description;
  int societyId;
  Society? society;

  SocietyPropertyVariant({
    required this.id,
    required this.name,
    required this.description,
    required this.societyId,
    required this.society,
  });

  // Method to convert SocietyPropertyVariant object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'societyId': societyId,
      'society': society?.toJson(),
    };
  }

  // Method to create a SocietyPropertyVariant object from JSON
  factory SocietyPropertyVariant.fromJson(Map<String, dynamic> json) {
    return SocietyPropertyVariant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      societyId: json['societyId'],
      society:
          json['society'] != null ? Society.fromJson(json['society']) : null,
    );
  }

  // ... other methods and validations ...
}
