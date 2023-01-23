enum InvoiceStatus {
  Pending,
  Completed,
  Cancelled,
}

class Invoice {
  final String client;
  final String number;
  final String location;
  final DateTime dateTime;
  final double amount;
  final String paymentMethod;
  final InvoiceStatus status;

  Invoice({
    required this.client,
    required this.number,
    required this.location,
    required this.dateTime,
    required this.amount,
    required this.paymentMethod,
    required this.status,
  });
}
