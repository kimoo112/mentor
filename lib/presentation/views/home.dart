import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../config/strings.dart';
import '../../generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                ],
              ),
            );
          },
        ));
  }
}
