class CartItemModel {
  final int productId;
  final String userId;
  int quantity;
  CartItemModel({
    required this.productId,
    required this.userId,
    this.quantity = 1,
  });
  factory CartItemModel.fromMap(Map<String, dynamic> m) {
    return CartItemModel(
      productId: m['product_id'],
      userId: m['user_id'],
      quantity: m['quantity'],
    );
  }
}
