class Transaction {
  final String name;
  final double amount;
  final String product;
  final DateTime date;
  final int qty;

  const Transaction({
    required this.name,
    required this.amount,
    required this.product,
    required this.date,
    required this.qty,
  });
}
