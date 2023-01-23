enum ShopStatus {
  Active,
  Inactive,
}

class Shop {
  final String manager;
  final String name;
  final String location;
  final String phone;
  final String email;
  final String? photo;
  final ShopStatus status;

  Shop({
    required this.manager,
    required this.name,
    required this.location,
    required this.phone,
    required this.email,
    this.photo,
    this.status = ShopStatus.Active,
  });
}
