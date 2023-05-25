class PollOption {
  int id;
  int pollId;
  String option;

  PollOption({
    required this.id,
    required this.pollId,
    required this.option,
  });

  // Method to convert PollOption object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pollId': pollId,
      'option': option,
    };
  }

  // Method to create a PollOption object from JSON
  factory PollOption.fromJson(Map<String, dynamic> json) {
    return PollOption(
      id: json['id'],
      pollId: json['pollId'],
      option: json['option'],
    );
  }

  // ... other methods and validations ...
}
