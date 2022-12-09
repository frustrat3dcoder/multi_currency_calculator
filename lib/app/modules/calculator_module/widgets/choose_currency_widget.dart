import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx_calculator/app/modules/calculator_module/calculator_controller.dart';

import '../../../routes/app_pages.dart';
import '../../../theme/app_text_theme.dart';

class ChooseCurrencyWidget extends GetView<CalculatorController> {
  const ChooseCurrencyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSelectedCurrencyWidget();
  }

  Widget buildSelectedCurrencyWidget() => Obx(() {
        return TextButton(
          child: Text(
            controller.baseCurrency.value == ''
                ? 'Pick the currency'
                : controller.baseCurrency.value,
            style: textStyleWithRoboto(
                colors: Colors.teal,
                fontWeight: FontWeight.w600,
                fontSize: 14.0),
          ),
          onPressed: () {
            controller.isCurrencySet.value = false;
            Get.toNamed(Routes.currencySymbol);
          },
        );
      });
}
