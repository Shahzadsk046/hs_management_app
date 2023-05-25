class PollVoteResult {
  int id;
  int pollId;
  int optionId;
  int count;

  PollVoteResult({
    required this.id,
    required this.pollId,
    required this.optionId,
    required this.count,
  });

  // Method to convert PollVoteResult object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pollId': pollId,
      'optionId': optionId,
      'count': count,
    };
  }

  // Method to create a PollVoteResult object from JSON
  factory PollVoteResult.fromJson(Map<String, dynamic> json) {
    return PollVoteResult(
      id: json['id'],
      pollId: json['pollId'],
      optionId: json['optionId'],
      count: json['count'],
    );
  }

  // ... other methods and validations ...
}
