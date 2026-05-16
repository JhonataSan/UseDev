import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class LoginService {
  
  final _storage = const FlutterSecureStorage(
    
  );
  
  final String _apiUrl = 'https://fakestoreapi.com/auth/login';

  Future<bool> login(String username, String password) async {
  try {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      
      await _storage.write(key: 'jwt_token', value: token);
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
  }

  Future<bool> isLogged() async {
    try {
      final token = await getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false; 
    }
  }
}