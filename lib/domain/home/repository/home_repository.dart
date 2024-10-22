import 'package:crypto_prices/data/home/models/crypto_models.dart';

abstract interface class HomeRepository {
  Future<CryptoModels> getCryptoPrices(String currency);
}
