import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io'
    show
        Platform; // will only show Platform and hide if want to hide Platform and show all others.

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    // for (int i = 0; i < currenciesList.length; i++) {
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          print(selectedCurrency);
          getData();
          getDataETH();
          getDataLTC();
        });
      },
      items: dropdownItems, // calling the function.
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];
    // for (int i = 0; i < currenciesList.length; i++) {
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (seletedIndex) {
        print(seletedIndex);
        selectedCurrency = currenciesList[seletedIndex];
        getData();
        getDataETH();
        getDataLTC();
      },
      children: pickerItems,
    );
  }
  //
  // Widget getPicker() {
  //   if (Platform.isIOS) {
  //     return iosPicker();
  //   } else {
  //     return androidDropdown();
  //   }
  // }

  String bitcoinValueInUSD = '?';
  void getData() async {
    try {
      double data = await CoinData().getCoinData(selectedCurrency);
      setState(() {
        bitcoinValueInUSD = data.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  String ethValueInUSD = '?';
  void getDataETH() async {
    try {
      double data = await CoinData().getCoinDataETH(selectedCurrency);
      setState(() {
        ethValueInUSD = data.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  String ltcValueInUSD = '?';
  void getDataLTC() async {
    try {
      double data = await CoinData().getCoinDataLTC(selectedCurrency);
      setState(() {
        ltcValueInUSD = data.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    getDataETH();
    getDataLTC();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('🤑 Bitcoin-Ticker'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitcoinValueInUSD $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $ethValueInUSD $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $ltcValueInUSD $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: (Platform.isIOS) ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
