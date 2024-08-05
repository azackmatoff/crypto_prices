import 'dart:developer';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CryptoPricesScreen extends StatefulWidget {
  const CryptoPricesScreen({super.key});

  @override
  _CryptoPricesScreenState createState() => _CryptoPricesScreenState();
}

class _CryptoPricesScreenState extends State<CryptoPricesScreen> {
  String dropdownValue = 'KGS'; // Default selected value

  List<String> items = <String>['KGS', 'YEN', 'USD', 'EUR'];

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
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: Text(
                  '1 BTC = 100 $dropdownValue',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).primaryColor,
        height: 100,
        padding: const EdgeInsets.only(bottom: 18),
        child: Center(
          child: Platform.isIOS ? cupertinoPicker() : dropdownButton(context),
        ),
      ),
    );
  }

  Widget cupertinoPicker() {
    return SizedBox(
      height: 100,
      child: CupertinoPicker(
        backgroundColor: Theme.of(context).primaryColor,
        itemExtent: 42.0,
        onSelectedItemChanged: (int index) {
          setState(() {
            dropdownValue = items[index];
          });
          log('onSelectedItemChanged ${items[index]}');
        },
        children: items.map((String value) {
          return Center(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget dropdownButton(BuildContext context) {
    return Container(
      height: 60,
      color: Theme.of(context).primaryColor,
      child: DropdownButton<String>(
        value: dropdownValue,
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
        onChanged: (String? value) {
          log('onChanged $value');
          setState(() {
            dropdownValue = value!;
          });
        },
        dropdownColor: Theme.of(context).primaryColor,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
