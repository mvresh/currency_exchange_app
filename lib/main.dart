import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'network_helper.dart';
import 'exchange_rate.dart';

void main() {
  runApp(MaterialApp(
    home: CurrencyExchange(),
  ));
}

Map<String, dynamic> exchangeRateData;

class CurrencyExchange extends StatefulWidget {
  @override
  _CurrencyExchangeState createState() => _CurrencyExchangeState();
}

class _CurrencyExchangeState extends State<CurrencyExchange> {
  String dropdownValue1 = 'USD';
  String dropdownValue2 = 'INR';
  double converter = 72;

  @override
  Widget build(BuildContext context) {
    void getExchangeRateData(value) async {
      NetworkHelper baseRateHelper =
          NetworkHelper('https://api.exchangeratesapi.io/latest?base=$value');
      exchangeRateData = await baseRateHelper.getRates();
      converter = exchangeRateData['rates'][dropdownValue2];
      setState(() {});
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Center(
                      child: Text(
                '1 $dropdownValue1 equals to ' +
                    converter.toStringAsFixed(2) +
                    ' $dropdownValue2 ',
                style: TextStyle(fontSize: 60),
              ))),
              Expanded(
                child: Platform.isAndroid
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Center(
                            child: DropdownButton<String>(
                              value: dropdownValue1,
                              elevation: 16,
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 50,
                              ),
                              onChanged: (String newValue) {
                                dropdownValue1 = newValue;
                                getExchangeRateData(dropdownValue1);
                              },
                              items: <String>[
                                'USD',
                                'GBP',
                                'INR',
                                'CAD'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          Center(
                            child: DropdownButton<String>(
                              value: dropdownValue2,
                              elevation: 16,
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 50,
                              ),
                              onChanged: (String newValue) {
                                dropdownValue2 = newValue;
                                getExchangeRateData(dropdownValue1);
                              },
                              items: <String>[
                                'USD',
                                'GBP',
                                'INR',
                                'CAD'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CupertinoPicker.builder(
                            itemExtent: 40,
                            childCount: ['USD', 'GBP', 'INR', 'CAD'].length,
                            itemBuilder: (context, index) {
                              return Text(['USD', 'GBP', 'INR', 'CAD'][index]);
                            },
                            onSelectedItemChanged: (index) {
                              dropdownValue1 =
                              ['USD', 'GBP', 'INR', 'CAD'][index];
                              getExchangeRateData(dropdownValue1);
                            },
                          ),
                          CupertinoPicker.builder(
                            itemExtent: 40,
                            childCount: ['USD', 'GBP', 'INR', 'CAD'].length,
                            itemBuilder: (context, index) {
                              return Text(['USD', 'GBP', 'INR', 'CAD'][index]);
                            },
                            onSelectedItemChanged: (index) {
                              dropdownValue2 =
                                  ['USD', 'GBP', 'INR', 'CAD'][index];
                              getExchangeRateData(dropdownValue1);
                            },
                          )
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
