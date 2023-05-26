import 'package:housing_society_management/models/society.dart';

class ParkingLot {
  int id;
  String number;
  bool availability;
  int societyId;
  Society? society;

  ParkingLot({
    required this.id,
    required this.number,
    required this.availability,
    required this.societyId,
    this.society,
  });

  // Method to convert ParkingLot object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'availability': availability,
      'societyId': societyId,
      'society': society?.toJson(),
    };
  }

  // Method to create a ParkingLot object from JSON
  factory ParkingLot.fromJson(Map<String, dynamic> json) {
    return ParkingLot(
      id: json['id'],
      number: json['number'],
      availability: json['availability'],
      societyId: json['societyId'],
      society:
          json['society'] != null ? Society.fromJson(json['society']) : null,
    );
  }

  // ... other methods and validations ...
}
