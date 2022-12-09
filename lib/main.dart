import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx_calculator/app/modules/calculator_module/calculator_bindings.dart';

import 'app/modules/currency_symbol_module/currency_symbol_bindings.dart';
import 'app/routes/app_pages.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Moment',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Satoshi',
        backgroundColor: Colors.black45,
        primaryColor: Colors.teal,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.calculator,
      getPages: AppPages.pages,
      initialBinding: CalculatorBinding(),
    );
  }
}
