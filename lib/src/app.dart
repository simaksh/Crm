import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../generated/locales.g.dart';
import 'infrastructure/route/route-name.dart';
import 'infrastructure/route/route-page.dart';



class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    initialRoute: RouteName.login,
    getPages: RoutePage.pages,
    debugShowCheckedModeBanner: false,
    translations: AppTranslation(),
    locale: const Locale('en', 'US'),
  );
}