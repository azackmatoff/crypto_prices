import 'dart:io' show Platform;

import 'package:crypto_prices/core/utils/date_time_utils.dart';
import 'package:crypto_prices/data/home/repository/home_repository_impl.dart';
import 'package:crypto_prices/presentation/home/bloc_way/cubit/cubit/home_view_cubit.dart';
import 'package:crypto_prices/presentation/home/bloc_way/cubit/cubit/home_view_cubit_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class CubitHomeView extends StatefulWidget {
  const CubitHomeView({super.key});

  @override
  _CubitHomeViewState createState() => _CubitHomeViewState();
}

class _CubitHomeViewState extends State<CubitHomeView> {
  final _cubit = HomeViewCubit(repository: HomeRepositoryImpl());

  @override
  void initState() {
    super.initState();
    _cubit.getCryptoPrices('USD');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewCubit, HomeViewCubitState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text(
              'CUBIT-WAY: Crypto Prices',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: state.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.error ??
                                    '1 BTC = ${state.cryptoModels?.bitcoinPrice.toStringAsFixed(2)} ${state.selectedCurrency}',
                                style: const TextStyle(fontSize: 18, color: Colors.white),
                              ),
                              const SizedBox(height: 18),
                              Text(
                                state.error ??
                                    'Time: ${DateTimeUtils.formatDateTime(state.cryptoModels?.time ?? '')}',
                                style: const TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            color: Theme.of(context).primaryColor,
            height: 180,
            padding: const EdgeInsets.only(bottom: 18),
            child: Center(
              child: Platform.isIOS ? cupertinoPicker(state) : dropdownButton(context, state),
            ),
          ),
        );
      },
    );
  }

  Widget cupertinoPicker(HomeViewCubitState state) {
    return CupertinoPicker(
      backgroundColor: Theme.of(context).primaryColor,
      itemExtent: 42.0,
      onSelectedItemChanged: (int index) async {
        _cubit.onLoading(true);
        final currentCurrency = state.currencies[index];
        _cubit.onCurrencyChange(currentCurrency);
      },
      children: state.currencies.map((String value) {
        return Center(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
    );
  }

  Widget dropdownButton(BuildContext context, HomeViewCubitState state) {
    return Container(
      height: 60,
      color: Theme.of(context).primaryColor,
      child: DropdownButton<String>(
        value: state.selectedCurrency,
        icon: const Icon(
          Icons.arrow_downward,
          color: Colors.white,
          size: 18,
        ),
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        underline: Container(
          height: 2,
          color: Colors.white,
        ),
        onChanged: (String? value) async {
          _cubit.onLoading(true);
          _cubit.onCurrencyChange(value!);
        },
        dropdownColor: Theme.of(context).primaryColor,
        items: state.currencies.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
