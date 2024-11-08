import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'http://127.0.0.1:8000/api'; // Set your API base URL here

  // Method to register a user
  Future<Map<String, dynamic>> registerUser(
      String fullName, String email, String password, String confirmPassword) async {
    final url = Uri.parse('$_baseUrl/register/');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': fullName,    // Updated to match 'full_name' instead of 'username'
        'email': email,
        'password1': password,
        'password2': confirmPassword,
      }),
    );

    // Check for success response
    if (response.statusCode == 201) {
      // Registration success
      return jsonDecode(response.body);
    } else {
      // Registration failed
      throw Exception('Failed to register user: ${response.body}');
    }
  }
}
