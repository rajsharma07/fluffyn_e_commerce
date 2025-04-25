class TransactionModel {
  final int productId;
  final int quantity;
  final String title;
  final double price;
  final DateTime date;
  TransactionModel({
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
    required this.date,
  });
  factory TransactionModel.fromMap(Map<String, dynamic> m, String title) {
    return TransactionModel(
      productId: m['product_id'],
      title: title,
      quantity: m['quantity'],
      price: m['price'],
      date: DateTime.parse(
        m['date'],
      ),
    );
  }
}
