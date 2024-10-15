import 'package:crypto_prices/data/home/data_source/remote/home_remote_data_source.dart';
import 'package:crypto_prices/data/home/models/crypto_models.dart';
import 'package:crypto_prices/domain/home/repository/home_repository.dart';

final class HomeRepositoryImpl implements HomeRepository {
  final _dataSource = HomeRemoteDataSource();

  @override
  Future<CryptoModels> getCryptoPrices(String currency) {
    return _dataSource.getCryptoPrices(currency);
  }
}
