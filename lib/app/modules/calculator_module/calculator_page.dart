import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx_calculator/app/modules/calculator_module/calculator_controller.dart';
import 'package:mobx_calculator/app/modules/calculator_module/widgets/buttons_grid.dart';
import 'package:mobx_calculator/app/modules/calculator_module/widgets/choose_currency_widget.dart';
import 'package:mobx_calculator/app/modules/calculator_module/widgets/input_field_widget.dart';
import 'package:mobx_calculator/app/theme/app_colors.dart';
import 'package:mobx_calculator/app/theme/app_text_theme.dart';
import 'package:mobx_calculator/app/utils/size_config.dart';

class CalculatorPage extends GetView<CalculatorController> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Currency Calculator",
          style: textStyleWithRoboto(
              colors: kWhiteColor, fontWeight: FontWeight.w600, fontSize: 18.0),
        ),
        actions: const [ChooseCurrencyWidget()],
      ),
      body: SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Column(
          children: [
            // notice an multi currency widget area
            const InputFieldWidget(),

            //output / result area
            resultWidget(),

            const Spacer(
              flex: 1,
            ),

            //Calculator Buttons
            const ButtonsGrid()
          ],
        ),
      ),
    );
  }

  Widget resultWidget() {
    return Obx(() {
      return controller.currencyFieldList.length == 2 &&
              controller.calculatedOutput.value != 0.0
          ? SizedBox(
              height: 80,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(() {
                    return Text(
                      "Result: ${controller.calculatedOutput.value.toPrecision(4)} ${controller.baseCurrency}",
                      style: textStyleWithRoboto(
                          colors: kWhiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 22.0),
                    );
                  })
                ],
              ),
            )
          : const SizedBox(height: 80);
    });
  }
}
