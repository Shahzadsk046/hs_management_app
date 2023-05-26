import 'package:housing_society_management/models/society.dart';
import 'package:housing_society_management/models/user.dart';

class SocietyExpense {
  int id;
  String title;
  String description;
  double amount;
  int createdBy;
  int societyId;
  User? creator;
  Society? society;

  SocietyExpense({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.createdBy,
    required this.societyId,
    required this.creator,
    required this.society,
  });

  // Method to convert SocietyExpense object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'createdBy': createdBy,
      'societyId': societyId,
      'creator': creator?.toJson(),
      'society': society?.toJson(),
    };
  }

  // Method to create a SocietyExpense object from JSON
  factory SocietyExpense.fromJson(Map<String, dynamic> json) {
    return SocietyExpense(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      amount: json['amount'],
      createdBy: json['createdBy'],
      societyId: json['societyId'],
      creator: json['creator'] != null ? User.fromJson(json['creator']) : null,
      society:
          json['society'] != null ? Society.fromJson(json['society']) : null,
    );
  }

  // ... other methods and validations ...
}
