import 'package:fluffyn_e_commerce/core/storage/sqflite_db/database_helper.dart';
import 'package:fluffyn_e_commerce/model/user_model.dart';

Future<void> insertUser(String email) async {
  final db = await DatabaseHelper.instance.database;
  await db.insert("user_data", {
    'email': email,
  });
}

Future<UserModel> readUser(String email) async {
  final db = await DatabaseHelper.instance.database;
  final result = await db.query(
    "user_data",
    where: 'email = ?',
    whereArgs: [email],
  );
  return UserModel.fromMap(result[0]);
}

Future<void> updateName(String email, String newName) async {
  final db = await DatabaseHelper.instance.database;
  db.update(
    "user_data",
    {"name": newName},
    where: 'email = ?',
    whereArgs: [email],
  );
}

Future<void> updatePhone(String email, String phone) async {
  final db = await DatabaseHelper.instance.database;
  db.update(
    "user_data",
    {'phone': phone},
    where: 'email = ?',
    whereArgs: [email],
  );
}
