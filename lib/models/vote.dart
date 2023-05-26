import 'package:housing_society_management/models/election.dart';
import 'package:housing_society_management/models/nominee.dart';
import 'package:housing_society_management/models/user.dart';

class Vote {
  int id;
  int electionId;
  int nomineeId;
  String nomineeName;
  int voterId;
  String voterName;
  User? user;
  Election? election;
  Nominee? nominee;

  Vote({
    required this.id,
    required this.electionId,
    required this.nomineeId,
    required this.nomineeName,
    required this.voterId,
    required this.voterName,
    required this.user,
    required this.election,
    required this.nominee,
  });

  // Method to convert Vote object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'electionId': electionId,
      'nomineeId': nomineeId,
      'nomineeName': nomineeName,
      'voterId': voterId,
      'voterName': voterName,
      'user': user?.toJson(),
      'election': election?.toJson(),
      'nominee': nominee?.toJson(),
    };
  }

  // Method to create a Vote object from JSON
  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      id: json['id'],
      electionId: json['electionId'],
      nomineeId: json['nomineeId'],
      nomineeName: json['nomineeName'],
      voterId: json['voterId'],
      voterName: json['voterName'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      election:
          json['election'] != null ? Election.fromJson(json['election']) : null,
      nominee:
          json['nominee'] != null ? Nominee.fromJson(json['nominee']) : null,
    );
  }

  // ... other methods and validations ...
}
