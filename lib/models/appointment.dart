enum AppointmentStatus {
  Incoming,
  Done,
  Cancelled,
}

class Appointment {
  final String? id;
  final DateTime date;
  final String name;
  final String shop;
  final String object;
  final String location;
  final String company;
  final AppointmentStatus status;

  Appointment({
    this.id,
    required this.date,
    required this.name,
    required this.shop,
    required this.object,
    required this.location,
    required this.company,
    this.status = AppointmentStatus.Incoming,
  });

  factory Appointment.fromJson(dynamic data) => Appointment(
        id: data['_id'],
        date: DateTime.parse(data['date']),
        name: data['client'],
        shop: data['shop'],
        object: data['object'],
        location: data['location'],
        company: data['company'],
        status: [
          AppointmentStatus.Incoming,
          AppointmentStatus.Done,
          AppointmentStatus.Cancelled,
        ][data['status']],
      );
}
