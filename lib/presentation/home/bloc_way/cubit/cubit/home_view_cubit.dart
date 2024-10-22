import 'package:crypto_prices/domain/home/repository/home_repository.dart';
import 'package:crypto_prices/presentation/home/bloc_way/cubit/cubit/home_view_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class HomeViewCubit extends Cubit<HomeViewCubitState> {
  late final HomeRepository _repository;
  HomeViewCubit({required HomeRepository repository})
      : _repository = repository,
        super(const HomeViewCubitState());

  Future<void> getCryptoPrices(String currency) async {
    try {
      final result = await _repository.getCryptoPrices(currency);

      emit(state.copyWith(
        cryptoModels: result,
        isLoading: false,
      ));
    } catch (e) {
      final error = 'Error fetching crypto prices: $e.';
      emit(state.copyWith(
        error: error,
        isLoading: false,
      ));
    }
  }

  void onLoading(bool val) {
    emit(state.copyWith(isLoading: val));
  }

  void onCurrencyChange(String currency) {
    emit(state.copyWith(selectedCurrency: currency));
    getCryptoPrices(currency);
  }
}
