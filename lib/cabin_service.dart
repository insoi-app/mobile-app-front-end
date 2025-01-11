import 'dart:convert';
import 'package:http/http.dart' as http;
import 'cabin_model.dart';

class CabinService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/api/cabins/';

  // Fetch list of cabins
  Future<List<Cabin>> fetchCabins() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      List<dynamic> data = jsonDecode(response.body);
      return data.map((cabin) => Cabin.fromJson(cabin)).toList();
    } else {
      // If the server does not return a 200 OK response, throw an exception.
      throw Exception('Failed to load cabins');
    }
  }
}
