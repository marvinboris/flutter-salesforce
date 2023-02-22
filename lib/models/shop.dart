enum ShopStatus {
  Active,
  Inactive,
}

class Shop {
  final String? id;
  final String manager;
  final String name;
  final String location;
  final String phone;
  final String email;
  final String? photo;
  final ShopStatus status;

  Shop({
    this.id,
    required this.manager,
    required this.name,
    required this.location,
    required this.phone,
    required this.email,
    this.photo,
    this.status = ShopStatus.Active,
  });

  factory Shop.fromJson(Map<String, dynamic> data) => Shop(
        id: data['_id'],
        manager: data['manager'],
        name: data['name'],
        location: data['location'],
        phone: data['phone'],
        email: data['email'],
        photo: data['photo'],
        status: [
          ShopStatus.Active,
          ShopStatus.Inactive,
        ][data['status']],
      );
}
