import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mentor/config/app_router.dart';
import 'package:mentor/config/utils/strings.dart';
import 'package:mentor/model/mars_photo.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MarsPhotoAdapter());
  Hive.registerAdapter(CameraAdapter());
  await Hive.openBox(switchersBox);
  await Hive.openBox<MarsPhoto>(photosBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(switchersBox).listenable(),
      builder: (BuildContext context, box, Widget? child) {
        bool isDarkMode = box.get(darkModeValue, defaultValue: false);
        String isArabic = box.get(languageValue, defaultValue: "en");
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          locale: Locale(isArabic),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          title: 'Nasa',
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          routerConfig: AppRouter.appRouter,
        );
      },
    );
  }
}
