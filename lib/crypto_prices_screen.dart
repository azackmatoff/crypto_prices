import 'dart:convert';
import 'dart:developer';
import 'dart:io' show Platform;
import 'package:crypto_prices/crypto_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CryptoPricesScreen extends StatefulWidget {
  const CryptoPricesScreen({super.key});

  @override
  _CryptoPricesScreenState createState() => _CryptoPricesScreenState();
}

class _CryptoPricesScreenState extends State<CryptoPricesScreen> {
  String dropdownValue = 'USD'; // Default selected value

  List<String> items = <String>['USD', 'EUR', 'RUB', 'TRY', 'CNY', 'JPY', 'CHF', 'GBP'];

  bool loading = true;

  http.Client client = http.Client();

  CryptoServices cryptoServices = CryptoServices();

  double bitcoinPrice = 0;
  String? errorText;

  @override
  void initState() {
    getCryptoPrices('USD');
    super.initState();
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
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : Text(
                        errorText ?? '1 BTC = ${bitcoinPrice.toStringAsFixed(2)} $dropdownValue',
                        style: const TextStyle(fontSize: 18, color: Colors.white),
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
          // child: Platform.isIOS ? cupertinoPicker() : dropdownButton(context),
          child: dropdownButton(context),
        ),
      ),
    );
  }

  Widget cupertinoPicker() {
    return CupertinoPicker(
      backgroundColor: Theme.of(context).primaryColor,
      itemExtent: 42.0,
      onSelectedItemChanged: (int index) async {
        setState(() {
          loading = true;
          dropdownValue = items[index];
        });

        await getCryptoPrices(items[index]);
      },
      children: items.map((String value) {
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
        onChanged: (String? value) async {
          setState(() {
            loading = true;
            dropdownValue = value!;
          });
          await getCryptoPrices(value!);
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

  Future<void> getCryptoPrices(String currency) async {
    final btcPrice = await cryptoServices.getCryptoPrices(currency);

    setState(() {
      bitcoinPrice = btcPrice;
      loading = false;
    });
  }

  void changeDropdownValue() {
    setState(() {
      dropdownValue = items[1];
    });
  }
}

/// synchronous
/// asynchronous programming
/// CRUD
/// Create client.put
/// Read   client.get
/// Update  client.update
/// Delete client.delete
/// List
/// Map
///

String data =
    "{'time': '2024-08-08T16:13:58.0000000Z','asset_id_base': 'BTC','asset_id_quote': 'EUR''rate': 54801.308705924415317677050423}";

Set halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
Set halogens2 = {'fluorin', 'chlorin', 'bromine', 'iodine', 'astatine'};

List tizme = [];
Set tizme2 = {};

/// key, value
/// azamat, 5
Map baalar = {
  'azamat': 5,
  'aibek': 3,
  'akylai': 4,
};
Map baalar2 = {
  'azamat': 2,
  'aibek': 1,
  'jane': 4,
};


  // @override
  // void initState() {
  //   // for (var element in baalar.entries) {
  //   //   log('element $element');
  //   // }
  //   // log('baalar $baalar');
  //   // log('baalar.akylai ${baalar['akylai']}');

  //   // baalar['jon'] = 2;
  //   // log('baalar add $baalar');

  //   // baalar.addAll(baalar2);

  //   // log('baalar addAll $baalar');

  //   getCryptoPrices();

  //   super.initState();
  // }