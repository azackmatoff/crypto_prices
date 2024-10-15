import 'package:crypto_prices/common/contants/texts/app_constants.dart';
import 'package:crypto_prices/data/home/models/crypto_models.dart';
import 'package:crypto_prices/domain/home/repository/home_repository.dart';

class HomeViewBizLogic {
  late final HomeRepository _repository;

  CryptoModels? cryptoModels;
  bool isLoading = true;
  String? errorText;
  String selectedCurrency = 'USD'; // Default selected value
  List<String> currencies = AppConstants.currencies;

  HomeViewBizLogic({
    required HomeRepository repository,
  }) : _repository = repository;

  Future<void> getCryptoPrices(String currency, Function setState) async {
    try {
      cryptoModels = await _repository.getCryptoPrices(currency);
    } catch (e) {
      errorText = 'Error fetching crypto prices: $e.';
      throw Exception('Error fetching crypto prices: $e.');
    }
    isLoading = false;
    setState();
  }

  void onLoading(bool val) {
    isLoading = val;
  }

  void onCurrencyChange(String currency, Function setState) {
    selectedCurrency = currency;
    getCryptoPrices(currency, setState);
  }
}
