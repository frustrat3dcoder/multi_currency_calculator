import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:mobx_calculator/app/data/provider/api_provider.dart';

import '../utils/api.dart';

typedef CurrentSymbol = String;

abstract class CurrencySymbolService {
  Future<Response> fetchCurrencySymbols();

  Future<Response> fetchCurrencyRateWithBaseSymbol(String symbol);
}

class CurrencySymbolServices implements CurrencySymbolService {
  @override
  Future<Response> fetchCurrencyRateWithBaseSymbol(String symbol) async {
    return await ApiProvider()
        .executeGetRequest("${Api.fetchCurrencyRateUrl}$symbol");
  }

  @override
  Future<Response> fetchCurrencySymbols() async {
    return await ApiProvider().executeGetRequest(Api.fetchCurrencySymbolUrl);
  }
}
