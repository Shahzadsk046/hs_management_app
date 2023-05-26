import 'package:housing_society_management/models/poll_option.dart';
import 'package:housing_society_management/models/society.dart';
import 'package:housing_society_management/models/user.dart';

class Poll {
  int id;
  String question;
  int createdBy;
  DateTime createdAt;
  int societyId;
  User? creator;
  Society? society;
  List<PollOption> options;

  Poll({
    required this.id,
    required this.question,
    required this.createdBy,
    required this.createdAt,
    required this.societyId,
    this.creator,
    this.society,
    required this.options,
  });

  // Method to convert Poll object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'societyId': societyId,
      'creator': creator?.toJson(),
      'society': society?.toJson(),
      'options': options.map((option) => option.toJson()).toList(),
    };
  }

  // Method to create a Poll object from JSON
  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      id: json['id'],
      question: json['question'],
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['createdAt']),
      societyId: json['societyId'],
      creator: json['creator'] != null ? User.fromJson(json['creator']) : null,
      society:
          json['society'] != null ? Society.fromJson(json['society']) : null,
      options: List<PollOption>.from(
          json['options'].map((optionJson) => PollOption.fromJson(optionJson))),
    );
  }

  // ... other methods and validations ...
}
