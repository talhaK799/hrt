import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hart/core/constants/theme_colors.dart';
import 'package:hart/core/services/localization_services.dart';
import 'package:hart/core/services/locato_storage_service.dart';
import 'package:hart/core/view_models/theme_provider.dart';
import 'package:hart/locator.dart';
import 'package:hart/ui/screens/chatting_screen/conversation_provider.dart';
import 'package:hart/ui/screens/chatting_screen/conversation_screen/chatting/chatting_provider.dart';
import 'package:hart/ui/screens/collect_info_screens/verifications/phone_no_screen/phone_no_provider.dart';
import 'package:hart/ui/screens/home/home_provider.dart';
import 'package:hart/ui/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'ui/screens/collect_info_screens/verifications/email_screen.dart/email_verification_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
  final langCode = await locator<LocalStorageService>().getSelectedLanguage();
  runApp(MyApp(langCode));
}

class MyApp extends StatelessWidget {
  final String langCode;
  MyApp(this.langCode) {
    print("selectedLangCode => $langCode");
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(Get.width, Get.height),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => HomeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => EmailVerificationProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PhoneNoProvider(),
          ),
        ],
        child: Consumer<ThemeProvider>(builder: (context, model, child) {
          return GetMaterialApp(
            locale: Locale(langCode),
            translations: LocalizationService(),
            debugShowCheckedModeBanner: false,
            darkTheme: model.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
            theme: AppColors.themeData(model.isDarkTheme, context),
            home: SplashScreen(),
          );
        }),
      ),
    );
  }
}
