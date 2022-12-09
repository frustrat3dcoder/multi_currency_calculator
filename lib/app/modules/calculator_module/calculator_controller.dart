import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:mobx_calculator/app/infra/cache.dart';
import 'package:mobx_calculator/app/modules/calculator_module/widgets/modal_bottom_sheet.dart';
import 'package:mobx_calculator/app/services/currency_rate_service.dart';
import 'package:mobx_calculator/app/utils/connection_helper.dart';
import 'package:mobx_calculator/app/utils/snackbar.dart';

import '../../data/models/currency_field.dart';

class CalculatorController extends GetxController with StateMixin {
  CalculatorController({required this.currencySymbolServices});

  final CurrencySymbolServices currencySymbolServices;
  final GetXNetworkManager connectionManager = Get.find();
  List<String> symbolList = [];
  RxString baseCurrency = ''.obs;
  List<double> currencyRates = <double>[];

  RxBool isCurrencySet = false.obs;
  RxList<CurrencyField> currencyFieldList = <CurrencyField>[].obs;
  RxInt groupValue = 999.obs;
  RxInt focusedIndex = 0.obs;
  RxDouble calculatedOutput = 0.0.obs;
  SecureStorageAdapter secureStorageAdapter =
      SecureStorageAdapter(secureStorage: const FlutterSecureStorage());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    connectionManager.addListener(() async {
      if (connectionManager.connectionType == 0) {
        showSnackBar("No Internet", '');
      }
    });
    baseCurrency.listen((p0) {
      if (p0 != '') {
        getCurrencyRates();
      }
    });
  }

  getCurrencyRates() async {
    change(null, status: RxStatus.loading());
    var offlineData = await secureStorageAdapter.fetch("savedData");
    if (connectionManager.connectionType == 0) {
      if (offlineData != null) {
        var tempData = json.decode(offlineData);
        log("offline data found");
        baseCurrency.value = tempData["base"];
        tempData["rates"].forEach((k, v) {
          currencyRates.add(v.toDouble());
        });
      }
      change("data", status: RxStatus.success());
    } else {
      try {
        await currencySymbolServices
            .fetchCurrencyRateWithBaseSymbol(baseCurrency.value)
            .then((value) {
          if (value.statusCode == 200 || value.statusCode == 201) {
            value.data["rates"].forEach((k, v) {
              currencyRates.add(v.toDouble());
            });

            if (value.data != null) {
              secureStorageAdapter.save(
                  key: "savedData", value: jsonEncode(value.data));
            }

            // log("currency rate data is ${currencyRates.toJson()}");
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

  resetCalculator() {
    currencyFieldList.clear();
    baseCurrency.value = '';
  }

  clearCalculatorState() {
    for (var element in currencyFieldList) {
      element.value = 0.0;
    }
  }

  calculateValue(String operator) {
    if (currencyFieldList.length == 2) {
      var temp1 = (currencyFieldList[0].value! *
          double.parse(currencyFieldList[0].textEditingController.text));
      var temp2 = (currencyFieldList[1].value! *
          double.parse(currencyFieldList[1].textEditingController.text));

      if (operator == "add") {
        calculatedOutput.value = temp1 + temp2;
      } else if (operator == "sub") {
        calculatedOutput.value = temp1 - temp2;
      } else if (operator == "multiply") {
        calculatedOutput.value = temp1 * temp2;
      } else if (operator == "div") {
        calculatedOutput.value = temp1 / temp2;
      }
    } else {
      showSnackBar(
          "Not allowed", "You need atleast two fields to perform operations");
    }
    log("output is $calculatedOutput.value");
    // return currencyFieldList[0].value.toString();
  }

  addCurrencyFieldToList(String symbol, int index) {
    double rate = currencyRates[index];

    currencyFieldList.add(CurrencyField(
        value: rate,
        currencySymbol: symbol,
        textEditingController: TextEditingController()));
    currencyFieldList.refresh();
    focusedIndex.value++;
  }

  void openModalSheet(BuildContext context) async {
    var data = await secureStorageAdapter.fetch("savedData");
    if (connectionManager.connectionType == 0 && data != null) {
      if (currencyFieldList.length < 2) {
        showModalBottomSheet(
            context: context,
            isScrollControlled: false,
            enableDrag: false,
            isDismissible: false,
            builder: (_) => ModalBottomSheet());
      } else {
        showSnackBar('Alert', "Please choose operations for the field");
      }
    } else if (connectionManager.connectionType == 0 && data == null) {
      showSnackBar('Ooops!', "You're offline can\'t fetch currect price");
    } else {
      if (currencyFieldList.length < 2) {
        showModalBottomSheet(
            context: context,
            isScrollControlled: false,
            enableDrag: false,
            isDismissible: false,
            builder: (_) => ModalBottomSheet());
      } else {
        showSnackBar('Alert', "Please choose operations for the field");
      }
    }
  }

  addValueToTextField(String value) {
    currencyFieldList[focusedIndex.value].textEditingController.text += value;
    currencyFieldList.refresh();
  }
}
