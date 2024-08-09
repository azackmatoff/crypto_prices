import 'dart:convert';

import 'package:http/http.dart' as http;

const String baseUrl = 'https://rest.coinapi.io';
const String apiKey = '9dd18800-7770-4f70-9472-1c153449932b';

// https://rest.coinapi.io/v1/exchangerate/BTC/YEN/?apikey=9dd18800-7770-4f70-9472-1c153449932b

class CryptoServices {
  http.Client client = http.Client();

  Future<double> getCryptoPrices(String currency) async {
    try {
      Uri uri = Uri.parse('$baseUrl/v1/exchangerate/BTC/$currency?apikey=$apiKey');

      http.Response response = await client.get(uri);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        return data['rate'];
      } else {
        // More specific exception with status code
        throw Exception('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Include both the original exception and potential decoding issues
      throw Exception('Error fetching crypto prices: $e.');
    }
  }
}
