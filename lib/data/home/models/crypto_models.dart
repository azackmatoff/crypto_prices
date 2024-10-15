class CryptoModels {
  final String time;
  final String assetIdBase;
  final String assetIdQuote;
  final double bitcoinPrice;

  CryptoModels({
    required this.time,
    required this.assetIdBase,
    required this.assetIdQuote,
    required this.bitcoinPrice,
  });

  factory CryptoModels.fromJson(Map<String, dynamic> json) {
    return CryptoModels(
      time: json['time'],
      assetIdBase: json['asset_id_base'],
      assetIdQuote: json['asset_id_quote'],
      bitcoinPrice: json['rate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'asset_id_base': assetIdBase,
      'asset_id_quote': assetIdQuote,
      'rate': bitcoinPrice,
    };
  }
}


  // {
  //   "time": "2024-08-05T13:35:34.3741337Z",
  //   "asset_id_base": "BTC",
  //   "asset_id_quote": "USD",
  //   "rate": 10000
  // }