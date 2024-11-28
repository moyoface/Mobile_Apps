import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  final String _apiUrl =
      'https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json';

  Future<List<dynamic>> fetchExchangeRates() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data;
    } else {
      throw Exception('Не вдалося отримати дані з API');
    }
  }
}
