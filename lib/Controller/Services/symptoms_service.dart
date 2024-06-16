import 'dart:convert';
import 'package:http/http.dart' as http;

class SymptomCheckerService {
  final String apiKey = 'YOUR_API_KEY';
  final String apiUrl = 'https://api.infermedica.com/v2/diagnosis';

  Future<Map<String, dynamic>> getDiagnosis(List<Map<String, dynamic>> symptoms) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'App-Id': 'YOUR_APP_ID',
        'App-Key': apiKey,
      },
      body: jsonEncode({
        'sex': 'male', // or 'female'
        'age': {'value': 30},
        'evidence': symptoms,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get diagnosis');
    }
  }
}

