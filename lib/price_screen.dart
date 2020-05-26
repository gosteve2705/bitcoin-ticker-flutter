import 'package:flutter/material.dart';
import 'services/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'cryptocard.dart';

CoinData coinData = CoinData();

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  int btc = 0;
  int eth = 0;
  int ltc = 0;
// dropdownbutton widget for android
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      //gets selected currency from the dropdown item in android and passes its value to the 3 methods in coinData class which gets btc ,eth and ltc data
      onChanged: (value) async {
        selectedCurrency = value;
        var btcData = await coinData.getBtcData(selectedCurrency);
        var ethData = await coinData.getEthData(selectedCurrency);
        var ltcData = await coinData.getLtcData(selectedCurrency);
        setState(() {
          //once the data is gotten back from the methods above they are passed to the update ui method
          updateUi(btcData: btcData, ethData: ethData, ltcData: ltcData);
        });
      },
      items: dropDownItems,
    );
  }

//cupertino picker for ios
  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 30,
      onSelectedItemChanged: (selectedIndex) async {
        //gets selected currency from the cupertino picker in ios and passes its value to the 3 methods in coinData class which gets btc ,eth and ltc data
        selectedCurrency = currenciesList[selectedIndex];

        var btcData = await coinData.getBtcData(selectedCurrency);
        var ethData = await coinData.getEthData(selectedCurrency);
        var ltcData = await coinData.getLtcData(selectedCurrency);
        setState(() {
          //once the data is gotten back from the methods above they are passed to the update ui method
          updateUi(btcData: btcData, ethData: ethData, ltcData: ltcData);
        });
      },
      children: pickerItems,
    );
  }

  void updateUi({dynamic btcData, dynamic ethData, dynamic ltcData}) {
    setState(() {
      //check to make sure the data passed in is not null if its null exit with a retuen statement
      if (btcData == null || ethData == null || ltcData == null) {
        return;
      }
      //else if there is data decode the data  and extract the btc,ltc and eth rate from the json response
      var btcRate = btcData['rate'];
      var ethRate = ethData['rate'];
      var ltcRate = ltcData['rate'];
      btc = btcRate.toInt();
      eth = ethRate.toInt();
      ltc = ltcRate.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CryptoCard(
                cryptoValue: btc,
                selectedCurrency: selectedCurrency,
                crypto: 'BTC',
              ),
              CryptoCard(
                cryptoValue: eth,
                selectedCurrency: selectedCurrency,
                crypto: 'ETH',
              ),
              CryptoCard(
                cryptoValue: ltc,
                selectedCurrency: selectedCurrency,
                crypto: 'LTC',
              )
            ],
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iosPicker() : androidDropdown()),
        ],
      ),
    );
  }
}
