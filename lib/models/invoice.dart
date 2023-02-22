enum InvoiceStatus {
  Pending,
  Completed,
  Cancelled,
}

class Invoice {
  final String? id;
  final String client;
  final String number;
  final String location;
  final DateTime dateTime;
  final double amount;
  final String method;
  final InvoiceStatus status;

  Invoice({
    this.id,
    required this.client,
    required this.number,
    required this.location,
    required this.dateTime,
    required this.amount,
    required this.method,
    required this.status,
  });

  factory Invoice.fromJson(Map<String, dynamic> data) => Invoice(
        id: data['_id'],
        client: data['client'],
        number: data['number'],
        location: data['location'],
        dateTime: DateTime.parse(data['dateTime']),
        amount: data['amount'],
        method: data['method'],
        status: [
          InvoiceStatus.Pending,
          InvoiceStatus.Completed,
          InvoiceStatus.Cancelled,
        ][data['status']],
      );
}
