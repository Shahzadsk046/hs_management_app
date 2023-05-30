// import 'package:housing_society_management/models/committee_member.dart';
// import 'package:housing_society_management/models/election.dart';
// import 'package:housing_society_management/models/event.dart';
// import 'package:housing_society_management/models/maintenance_charge.dart';
// import 'package:housing_society_management/models/nominee.dart';
// import 'package:housing_society_management/models/parking_lot.dart';
// import 'package:housing_society_management/models/poll_vote.dart';
// import 'package:housing_society_management/models/property.dart';
// import 'package:housing_society_management/models/society.dart';
// import 'package:housing_society_management/models/vote.dart';
import 'package:uuid/uuid.dart';

class User {
  late int id;
  String name;
  String email;
  String password;
  String phone;
  String role;

  // List<Property>? properties;
  // List<Election>? elections;
  // List<CommitteeMember>? committeeMembers;
  // List<Nominee>? nominees;
  // List<Vote>? votes;
  // List<PollVote>? pollVotes;
  // List<Event>? events;
  // List<ParkingLot>? parkingLots;
  // List<MaintenanceCharge>? maintenanceCharges;
  // Society? society;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
    // this.properties,
    // this.elections,
    // this.committeeMembers,
    // this.nominees,
    // this.votes,
    // this.pollVotes,
    // this.events,
    // this.parkingLots,
    // this.maintenanceCharges,
    // this.society,
  }) {
    id = int.parse(Uuid().v4().replaceAll('-', ''), radix: 16);
  }

  // Method to convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'role': role,
      // role.toString().split('.').last, // Convert enum to string
      // 'properties': properties?.map((property) => property.toJson()).toList(),
      // 'elections': elections?.map((election) => election.toJson()).toList(),
      // 'committeeMembers':
      //     committeeMembers?.map((member) => member.toJson()).toList(),
      // 'nominees': nominees?.map((nominee) => nominee.toJson()).toList(),
      // 'votes': votes?.map((vote) => vote.toJson()).toList(),
      // 'pollVotes': pollVotes?.map((pollVote) => pollVote.toJson()).toList(),
      // 'events': events?.map((event) => event.toJson()).toList(),
      // 'parkingLots':
      //     parkingLots?.map((parkingLot) => parkingLot.toJson()).toList(),
      // 'maintenanceCharges':
      //     maintenanceCharges?.map((charge) => charge.toJson()).toList(),
      // 'society': society?.toJson(),
    };
  }

  // Method to create a User object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String,
      // properties: json['properties'] != null
      //     ? List<Property>.from(json['properties']
      //         .map((propertyJson) => Property.fromJson(propertyJson)))
      //     : null,
      // elections: json['elections'] != null
      //     ? List<Election>.from(json['elections']
      //         .map((electionJson) => Election.fromJson(electionJson)))
      //     : null,
      // committeeMembers: json['committeeMembers'] != null
      //     ? List<CommitteeMember>.from(json['committeeMembers']
      //         .map((memberJson) => CommitteeMember.fromJson(memberJson)))
      //     : null,
      // nominees: json['nominees'] != null
      //     ? List<Nominee>.from(json['nominees']
      //         .map((nomineeJson) => Nominee.fromJson(nomineeJson)))
      //     : null,
      // votes: json['votes'] != null
      //     ? List<Vote>.from(
      //         json['votes'].map((voteJson) => Vote.fromJson(voteJson)))
      //     : null,
      // pollVotes: json['pollVotes'] != null
      //     ? List<PollVote>.from(json['pollVotes']
      //         .map((pollVoteJson) => PollVote.fromJson(pollVoteJson)))
      //     : null,
      // events: json['events'] != null
      //     ? List<Event>.from(
      //         json['events'].map((eventJson) => Event.fromJson(eventJson)))
      //     : null,
      // parkingLots: json['parkingLots'] != null
      //     ? List<ParkingLot>.from(json['parkingLots']
      //         .map((parkingLotJson) => ParkingLot.fromJson(parkingLotJson)))
      //     : null,
      // maintenanceCharges: json['maintenanceCharges'] != null
      //     ? List<MaintenanceCharge>.from(json['maintenanceCharges']
      //         .map((chargeJson) => MaintenanceCharge.fromJson(chargeJson)))
      //     : null,
      // society:
      //     json['society'] != null ? Society.fromJson(json['society']) : null,

      // properties: json['properties'] != null
      //     ? (json['properties'] as List)
      //         .map((item) => Property.fromJson(item))
      //         .toList()
      //     : null,
      // elections: json['elections'] != null
      //     ? (json['elections'] as List)
      //         .map((item) => Election.fromJson(item))
      //         .toList()
      //     : null,
      // committeeMembers: json['committeeMembers'] != null
      //     ? (json['committeeMembers'] as List)
      //         .map((item) => CommitteeMember.fromJson(item))
      //         .toList()
      //     : null,
      // nominees: json['nominees'] != null
      //     ? (json['nominees'] as List)
      //         .map((item) => Nominee.fromJson(item))
      //         .toList()
      //     : null,
      // votes: json['votes'] != null
      //     ? (json['votes'] as List).map((item) => Vote.fromJson(item)).toList()
      //     : null,
      // pollVotes: json['pollVotes'] != null
      //     ? (json['pollVotes'] as List)
      //         .map((item) => PollVote.fromJson(item))
      //         .toList()
      //     : null,
      // events: json['events'] != null
      //     ? (json['events'] as List)
      //         .map((item) => Event.fromJson(item))
      //         .toList()
      //     : null,
      // parkingLots: json['parkingLots'] != null
      //     ? (json['parkingLots'] as List)
      //         .map((item) => ParkingLot.fromJson(item))
      //         .toList()
      //     : null,
      // maintenanceCharges: json['maintenanceCharges'] != null
      //     ? (json['maintenanceCharges'] as List)
      //         .map((item) => MaintenanceCharge.fromJson(item))
      //         .toList()
      //     : null,
      // society:
      //     json['society'] != null ? Society.fromJson(json['society']) : null,
    );
  }

  // ... other methods and validations ...
}

// enum UserRole {
//   admin,
//   owner,
//   tenant,
// }

// // Extension to convert string to UserRole enum
// extension UserRoleExtension on UserRole {
//   static UserRole fromString(String value) {
//     return UserRole.values.firstWhere(
//       (role) =>
//           role.toString().split('.').last.toLowerCase() == value.toLowerCase(),
//     );
//   }

//   String getString() {
//     return this.toString().split('.').last;
//   }
// }
