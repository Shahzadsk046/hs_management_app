import 'package:housing_society_management/models/election.dart';
import 'package:housing_society_management/models/committee_member.dart';
import 'package:housing_society_management/models/nominee.dart';
import 'package:housing_society_management/models/vote.dart';
import 'package:housing_society_management/services/api/api_service.dart';

class ElectionService {
  final ApiService _apiService = ApiService();

  // Retrieve all elections
// Retrieve all elections
  Future<List<Election>> getAllElections() async {
    try {
      final response = await _apiService.get('/elections');
      final List<dynamic> jsonData = response['data'];
      return jsonData.map((data) => Election.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Failed to fetch elections: $e');
    }
  }

  // Retrieve a single election by ID
  Future<Election?> getElectionById(int id) async {
    try {
      final response = await _apiService.get('/elections/$id');
      final jsonData = response['data'];
      return Election.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to fetch election: $e');
    }
  }

  // Create a new election
  // Future<Election?> createElection(Election election) async {
  //   try {
  //     final response = await _apiService.post('/elections', election.toJson());
  //     final jsonData = response['data'];
  //     return Election.fromJson(jsonData);
  //   } catch (e) {
  //     throw Exception('Failed to create election: $e');
  //   }
  // }
  Future<void> createElection(
      {required String title,
      required DateTime startDate,
      required DateTime endDate,
      required int societyId}) async {
    try {
      final data = {
        'title': title,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'societyId': societyId,
      };

      await _apiService.post('/elections', data);
    } catch (error) {
      throw Exception('Failed to create election');
    }
  }

  // Update an existing election
  // Future<Election?> updateElection(Election election) async {
  //   try {
  //     final response =
  //         await _apiService.put('/elections/${election.id}', election.toJson());
  //     final jsonData = response['data'];
  //     return Election.fromJson(jsonData);
  //   } catch (e) {
  //     throw Exception('Failed to update election: $e');
  //   }
  // }
  Future<void> updateElection(Election election) async {
    try {
      final data = {
        'title': election.title,
        'startDate': election.startDate.toIso8601String(),
        'endDate': election.endDate.toIso8601String(),
        'societyId': election.societyId,
      };

      await _apiService.put('/elections/${election.id}', data);
    } catch (error) {
      throw Exception('Failed to update election');
    }
  }

  // Delete an election
  Future<void> deleteElection(int id) async {
    try {
      await _apiService.delete('/elections/$id');
    } catch (e) {
      throw Exception('Failed to delete election: $e');
    }
  }

  // Retrieve all committee members of an election
  Future<List<CommitteeMember>> getCommitteeMembersByElectionId(
      int electionId) async {
    try {
      final response =
          await _apiService.get('/elections/$electionId/committee-members');
      final List<dynamic> jsonData = response['data'];
      return jsonData.map((data) => CommitteeMember.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Failed to fetch committee members: $e');
    }
  }

  // Retrieve all nominees of an election
  Future<List<Nominee>> getNomineesByElectionId(int electionId) async {
    try {
      final response = await _apiService.get('/elections/$electionId/nominees');
      final List<dynamic> jsonData = response['data'];
      return jsonData.map((data) => Nominee.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Failed to fetch nominees: $e');
    }
  }

  // Retrieve all votes of an election
  Future<List<Vote>> getVotesByElectionId(int electionId) async {
    try {
      final response = await _apiService.get('/elections/$electionId/votes');
      final List<dynamic> jsonData = response['data'];
      return jsonData.map((data) => Vote.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Failed to fetch votes: $e');
    }
  }

  // Logic to calculate and return the election results
  // You can use the 'nominees' and 'votes' properties to calculate the results
  // Return a sorted list of nominees based on the vote count
  Future<List<Nominee>> calculateElectionResults(int electionId) async {
    // Fetch the nominees and votes of the election
    List<Nominee> nominees = await getNomineesByElectionId(electionId);
    List<Vote> votes = await getVotesByElectionId(electionId);

    // Create a map to store the vote count for each nominee
    Map<Nominee, int> voteCountMap = {};

    // Count the votes for each nominee
    for (Vote vote in votes) {
      Nominee nominee =
          nominees.firstWhere((nominee) => nominee.id == vote.nomineeId);
      voteCountMap[nominee] = (voteCountMap[nominee] ?? 0) + 1;
    }

    // Sort the nominees based on the vote count in descending order
    nominees.sort((a, b) => voteCountMap[b]!.compareTo(voteCountMap[a]!));

    return nominees;
  }
}
