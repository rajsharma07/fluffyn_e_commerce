import 'package:fluffyn_e_commerce/core/storage/sqflite_db/database_helper.dart';
import 'package:fluffyn_e_commerce/model/cart_item_model.dart';

Future<void> addToCart(CartItemModel cartItem) async {
  final db = await DatabaseHelper.instance.database;
  await db.insert("cart", {
    'product_id': cartItem.productId,
    'user_id': cartItem.userId,
    'quantity': cartItem.quantity,
  });
}

Future<void> removeCartData(int productId, String email) async {
  final db = await DatabaseHelper.instance.database;
  db.delete(
    "cart",
    where: 'email = ? AND product_id = ?',
    whereArgs: [email, productId],
  );
}

Future<List<CartItemModel>> getCompleteCart(String email) async {
  final db = await DatabaseHelper.instance.database;
  final result = await db.query(
    'cart',
    where: 'user_id = ?',
    whereArgs: [email],
  );
  return result.map(
    (e) {
      return CartItemModel.fromMap(e);
    },
  ).toList();
}

Future<void> incrementProductQuantity(int productId, String email) async {
  final db = await DatabaseHelper.instance.database;
  db.rawUpdate(
    "UPDATE cart SET quantity = quantity + 1 WHERE product_id = ? AND user_id = ?",
    [productId, email],
  );
}

Future<void> decrementProductQuantity(int productId, String email) async {
  final db = await DatabaseHelper.instance.database;
  db.rawUpdate(
    "UPDATE cart SET quantity = quantity - 1 WHERE product_id = ? AND user_id = ?",
    [productId, email],
  );
}

Future<CartItemModel?> getProductFromCart(int productId, String email) async {
  final db = await DatabaseHelper.instance.database;
  final result = await db.query(
    'cart',
    where: 'product_id = ? ANF user_id = ?',
    whereArgs: [productId, email],
  );
  return result.isEmpty ? null : CartItemModel.fromMap(result[0]);
}
