class Product {
  final String id;
  final String title;
  final double price;
  final String? promo;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.promo,
  });

  factory Product.fromJson(Map<String, dynamic> data) => Product(
        id: data['_id'],
        title: data['title'],
        price: data['price'],
        promo: data['promo'],
      );
}
