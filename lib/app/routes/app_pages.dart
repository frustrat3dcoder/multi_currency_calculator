import '../../app/modules/currency_symbol_module/currency_symbol_page.dart';
import '../../app/modules/currency_symbol_module/currency_symbol_bindings.dart';

import '../../app/modules/calculator_module/calculator_bindings.dart';
import '../../app/modules/calculator_module/calculator_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';


abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.calculator,
      page: () => CalculatorPage(),
      binding: CalculatorBinding(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: Routes.currencySymbol,
      page: () => CurrencySymbolPage(),
      binding: CurrencySymbolBinding(),
      transition: Transition.leftToRightWithFade,
    ),
  ];
}
