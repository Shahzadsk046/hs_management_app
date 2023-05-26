import 'package:housing_society_management/models/election.dart';
import 'package:housing_society_management/models/nominee.dart';
import 'package:housing_society_management/models/user.dart';

class Vote {
  int id;
  int userId;
  int electionId;
  int nomineeId;
  User? user;
  Election? election;
  Nominee? nominee;

  Vote({
    required this.id,
    required this.userId,
    required this.electionId,
    required this.nomineeId,
    required this.user,
    required this.election,
    required this.nominee,
  });

  // Method to convert Vote object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'electionId': electionId,
      'nomineeId': nomineeId,
      'user': user?.toJson(),
      'election': election?.toJson(),
      'nominee': nominee?.toJson(),
    };
  }

  // Method to create a Vote object from JSON
  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      id: json['id'],
      userId: json['userId'],
      electionId: json['electionId'],
      nomineeId: json['nomineeId'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      election:
          json['election'] != null ? Election.fromJson(json['election']) : null,
      nominee:
          json['nominee'] != null ? Nominee.fromJson(json['nominee']) : null,
    );
  }

  // ... other methods and validations ...
}
