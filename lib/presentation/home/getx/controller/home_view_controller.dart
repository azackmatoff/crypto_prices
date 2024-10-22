import 'dart:developer';

import 'package:crypto_prices/domain/home/repository/home_repository.dart';
import 'package:crypto_prices/presentation/home/getx/controller/home_view_controller_state.dart';
import 'package:get/get.dart';

final class HomeViewController extends GetxController {
  late final HomeRepository _repository;
  static final find = Get.find<HomeViewController>();

  Rx<HomeViewControllerState> state = const HomeViewControllerState().obs;

  // Rx<CryptoModels> cryptoModels = CryptoModels(
  //   time: '',
  //   assetIdBase: '',
  //   assetIdQuote: '',
  //   bitcoinPrice: 0,
  // ).obs;

  // RxBool isLoading = true.obs;
  // RxString? errorText;
  // RxString selectedCurrency = 'USD'.obs; // Default selected value
  // RxList<String> currencies = AppConstants.currencies.obs;

  HomeViewController({required HomeRepository repository}) {
    _repository = repository;
  }

  @override
  void onInit() async {
    super.onInit();
    await getCryptoPrices(state.value.selectedCurrency);
  }

  Future<void> getCryptoPrices(String currency) async {
    log('HomeViewController.getCryptoPrices, currency: $currency');
    try {
      final result = await _repository.getCryptoPrices(currency);

      /// cryptoModels.value = result;
      state.value = state.value.copyWith(
        cryptoModels: result,
        isLoading: false,
      );
    } catch (e) {
      // errorText.value = 'Error fetching crypto prices: $e.';
      state.value = state.value.copyWith(
        error: 'Error fetching crypto prices: $e.',
        isLoading: false,
      );

      throw Exception('Error fetching crypto prices: $e.');
    }
  }

  void onLoading(bool val) {
    // isLoading.value = val;
    state.value = state.value.copyWith(isLoading: val);
  }

  void onCurrencyChange(String currency) {
    // selectedCurrency.value = currency;
    state.value = state.value.copyWith(selectedCurrency: currency);
    getCryptoPrices(currency);
  }
}
