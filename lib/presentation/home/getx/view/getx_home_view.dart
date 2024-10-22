import 'dart:io' show Platform;

import 'package:crypto_prices/core/utils/date_time_utils.dart';
import 'package:crypto_prices/presentation/home/getx/controller/home_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetxHomeView extends StatefulWidget {
  const GetxHomeView({super.key});

  @override
  _GetxHomeViewState createState() => _GetxHomeViewState();
}

class _GetxHomeViewState extends State<GetxHomeView> {
  final HomeViewController _controller = HomeViewController.find;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'GETX: Crypto Prices',
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
                child: Obx(() {
                  if (_controller.state.value.isLoading) {
                    return _loader();
                  } else {
                    return _content();
                  }
                }),
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

  Widget _content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => Text(
            _controller.state.value.error ??
                '1 BTC = ${_controller.state.value.cryptoModels?.bitcoinPrice.toStringAsFixed(2)} ${_controller.state.value.selectedCurrency}',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        const SizedBox(height: 18),
        Obx(
          () => Text(
            _controller.state.value.error ??
                'Time: ${DateTimeUtils.formatDateTime(_controller.state.value.cryptoModels?.time ?? '')}',
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _loader() {
    return const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 3,
      ),
    );
  }

  Widget cupertinoPicker() {
    return CupertinoPicker(
      backgroundColor: Theme.of(context).primaryColor,
      itemExtent: 42.0,
      onSelectedItemChanged: (int index) async {
        _controller.onLoading(true);
        final currentCurrency = _controller.state.value.currencies[index];
        _controller.onCurrencyChange(currentCurrency);
      },
      children: _controller.state.value.currencies.map((String value) {
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
      child: Obx(
        () => DropdownButton<String>(
          value: _controller.state.value.selectedCurrency,
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
            _controller.onLoading(true);
            _controller.onCurrencyChange(value!);
          },
          dropdownColor: Theme.of(context).primaryColor,
          items: _controller.state.value.currencies.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
