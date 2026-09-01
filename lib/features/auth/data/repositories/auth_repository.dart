import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthRepository {
  static const _userKey = 'user_data';
  static const _tokenKey = 'auth_token';

  // Login
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Validation
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }

    if (password.length < 6) {
      throw Exception('Invalid credentials');
    }

    // Mock user
    final user = UserModel(
      id: '1',
      name: 'Imran Hossain',
      email: email,
      phone: '01700000000',
    );

    // Save to local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
    await prefs.setString(_tokenKey, 'mock_token_123');

    return user;
  }

  // Register
  Future<UserModel> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Validation
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      throw Exception('All fields are required');
    }

    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    // Mock user
    final user = UserModel(
      id: '1',
      name: name,
      email: email,
      phone: phone,
    );

    // Save to local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
    await prefs.setString(_tokenKey, 'mock_token_123');

    return user;
  }

  // Forgot Password
  Future<void> forgotPassword({required String email}) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty) {
      throw Exception('Email is required');
    }
  }

  // Get current user
  Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    final token = prefs.getString(_tokenKey);

    if (userData == null || token == null) return null;

    return UserModel.fromJson(jsonDecode(userData));
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_tokenKey);
  }

  // Check if logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) != null;
  }
}