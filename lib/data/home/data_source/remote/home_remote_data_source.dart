import 'dart:developer';

import 'package:crypto_prices/core/services/api/api_services.dart';
import 'package:crypto_prices/data/home/models/crypto_models.dart';

class HomeRemoteDataSource {
  Future<CryptoModels> getCryptoPrices(String currency) async {
    log('HomeRemoteDataSource.getCryptoPrices, currency: $currency');
    try {
      final response = await ApiServices.get('exchangerate/BTC/$currency');

      log('response $response');

      return CryptoModels.fromJson(response);
    } catch (e) {
      // Include both the original exception and potential decoding issues
      throw Exception('Error fetching crypto prices: $e.');
    }
  }
}
