import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('e_commerce_app_data_fluffyn.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // User Table
    await db.execute('''
      CREATE TABLE user_data (
        email TEXT PRIMARY KEY,
        name TEXT,
        phone TEXT
      )
    ''');

    // Cart Table
    await db.execute('''
      CREATE TABLE cart (
        product_id INTEGER,
        user_id TEXT, 
        quantity INTEGER DEFAULT 1,
        PRIMARY KEY(product_id, user_id),
        FOREIGN KEY (user_id) REFERENCES user_data(email)
      )
    ''');

    // Transactions Table
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT,
        product_id INTEGER,
        quantity INTEGER,
        price REAL,
        date TEXT,
        FOREIGN KEY (user_id) REFERENCES user_data (email)
      )
    ''');

    await db.execute('''CREATE TRIGGER cart_quantity_update
         AFTER UPDATE ON cart
         FOR EACH ROW 
          WHEN NEW.quantity <= 0
    BEGIN
      DELETE FROM cart WHERE product_id = NEW.product_id;
    END;
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
