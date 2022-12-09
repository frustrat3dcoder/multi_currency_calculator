import 'package:mobx_calculator/app/modules/currency_symbol_module/currency_symbol_controller.dart';
import 'package:get/get.dart';
import 'package:mobx_calculator/app/services/currency_rate_service.dart';


class CurrencySymbolBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CurrencySymbolController(currencySymbolServices: CurrencySymbolServices()));
  }
}