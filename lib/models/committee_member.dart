import 'package:admin/models/election.dart';
import 'package:admin/models/user.dart';

class CommitteeMember {
  int id;
  int userId;
  int electionId;
  UserRole role;
  User? user;
  Election? election;

  CommitteeMember({
    required this.id,
    required this.userId,
    required this.electionId,
    required this.role,
    required this.user,
    required this.election,
  });

  // Method to convert CommitteeMember object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'electionId': electionId,
      'role': role.getString(),
      'user': user?.toJson(),
      'election': election?.toJson(),
    };
  }

  // Method to create a CommitteeMember object from JSON
  factory CommitteeMember.fromJson(Map<String, dynamic> json) {
    return CommitteeMember(
      id: json['id'],
      userId: json['userId'],
      electionId: json['electionId'],
      role: UserRoleExtension.fromString(json['role']),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      election:
          json['election'] != null ? Election.fromJson(json['election']) : null,
    );
  }

  // ... other methods and validations ...
}
