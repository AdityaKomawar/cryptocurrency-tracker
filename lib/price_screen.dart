import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'main.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedValue = 'USD';
  String selectedCryptoCurr = 'BTC';
  var responseData;
  double rate = 0;
  String currency;
  String cryptoCurrency;

  CoinData coinData = CoinData();

  List<DropdownMenuItem> getDropDownList() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (currency in currenciesList) {
      dropDownItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return dropDownItems;
  }

  List<DropdownMenuItem> getDropDownCryptoList() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (cryptoCurrency in cryptoList) {
      dropDownItems.add(
        DropdownMenuItem(
          child: Text(cryptoCurrency),
          value: cryptoCurrency,
        ),
      );
    }
    return dropDownItems;
  }

  void getData() async {
    double tempRate =
        await coinData.getCoinData(selectedCryptoCurr, selectedValue);
    setState(() {
      rate = tempRate;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $selectedCryptoCurr = ${rate.toStringAsFixed(2)} $selectedValue',
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: selectedCryptoCurr,
                  items: getDropDownCryptoList(),
                  onChanged: (value) async {
                    CoinData coinData = CoinData();
                    double tempRate =
                        await coinData.getCoinData(value, selectedValue);
                    setState(() {
                      selectedCryptoCurr = value;
                      rate = tempRate;
                    });
                  },
                ),
                SizedBox(
                  width: 15.0,
                ),
                DropdownButton<String>(
                  value: selectedValue,
                  items: getDropDownList(),
                  onChanged: (value) async {
                    CoinData coinData = CoinData();
                    double tempRate =
                        await coinData.getCoinData(selectedCryptoCurr, value);
                    setState(() {
                      selectedValue = value;
                      rate = tempRate;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
