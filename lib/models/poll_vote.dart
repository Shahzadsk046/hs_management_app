import 'package:admin/models/poll.dart';
import 'package:admin/models/poll_option.dart';
import 'package:admin/models/user.dart';

class PollVote {
  int id;
  int pollId;
  int optionId;
  int userId;
  Poll? poll;
  PollOption? option;
  User? user;

  PollVote({
    required this.id,
    required this.pollId,
    required this.optionId,
    required this.userId,
    this.poll,
    this.option,
    this.user,
  });

  // Method to convert PollVote object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pollId': pollId,
      'optionId': optionId,
      'userId': userId,
      'poll': poll?.toJson(),
      'option': option?.toJson(),
      'user': user?.toJson(),
    };
  }

  // Method to create a PollVote object from JSON
  factory PollVote.fromJson(Map<String, dynamic> json) {
    return PollVote(
      id: json['id'],
      pollId: json['pollId'],
      optionId: json['optionId'],
      userId: json['userId'],
      poll: json['poll'] != null ? Poll.fromJson(json['poll']) : null,
      option:
          json['option'] != null ? PollOption.fromJson(json['option']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  // ... other methods and validations ...
}
