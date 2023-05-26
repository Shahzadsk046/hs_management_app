import 'package:housing_society_management/models/property.dart';
import 'package:housing_society_management/models/society.dart';
import 'package:housing_society_management/models/society_property_variant.dart';

class SocietyProperty {
  int id;
  int propertyId;
  int societyId;
  int propertyVariantId;
  Property? property;
  Society? society;
  SocietyPropertyVariant? propertyVariant;

  SocietyProperty({
    required this.id,
    required this.propertyId,
    required this.societyId,
    required this.propertyVariantId,
    required this.property,
    required this.society,
    required this.propertyVariant,
  });

  // Method to convert SocietyProperty object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'societyId': societyId,
      'propertyVariantId': propertyVariantId,
      'property': property?.toJson(),
      'society': society?.toJson(),
      'propertyVariant': propertyVariant?.toJson(),
    };
  }

  // Method to create a SocietyProperty object from JSON
  factory SocietyProperty.fromJson(Map<String, dynamic> json) {
    return SocietyProperty(
      id: json['id'],
      propertyId: json['propertyId'],
      societyId: json['societyId'],
      propertyVariantId: json['propertyVariantId'],
      property:
          json['property'] != null ? Property.fromJson(json['property']) : null,
      society:
          json['society'] != null ? Society.fromJson(json['society']) : null,
      propertyVariant: json['propertyVariant'] != null
          ? SocietyPropertyVariant.fromJson(json['propertyVariant'])
          : null,
    );
  }

  // ... other methods and validations ...
}
