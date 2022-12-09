import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx_calculator/app/modules/calculator_module/calculator_controller.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_theme.dart';
import '../../../utils/size_config.dart';

class ModalBottomSheet extends GetView<CalculatorController> {
  ModalBottomSheet({Key? key}) : super(key: key);
  RxString currencyChoosen = ''.obs;
  RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return buildBottomSheet(context);
  }

  Widget buildBottomSheet(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight / 2,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose currency for the field",
              style: textStyleWithRoboto(
                  colors: kWhiteColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return Obx(() {
                    RxString currentKey = controller.symbolList[index].obs;
                    return RadioListTile(
                      onChanged: (val) {
                        controller.groupValue.value = val!;
                        currencyChoosen.value = controller.symbolList[index];
                        selectedIndex.value = index;
                      },
                      activeColor: Colors.teal,
                      value: index,
                      title: Text(
                        currentKey.value,
                        style: textStyleWithRoboto(
                            colors: kWhiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0),
                      ),
                      groupValue: controller.groupValue.value,
                    );
                  });
                },
                itemCount: controller.symbolList.length,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            log("chosen value is ${currencyChoosen.value.trim().split('-')[0]}");
            controller.addCurrencyFieldToList(
                currencyChoosen.value.trim().split('-')[0],
                selectedIndex.value);
            Get.back();
          },
          backgroundColor: kTeal,
          child: const Icon(
            Icons.check,
            color: kWhiteColor,
          )),
    );
  }
}
