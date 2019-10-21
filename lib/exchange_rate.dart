import 'dart:convert';

class ExchangeRate {
  Rates rates;
  String base;
  String date;

  ExchangeRate({this.rates, this.base, this.date});

//  ExchangeRate.fromJson(Map<String, dynamic> json) {
//    rates = json['rates'] != null ? new Rates.fromJson(json['rates']) : null;
//    base = json['base'];
//    date = json['date'];
//  }

}

class Rates{
  double USD;
  double GBP;
  double INR;
  double CAD;

  Rates({this.USD,this.GBP,this.INR,this.CAD});

//  Rates.fromJson(Map<String, dynamic> json) {
//    USD = json['USD'];
//    AUD = json['AUD'];
//    INR = json['INR'];
//    CAD = json['CAD'];}
}