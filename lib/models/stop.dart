class Stop {
  final String location;
  final String reason;
  final DateTime startTime;
  final DateTime endTime;

  const Stop({
    required this.location,
    required this.reason,
    required this.startTime,
    required this.endTime,
  });
}
