class TransactionModel {
  final int productId;
  final int quantity;
  final double price;
  final DateTime date;
  TransactionModel({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.date,
  });
  factory TransactionModel.fromMap(Map<String, dynamic> m) {
    return TransactionModel(
      productId: m['product_id'],
      quantity: m['quantity'],
      price: m['price'],
      date: DateTime.parse(
        m['date'],
      ),
    );
  }
}
