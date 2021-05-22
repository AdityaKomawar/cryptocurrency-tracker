import 'package:http/http.dart' as http;
import 'dart:convert';

String apiKey = '5ECA2FD2-D603-4703-95B7-94460660797C';
String url = 'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=$apiKey';

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
  CoinData();
  Future<double> getCoinData(String cryptoCurr, String currency) async {
    url = 'https://rest.coinapi.io/v1/exchangerate/$cryptoCurr/$currency?apikey=$apiKey';
    var response = await http.get(url);
    // print(response.statusCode);
    // print(response.body);
    if (response.statusCode == 200)
      return jsonDecode(response.body)['rate'];
    else
      return 0;
  }
}
