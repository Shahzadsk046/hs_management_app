import 'package:housing_society_management/models/election.dart';
import 'package:housing_society_management/models/user.dart';

class Nominee {
  int id;
  int userId;
  int electionId;
  User? user;
  Election? election;

  Nominee({
    required this.id,
    required this.userId,
    required this.electionId,
    this.user,
    this.election,
  });

  // Method to convert Nominee object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'electionId': electionId,
      'user': user?.toJson(),
      'election': election?.toJson(),
    };
  }

  // Method to create a Nominee object from JSON
  factory Nominee.fromJson(Map<String, dynamic> json) {
    return Nominee(
      id: json['id'],
      userId: json['userId'],
      electionId: json['electionId'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      election:
          json['election'] != null ? Election.fromJson(json['election']) : null,
    );
  }

  // ... other methods and validations ...
}
