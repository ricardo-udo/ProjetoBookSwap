import 'package:book_swap/core/database/database_helper.dart';
import '../../features/auth/data/models/user.dart';

class UserRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;

  Future<void> insertUser(User user) async {
    final db = await _db.database;
    await db.insert('users', user.toMap());
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await _db.database;
    final maps = await db.query('users', where: 'email = ?', whereArgs: [email]);
    return maps.isNotEmpty ? User.fromMap(maps.first) : null;
  }

  Future<User?> getUserById(String id) async {
    final db = await _db.database;
    final maps = await db.query('users', where: 'id = ?', whereArgs: [id]);
    return maps.isNotEmpty ? User.fromMap(maps.first) : null;
  }
}
