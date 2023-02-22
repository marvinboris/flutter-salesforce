class Transaction {
  final String? id;
  final String client;
  final String product;
  final DateTime? date;
  final int qty;

  const Transaction({
    this.id,
    required this.client,
    required this.product,
    this.date,
    required this.qty,
  });

  factory Transaction.fromJson(Map<String, dynamic> data) => Transaction(
        id: data['_id'],
        client: data['client'],
        product: data['product'],
        qty: data['qty'],
        date: DateTime.parse(data['date']),
      );
}
