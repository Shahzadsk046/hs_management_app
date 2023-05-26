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
  Society society;
  List<CommitteeMember> committeeMembers;
  List<Nominee> nominees;
  List<Vote> votes;

  Election({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.societyId,
    required this.society,
    this.committeeMembers = const [],
    this.nominees = const [],
    this.votes = const [],
  });

  // Method to convert Election object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'societyId': societyId,
      'society': society.toJson(),
      'committeeMembers':
          committeeMembers.map((member) => member.toJson()).toList(),
      'nominees': nominees.map((nominee) => nominee.toJson()).toList(),
      'votes': votes.map((vote) => vote.toJson()).toList(),
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
      society: Society.fromJson(json['society']),
      committeeMembers: List<CommitteeMember>.from(json['committeeMembers']
          .map((memberJson) => CommitteeMember.fromJson(memberJson))),
      nominees: List<Nominee>.from(
          json['nominees'].map((nomineeJson) => Nominee.fromJson(nomineeJson))),
      votes: List<Vote>.from(
          json['votes'].map((voteJson) => Vote.fromJson(voteJson))),
    );
  }

  // ... other methods and validations ...

  void addNominee(Nominee nominee) {
    nominees.add(nominee);
  }

  void castVote(Vote vote) {
    votes.add(vote);
  }

  // Get the committee members associated with this election
  // List<CommitteeMember> getElectionCommitteeMembers() {
  //   if (committeeMembers != null) {
  //     return committeeMembers!;
  //   }
  //   return [];
  // }
  List<CommitteeMember> getElectionCommitteeMembers() {
    return committeeMembers;
  }

  // Get the nominees associated with this election
  // List<Nominee> getElectionNominees() {
  //   if (nominees != null) {
  //     return nominees!;
  //   }
  //   return [];
  // }
  List<Nominee> getElectionNominees() {
    return nominees;
  }

  // Get the votes associated with this election
  // List<Vote> getElectionVotes() {
  //   if (votes != null) {
  //     return votes!;
  //   }
  //   return [];
  // }
  List<Vote> getElectionVotes() {
    return votes;
  }

  // Logic to calculate and return the election results
  // You can use the 'nominees' and 'votes' properties to calculate the results
  // Return a sorted list of nominees based on the vote count
  List<Nominee> getElectionResults() {
    Map<Nominee, int> voteCountMap = {};

    // Count the votes for each nominee
    // for (Vote vote in votes) {
    //   Nominee? nominee = vote.nominee;
    //   if (voteCountMap.containsKey(nominee)) {
    //     voteCountMap[nominee]!++;
    //   } else {
    //     voteCountMap[nominee!] = 1;
    //   }
    // }

    for (Vote vote in votes) {
      Nominee nominee =
          nominees.firstWhere((nominee) => nominee.id == vote.nomineeId);
      if (voteCountMap.containsKey(nominee)) {
        // voteCountMap[nominee]!++;
        voteCountMap[nominee] = voteCountMap[nominee]! + 1;
      } else {
        voteCountMap[nominee] = 1;
      }
    }

    // Sort the nominees based on the vote count in descending order
    List<Nominee> sortedNominees = voteCountMap.keys.toList();
    sortedNominees.sort((a, b) => voteCountMap[b]!.compareTo(voteCountMap[a]!));

    return sortedNominees;
  }
}
