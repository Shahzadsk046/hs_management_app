import 'package:housing_society_management/models/committee_member.dart';
import 'package:housing_society_management/models/nominee.dart';
import 'package:housing_society_management/models/society.dart';
import 'package:housing_society_management/models/vote.dart';

class Election {
  int id;
  String title;
  DateTime startDate;
  DateTime endDate;
  int societyId;
  Society? society;
  List<CommitteeMember>? committeeMembers;
  List<Nominee>? nominees;
  List<Vote>? votes;

  Election({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.societyId,
    this.society,
    this.committeeMembers,
    this.nominees,
    this.votes,
  });

  // Method to convert Election object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'societyId': societyId,
      'society': society?.toJson(),
      'committeeMembers':
          committeeMembers?.map((member) => member.toJson())?.toList(),
      'nominees': nominees?.map((nominee) => nominee.toJson())?.toList(),
      'votes': votes?.map((vote) => vote.toJson())?.toList(),
    };
  }

  // Method to create an Election object from JSON
  factory Election.fromJson(Map<String, dynamic> json) {
    return Election(
      id: json['id'],
      title: json['title'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      societyId: json['societyId'],
      society:
          json['society'] != null ? Society.fromJson(json['society']) : null,
      committeeMembers: json['committeeMembers'] != null
          ? List<CommitteeMember>.from(json['committeeMembers']
              .map((memberJson) => CommitteeMember.fromJson(memberJson)))
          : null,
      nominees: json['nominees'] != null
          ? List<Nominee>.from(json['nominees']
              .map((nomineeJson) => Nominee.fromJson(nomineeJson)))
          : null,
      votes: json['votes'] != null
          ? List<Vote>.from(
              json['votes'].map((voteJson) => Vote.fromJson(voteJson)))
          : null,
    );
  }

  // ... other methods and validations ...
}
