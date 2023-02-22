class Stop {
  final String? id;
  final String location;
  final String reason;
  final DateTime startTime;
  final DateTime? endTime;

  const Stop({
    this.id,
    required this.location,
    required this.reason,
    required this.startTime,
    this.endTime,
  });

  factory Stop.fromJson(Map<String, dynamic> data) => Stop(
        id: data['_id'],
        location: data['location'],
        reason: data['reason'],
        startTime: DateTime.parse(data['startTime']),
        endTime:
            data['endTime'] != null ? DateTime.parse(data['endTime']) : null,
      );
}
