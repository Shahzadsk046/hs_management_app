import 'package:housing_society_management/models/society.dart';
import 'package:housing_society_management/models/user.dart';

class Event {
  int id;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  int createdBy;
  int societyId;
  User? creator;
  Society? society;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.createdBy,
    required this.societyId,
    this.creator,
    this.society,
  });

  // Method to convert Event object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'createdBy': createdBy,
      'societyId': societyId,
      'creator': creator?.toJson(),
      'society': society?.toJson(),
    };
  }

  // Method to create an Event object from JSON
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      createdBy: json['createdBy'],
      societyId: json['societyId'],
      creator: json['creator'] != null ? User.fromJson(json['creator']) : null,
      society:
          json['society'] != null ? Society.fromJson(json['society']) : null,
    );
  }

  // ... other methods and validations ...
}
