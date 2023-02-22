enum ClientStatus {
  Active,
  Inactive,
}

class Client {
  final String? id;
  final String name;
  final String location;
  final String phone;
  final String email;
  final ClientStatus? status;
  final DateTime? joinedAt;
  final String? photo;

  Client({
    this.id,
    required this.name,
    required this.location,
    required this.phone,
    required this.email,
    this.joinedAt,
    this.photo,
    this.status = ClientStatus.Active,
  });

  factory Client.fromJson(Map<String, dynamic> data) => Client(
        id: data['_id'],
        name: data['name'],
        phone: data['phone'],
        email: data['email'],
        joinedAt: DateTime.parse(data['joinedAt']),
        location: data['location'],
        photo: data['photo'],
        status: [
          ClientStatus.Active,
          ClientStatus.Inactive,
        ][data['status']],
      );
}
