import 'package:crypto_prices/common/contants/texts/app_constants.dart';
import 'package:crypto_prices/data/home/models/crypto_models.dart';

class HomeViewCubitState {
  final bool isLoading;
  final String selectedCurrency;
  final List<String> currencies;
  final CryptoModels? cryptoModels;
  final String? error;

  const HomeViewCubitState({
    this.isLoading = true,
    this.selectedCurrency = 'USD',
    this.currencies = AppConstants.currencies,
    this.cryptoModels,
    this.error,
  });

  HomeViewCubitState copyWith({
    bool? isLoading,
    CryptoModels? cryptoModels,
    String? selectedCurrency,
    String? error,
  }) {
    return HomeViewCubitState(
      isLoading: isLoading ?? this.isLoading,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      cryptoModels: cryptoModels ?? this.cryptoModels,
      error: error ?? this.error,
    );
  }
}
