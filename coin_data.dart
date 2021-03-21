import 'package:http/http.dart' as http;
import 'dart:convert';

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
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'INR',
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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '0F4951D7-2BA3-48D4-A0D9-7B9F2BECB851';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    String requestURL =
        '$coinAPIURL/${cryptoList[0]}/$selectedCurrency?apikey=$apiKey';
    http.Response response = await http.get(requestURL);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['rate'];
      return lastPrice;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }

  Future getCoinDataETH(String selectedCurrency) async {
    String requestURL =
        '$coinAPIURL/${cryptoList[1]}/$selectedCurrency?apikey=$apiKey';
    http.Response response = await http.get(requestURL);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['rate'];
      return lastPrice;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }

  Future getCoinDataLTC(String selectedCurrency) async {
    String requestURL =
        '$coinAPIURL/${cryptoList[2]}/$selectedCurrency?apikey=$apiKey';
    http.Response response = await http.get(requestURL);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['rate'];
      return lastPrice;
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
  }
}
