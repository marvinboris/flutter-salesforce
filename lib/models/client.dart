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
}
