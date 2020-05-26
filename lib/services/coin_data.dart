import 'package:bitcoin_ticker/services/networking.dart';

const apikey = 'EA00CA57-3AE7-44F2-B05F-5C287822ACD8';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NGN',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String selectedCurrency;
  String selectedCrypto;
  Future<dynamic> getBtcData(String coin) async {
    selectedCurrency = coin;
    ;
    NetworkHelper networkHelper = NetworkHelper(
        url:
            'https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurrency?apikey=$apikey');

    var btcData = await networkHelper.getData();
    return btcData;
  }

  Future<dynamic> getEthData(String coin) async {
    selectedCurrency = coin;
    ;
    NetworkHelper networkHelper = NetworkHelper(
        url:
            'https://rest.coinapi.io/v1/exchangerate/ETH/$selectedCurrency?apikey=$apikey');

    var ethData = await networkHelper.getData();
    return ethData;
  }

  Future<dynamic> getLtcData(String coin) async {
    selectedCurrency = coin;
    ;
    NetworkHelper networkHelper = NetworkHelper(
        url:
            'https://rest.coinapi.io/v1/exchangerate/LTC/$selectedCurrency?apikey=$apikey');

    var ltcData = await networkHelper.getData();
    return ltcData;
  }
}
