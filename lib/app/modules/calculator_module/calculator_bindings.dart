import 'package:get/get.dart';
import 'package:mobx_calculator/app/modules/calculator_module/calculator_controller.dart';

import '../../services/currency_rate_service.dart';
import '../../utils/connection_helper.dart';

class CalculatorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>
        CalculatorController(currencySymbolServices: CurrencySymbolServices()));
    Get.lazyPut<GetXNetworkManager>(() => GetXNetworkManager());
  }
}
