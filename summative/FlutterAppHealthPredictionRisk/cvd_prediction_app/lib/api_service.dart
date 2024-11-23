// lib/api_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

class MyApiService {
  final String apiUrl =
      'https://4249-102-0-13-76.ngrok-free.app/predict'; // Replace with your actual API URL

  Future<String> predictHealthRisk(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData[
          'health_risk']; // Adjust based on your API response structure
    } else {
      throw Exception('Failed to load prediction');
    }
  }
}
