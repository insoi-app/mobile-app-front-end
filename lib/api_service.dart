import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

class ApiService {
  final String _baseUrl = 'http://127.0.0.1:8000/api'; // API base URL 
  String? _token; // Token for authenticated requests

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
        'username': fullName,
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

  // Method to log in a user and store the token
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final url = Uri.parse('$_baseUrl/login/'); // Login endpoint

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

    // Check for success response
    if (response.statusCode == 200) {
      // Login success, store token for future requests
      final data = jsonDecode(response.body);
      _token = data['token']; // Assuming token is returned as 'token'
      return data;
    } else {
      // Login failed
      throw Exception('Failed to log in user: ${response.body}');
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

  // Fetch all reservations
  Future<List<Reservation>> fetchReservations() async {
    final response = await http.get(Uri.parse('$_baseUrl/reservations/'), headers: getAuthHeaders());

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Reservation.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reservations: ${response.body}');
    }
  }

  // Fetch reservations by user email
  Future<List<Reservation>> fetchReservationsByEmail(String email) async {
    final response = await http.get(Uri.parse('$_baseUrl/reservations/by_user_email/?email=$email'), headers: getAuthHeaders());

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Reservation.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reservations: ${response.body}');
    }
  }

  // Create a new reservation
  Future<Reservation> createReservation(Reservation reservation) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/reservations/'),
      headers: getAuthHeaders(),
      body: json.encode(reservation.toJson()),
    );

    if (response.statusCode == 201) {
      return Reservation.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create reservation: ${response.body}');
    }
  }

  // Update a reservation's status
  Future<Reservation> updateReservationStatus(int reservationId, String status) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/reservations/$reservationId/update_status/'),
      headers: getAuthHeaders(),
      body: json.encode({'status': status}),
    );

    if (response.statusCode == 200) {
      return Reservation.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update reservation status: ${response.body}');
    }
  }
}
