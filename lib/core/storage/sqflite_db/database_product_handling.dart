import 'package:fluffyn_e_commerce/core/storage/sqflite_db/database_helper.dart';
import 'package:fluffyn_e_commerce/model/products_model.dart';

Future<void> addProduct(ProductsModel model, String email) async {
  final db = await DatabaseHelper.instance.database;
  await db.insert("products", {
    "user_id": email,
    "title": model.title,
    "price": model.price,
    "description": model.description,
    "category": model.category,
    "date": DateTime.now().toString(),
  });
}

Future<List<ProductsModel>> getProducts(String email) async {
  final db = await DatabaseHelper.instance.database;
  final result =
      await db.query("products", where: "user_id = ?", whereArgs: [email]);
  return result.map(
    (e) {
      return ProductsModel(
        id: e['id'] as int,
        title: e['title'] as String,
        price: e['price'] as double,
        description: e['description'] as String,
        category: e['category'] as String,
        image: "",
        rating: Rating(0.0, 0),
      );
    },
  ).toList();
}

Future<void> removeProduct(int id, String email) async {
  final db = await DatabaseHelper.instance.database;
  await db.delete("products",
      where: "id = ? AND user_id = ?", whereArgs: [id, email]);
}

Future<int> getNewId() async {
  final db = await DatabaseHelper.instance.database;
  final result = await db.rawQuery("SELECT MAX(id) as mid FROM products");
  if (result.first['mid'] == null) {
    return 0;
  }
  return result.first['mid'] as int;
}

Future<void> updateProduct(ProductsModel product, String email) async {
  final db = await DatabaseHelper.instance.database;
  await db.update(
    "products",
    {
      "title": product.title,
      "price": product.price,
      "description": product.description,
      "category": product.category,
      "date": DateTime.now().toString(),
    },
    where: "id = ? AND user_id = ?",
    whereArgs: [product.id, email],
  );
}
