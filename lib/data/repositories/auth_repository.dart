import 'package:flutter/foundation.dart';
import 'package:book_swap/features/auth/data/models/user.dart';
import 'package:book_swap/core/database/database_helper.dart';

class AuthRepository {
  final DatabaseHelper _db =
      DatabaseHelper.instance;

  Future<User?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final existingUser =
          await getUserByEmail(email);

      if (existingUser != null) {
        return null;
      }

      final user = User(
        id: DateTime.now()
            .millisecondsSinceEpoch
            .toString(),
        name: name,
        email: email,
        password: password,
      );

      final db = await _db.database;

      await db.insert(
        'users',
        user.toMap(),
      );

      return user;
    } catch (e) {
      debugPrint('Erro no registro: $e');

      return null;
    }
  }

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      final db = await _db.database;

      final result = await db.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );

      if (result.isNotEmpty) {
        return User.fromMap(result.first);
      }

      return null;
    } catch (e) {
      debugPrint('Erro no login: $e');

      return null;
    }
  }

  Future<User?> getUserByEmail(
    String email,
  ) async {
    final db = await _db.database;

    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }

    return null;
  }
}