import 'dart:developer';

import 'package:mobx_calculator/app/extensions/map_extensions.dart';

class CurrencySymbols {
  bool? success;
  Map<String, String>? symbols = {};

  CurrencySymbols({
    this.success,
    this.symbols,
  });
  CurrencySymbols.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json["symbols"] != null) {
      json["symbols"].forEach((key, value) {
        Map<String, String> someData = {"$key": "$value"};
        symbols!.addAll(someData);
      });
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;

    data['symbols'] = symbols;
    return data;
  }
}
