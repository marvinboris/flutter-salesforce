enum AppointmentStatus {
  Incoming,
  Done,
  Cancelled,
}

class Appointment {
  final String id;
  final DateTime date;
  final String name;
  final String shop;
  final String object;
  final String location;
  final String company;
  final AppointmentStatus status;

  Appointment({
    required this.id,
    required this.date,
    required this.name,
    required this.shop,
    required this.object,
    required this.location,
    required this.company,
    this.status = AppointmentStatus.Incoming,
  });
}
