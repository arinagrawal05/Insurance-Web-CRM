import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, String>> fetchQuote() async {
  final response = await http.get(Uri.parse('https://api.quotable.io/random'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return {
      'quote': data['content'],
      'author': data['author'],
    };
  } else {
    throw Exception('Failed to load quote');
  }
}
