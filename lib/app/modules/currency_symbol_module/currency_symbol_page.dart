import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx_calculator/app/modules/currency_symbol_module/currency_symbol_controller.dart';
import 'package:mobx_calculator/app/theme/app_text_theme.dart';

import '../../theme/app_colors.dart';

class CurrencySymbolPage extends GetView<CurrencySymbolController> {
  const CurrencySymbolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pick the Currency',
          style: textStyleWithRoboto(
            colors: kWhiteColor,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
        leading: IconButton(
            onPressed: () => controller.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 22,
              color: kWhiteColor,
            )),
      ),
      body: controller.obx((state) => buildCurrencySymbolList(context),
          onError: (err) => Center(child: Text(err.toString())),
          onLoading: const Center(
            child:
                CircularProgressIndicator(color: Colors.teal, strokeWidth: 2),
          )),
    );
  }

  Widget buildCurrencySymbolList(BuildContext context) {
    return ListView.builder(
      itemCount: controller.currencySymbol.value.symbols!.length,
      itemBuilder: (context, index) {
        String key =
            controller.currencySymbol.value.symbols!.keys.elementAt(index);
        String value =
            controller.currencySymbol.value.symbols!.values.elementAt(index);
        return currencyListTile(key, value, index);
      },
    );
  }

  Widget currencyListTile(String key, String value, int index) {
    controller.calculatorController.symbolList.add("$key - $value");
    return Obx(() {
      return RadioListTile(
        onChanged: (val) {
          controller.groupValue.value = val!;
          log("base currency is $key");
          controller.currentCurrencyPicked.value = key;
        },
        activeColor: Colors.teal,
        value: index,
        title: Text(
          value,
          style: textStyleWithRoboto(
              colors: kWhiteColor, fontWeight: FontWeight.w600, fontSize: 16.0),
        ),
        subtitle: Text(
          key,
          style: textStyleWithRoboto(
              colors: kWhiteColor, fontWeight: FontWeight.w600, fontSize: 16.0),
        ),
        groupValue: controller.groupValue.value,
      );
    });
  }
}
