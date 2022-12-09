import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mobx_calculator/app/modules/calculator_module/calculator_controller.dart';
import 'package:mobx_calculator/app/services/currency_rate_service.dart';

import '../../data/models/currency_symbols.dart';
import '../../infra/secure_storage_adapter.dart';
import '../../utils/connection_helper.dart';
import '../../utils/snackbar.dart';

class CurrencySymbolController extends GetxController with StateMixin {
  CurrencySymbolController({required this.currencySymbolServices});

  final CurrencySymbolServices currencySymbolServices;

  Rx<CurrencySymbols> currencySymbol = CurrencySymbols().obs;

  RxInt groupValue = 999.obs;
  RxString currentCurrencyPicked = "".obs;
  final CalculatorController calculatorController =
      Get.find<CalculatorController>();
  final GetXNetworkManager connectionManager = Get.find();
  SecureStorageAdapter secureStorageAdapter =
      SecureStorageAdapter(secureStorage: const FlutterSecureStorage());
  @override
  void onInit() {
    super.onInit();
    connectionManager.addListener(() async {
      if (connectionManager.connectionType == 0) {
        showSnackBar("No Internet", '');
      }
    });
    getCurrencySymbolsData();
  }

  getCurrencySymbolsData() async {
    var offlineData = await secureStorageAdapter.fetch("currencySymbol");
    change(null, status: RxStatus.loading());
    if (connectionManager.connectionType == 0 && offlineData != null) {
      var tempData = json.decode(offlineData);
      log("offline data found");
      currencySymbol.value = CurrencySymbols.fromJson(tempData);
      change(currencySymbol, status: RxStatus.success());
    } else if (connectionManager.connectionType == 0 && offlineData == null) {
      change(null,
          status: RxStatus.error("No internet connectivity to sync data"));
    } else {
      try {
        await currencySymbolServices.fetchCurrencySymbols().then((value) {
          if (value.statusCode == 200 || value.statusCode == 201) {
            currencySymbol.value = CurrencySymbols.fromJson(value.data);
            if (value.data != null) {
              secureStorageAdapter.save(
                  key: "currencySymbol", value: jsonEncode(value.data));
            }
          } else {
            log(value.statusMessage.toString());
          }
        });
      } catch (err) {
        log(err.toString());
      } finally {
        change("data", status: RxStatus.success());
      }
    }
  }

  back() {
    calculatorController.baseCurrency.value = currentCurrencyPicked.value;
    calculatorController.isCurrencySet.value = true;
    Get.back();
  }
}
