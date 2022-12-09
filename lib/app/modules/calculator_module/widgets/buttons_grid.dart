import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx_calculator/app/modules/calculator_module/calculator_controller.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_theme.dart';

class ButtonsGrid extends GetView<CalculatorController> {
  const ButtonsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildButtonsGrid(context);
  }

  Widget buildButtonsGrid(BuildContext context) => Expanded(
        flex: 10,
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 1.4,
          children: [
            operationsWidget('1', () => controller.addValueToTextField('1')),
            operationsWidget('2', () => controller.addValueToTextField('2')),
            operationsWidget('3', () => controller.addValueToTextField('3')),
            operationsWidget('C', () {
              for (var element in controller.currencyFieldList) {
                element.textEditingController.text = 0.toString();
              }
              controller.calculatedOutput.value = 0.0;
            }, kTeal),
            operationsWidget('4', () => controller.addValueToTextField('4')),
            operationsWidget('5', () => controller.addValueToTextField('5')),
            operationsWidget('6', () => controller.addValueToTextField('6')),
            operationsWidget(
                '+', () => controller.calculateValue("add"), kTeal),
            operationsWidget('7', () => controller.addValueToTextField('7')),
            operationsWidget('8', () => controller.addValueToTextField('8')),
            operationsWidget('9', () => controller.addValueToTextField('9')),
            operationsWidget(
                '-', () => controller.calculateValue("sub"), kTeal),
            operationsWidget('0', () => controller.addValueToTextField('0')),
            operationsWidget(
                '/', () => controller.calculateValue("div"), kTeal),
            operationsWidget(
                '*', () => controller.calculateValue("multiply"), kTeal),
            operationsWidget('=', () {}, kTeal),
            operationsWidget(
                '.', () => controller.addValueToTextField('.'), kTeal),
            operationsWidget('RESET', () {
              controller.currencyFieldList.clear();
              controller.calculatedOutput.value = 0.0;
            }, kTeal),
            operationsWidget(
                'Curr', () => controller.openModalSheet(context), kTeal),
            operationsWidget('Delete', () {
              var data = controller
                  .currencyFieldList[controller.focusedIndex.value]
                  .textEditingController
                  .text
                  .split('');
              data.removeLast();
              controller.currencyFieldList[controller.focusedIndex.value]
                  .textEditingController.text = data.join().toString();
            }, kTeal),
          ],
        ),
      );

  operationsWidget(String buttonValue, Function() param1,
      [Color color = kWhiteColor]) {
    return InkWell(
      onTap: param1,
      child: Container(
        width: 120,
        height: 65,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text(
            buttonValue,
            style: textStyleWithRoboto(
                colors: color, fontWeight: FontWeight.w600, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
