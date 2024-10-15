import 'dart:io' show Platform;

import 'package:crypto_prices/core/utils/date_time_utils.dart';
import 'package:crypto_prices/data/home/repository/home_repository_impl.dart';
import 'package:crypto_prices/presentation/home/biz_logic/home_view_biz_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _bizLogic = HomeViewBizLogic(repository: HomeRepositoryImpl());

  @override
  void initState() {
    super.initState();
    _bizLogic.getCryptoPrices(_bizLogic.selectedCurrency, () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Crypto Prices',
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
                child: _bizLogic.isLoading
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
                            _bizLogic.errorText ??
                                '1 BTC = ${_bizLogic.cryptoModels?.bitcoinPrice.toStringAsFixed(2)} ${_bizLogic.selectedCurrency}',
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            _bizLogic.errorText ??
                                'Time: ${DateTimeUtils.formatDateTime(_bizLogic.cryptoModels?.time ?? '')}',
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
          child: Platform.isIOS ? cupertinoPicker() : dropdownButton(context),
        ),
      ),
    );
  }

  Widget cupertinoPicker() {
    return CupertinoPicker(
      backgroundColor: Theme.of(context).primaryColor,
      itemExtent: 42.0,
      onSelectedItemChanged: (int index) async {
        _bizLogic.onLoading(true);
        final currentCurrency = _bizLogic.currencies[index];
        _bizLogic.onCurrencyChange(currentCurrency, () {
          setState(() {});
        });
      },
      children: _bizLogic.currencies.map((String value) {
        return Center(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
    );
  }

  Widget dropdownButton(BuildContext context) {
    return Container(
      height: 60,
      color: Theme.of(context).primaryColor,
      child: DropdownButton<String>(
        value: _bizLogic.selectedCurrency,
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
          _bizLogic.onLoading(true);
          _bizLogic.onCurrencyChange(value!, () {
            setState(() {});
          });
        },
        dropdownColor: Theme.of(context).primaryColor,
        items: _bizLogic.currencies.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
