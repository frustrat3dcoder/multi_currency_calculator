import 'package:flutter/material.dart';

class CurrencyField {
  String? currencySymbol;
  double? value;
  TextEditingController textEditingController = TextEditingController();

  CurrencyField(
      {this.currencySymbol, this.value, required this.textEditingController});
}
