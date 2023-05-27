import 'package:housing_society_management/models/society.dart';
import 'package:housing_society_management/models/user.dart';

class MaintenanceCharge {
  int id;
  String title;
  String description;
  double amount;
  DateTime dueDate;
  int createdBy;
  int societyId;
  User? creator;
  Society? society;

  MaintenanceCharge({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.dueDate,
    required this.createdBy,
    required this.societyId,
    this.creator,
    this.society,
  });

  // Method to convert MaintenanceCharge object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'dueDate': dueDate.toIso8601String(),
      'createdBy': createdBy,
      'societyId': societyId,
      'creator': creator?.toJson(),
      'society': society?.toJson(),
    };
  }

  // Method to create a MaintenanceCharge object from JSON
  factory MaintenanceCharge.fromJson(Map<String, dynamic> json) {
    return MaintenanceCharge(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      amount: json['amount'],
      dueDate: DateTime.parse(json['dueDate']),
      createdBy: json['createdBy'],
      societyId: json['societyId'],
      creator: json['creator'] != null ? User.fromJson(json['creator']) : null,
      society:
          json['society'] != null ? Society.fromJson(json['society']) : null,
    );
  }

  // ... other methods and validations ...
}
