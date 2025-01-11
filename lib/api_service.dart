import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class ApiService {
  final String _baseUrl = 'http://127.0.0.1:8000/api'; // API base URL
  String? _token; // Token for authenticated requests

  // Logger setup
  final Logger _logger = Logger('ApiService');

  // Method to register a user
  Future<Map<String, dynamic>> registerUser(String fullName, String email,
      String password, String confirmPassword) async {
    final url = Uri.parse('$_baseUrl/register/');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'username': fullName,
          'email': email,
          'password1': password,
          'password2': confirmPassword,
        }),
      );

      if (response.statusCode == 201) {
        _logger.info('Registration successful');
        return jsonDecode(response.body);
      } else {
        _logger.warning('Failed to register user: ${response.body}');
        throw Exception('Failed to register user: ${response.body}');
      }
    } catch (e) {
      _logger.severe('Error in registration: $e');
      throw Exception('Error in registration: $e');
    }
  }

  // Method to log in a user and store the token
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final url = Uri.parse('$_baseUrl/login/'); // Login endpoint

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data['token']; // Assuming token is returned as 'token'
        _logger.info('Login successful');
        return data;
      } else {
        _logger.warning('Login failed: ${response.body}');
        throw Exception('Failed to log in user: ${response.body}');
      }
    } catch (e) {
      _logger.severe('Error in login: $e');
      throw Exception('Error in login: $e');
    }
  }

  // Method to get the authorization header
  Map<String, String> getAuthHeaders() {
    if (_token == null) {
      throw Exception('User is not authenticated');
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };
  }
}

