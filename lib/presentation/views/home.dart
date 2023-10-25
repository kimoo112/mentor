import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../WebServices/web_services.dart';
import '../../config/routes.dart';
import '../../config/strings.dart';
import '../../generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final webServices = WebServices();
    Box switchers = Hive.box(box);
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).title),
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box(box).listenable(),
          builder: (BuildContext context, box, Widget? child) {
            String isArabic = box.get(languageValue, defaultValue: "en");
            bool isDarkMode = switchers.get(darkModeValue, defaultValue: false);
            return Center(
              child: Column(
                children: [
                  Switch(
                      value: isArabic == "en",
                      onChanged: (val) {
                        switchers.put(languageValue, val ? "en" : "ar");
                      }),
                  DayNightSwitcher(
                    isDarkModeEnabled: isDarkMode,
                    onStateChanged: (val) {
                      switchers.put(darkModeValue, !isDarkMode);
                    },
                  ),
                   ElevatedButton(
      child: const Text('Go News'),
      onPressed: () {
        context.push(news);
      },
      
    ),
     const SizedBox(
            height: 20,
          ), ElevatedButton(
            child: const Text('Get Data'),
            onPressed: () {
              webServices.fetchData(DateTime.now());
            },
          ),
                ],
              ),
            );
          },
        ));
  }
}
