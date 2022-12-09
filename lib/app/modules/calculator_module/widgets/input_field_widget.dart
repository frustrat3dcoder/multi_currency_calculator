import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx_calculator/app/modules/calculator_module/calculator_controller.dart';
import 'package:mobx_calculator/app/utils/strings.dart';

import '../../../data/models/currency_field.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_theme.dart';
import '../../../utils/size_config.dart';

class InputFieldWidget extends GetView<CalculatorController> {
  const InputFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return inputFieldWidgetArea();
  }

  Widget inputFieldWidgetArea() => Obx(() {
        return controller.currencyFieldList.isNotEmpty
            ? controller.currencyFieldList.length == 1
                ? SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        buildCurrencyListView(),
                        const Expanded(
                            child: SizedBox(
                          height: 10,
                        ))
                      ],
                    ),
                  )
                : buildCurrencyListView()
            : Container(
                height: 200,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Center(
                  child: Obx(() {
                    return Text(
                      controller.baseCurrency.value == ""
                          ? AppStrings.displayMessage1
                          : AppStrings.displayMessage2,
                      textAlign: TextAlign.center,
                      style: textStyleWithRoboto(
                          colors: kWhiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0),
                    );
                  }),
                ),
              );
      });

  ListView buildCurrencyListView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.currencyFieldList.length,
        itemBuilder: (context, index) {
          CurrencyField currency = controller.currencyFieldList[index];
          return currencyField(currency, context, index);
        });
  }

  Widget currencyField(
      CurrencyField currency, BuildContext context, int index) {
    return GestureDetector(
      child: Container(
        width: SizeConfig.screenWidth,
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(border: Border.all(color: kTeal, width: 2)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: TextFormField(
              controller: currency.textEditingController,
              readOnly: true,
              onTap: () => controller.focusedIndex.value = index,
              decoration: InputDecoration(
                hintText: '0.0',
                hintStyle: textStyleWithRoboto(
                  colors: kWhiteColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
              onChanged: (value) {},
              textAlign: TextAlign.end,
            )),
            const SizedBox(width: 20),
            Row(
              children: [
                TextButton.icon(
                    onPressed: () {
                      controller.openModalSheet(context);
                    },
                    icon: Text(
                      currency.currencySymbol!,
                      style: textStyleWithRoboto(
                        colors: kWhiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                    ),
                    label: const Icon(Icons.arrow_drop_down_rounded))
              ],
            )
          ],
        ),
      ),
    );
  }
}
