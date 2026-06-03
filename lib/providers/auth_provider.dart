import 'package:flutter/material.dart';
import 'package:book_swap/data/repositories/auth_repository.dart';
import 'package:book_swap/features/auth/data/models/user.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository;

  AuthProvider({required AuthRepository repository})
      : _repository = repository;

  User? _user;

  User? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await _repository.register(
        name: name,
        email: email,
        password: password,
      );

      if (user != null) {
        _user = user;
        notifyListeners();
        return true;
      }

      return false;
    } catch (e) {
      debugPrint('Register error: $e');
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _repository.login(
        email: email,
        password: password,
      );

      if (user != null) {
        _user = user;
        notifyListeners();
        return true;
      }

      return false;
    } catch (e) {
      debugPrint('Login error: $e');
      return false;
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
