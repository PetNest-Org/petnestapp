import 'package:demopetnest/bindings/general_bindings.dart';
import 'package:demopetnest/features/authentication/screens/onboarding/onboarding.dart';
import 'package:demopetnest/routes/routes/app_routes.dart';
import 'package:demopetnest/utils/constants/text_strings.dart';
import 'package:demopetnest/utils/device/web_material_scroll.dart';
import 'package:demopetnest/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(title: TTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      home: OnBoardingScreen(),

      /// Show Loader or Circular Progress indicator meanwhile Authentication Repository is deciding to show relevant screen
      // home: Scaffold(
      //   backgroundColor: TColors.primary,
      //   body: Center(
      //     child: CircularProgressIndicator(
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
    );
  }
}