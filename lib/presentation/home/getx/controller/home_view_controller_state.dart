import 'package:crypto_prices/common/contants/texts/app_constants.dart';
import 'package:crypto_prices/data/home/models/crypto_models.dart';

class HomeViewControllerState {
  final bool isLoading;
  final String selectedCurrency;
  final List<String> currencies;
  final CryptoModels? cryptoModels;
  final String? error;

  const HomeViewControllerState({
    this.isLoading = true,
    this.selectedCurrency = 'USD',
    this.currencies = AppConstants.currencies,
    this.cryptoModels,
    this.error,
  });

  HomeViewControllerState copyWith({
    bool? isLoading,
    CryptoModels? cryptoModels,
    String? selectedCurrency,
    String? error,
  }) {
    return HomeViewControllerState(
      isLoading: isLoading ?? this.isLoading,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      cryptoModels: cryptoModels ?? this.cryptoModels,
      error: error ?? this.error,
    );
  }
}
