import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor/data/Repository/repository.dart';
import 'package:mentor/model/mars_photo.dart';

import '../../config/utils/routes.dart';
import '../../config/utils/strings.dart';
import '../../generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Repository repository = Repository();
  final controller = BoardDateTimeController();
  Box switchers = Hive.box(switchersBox);
  late DateTime _selectedDate = DateTime.now();
  pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (date != null && date != _selectedDate) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).title),
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box(switchersBox).listenable(),
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
                  ),
                  ElevatedButton(
                    onPressed: () {
                      pickDate();
                    },
                    child: const Text(
                      "Pick Time ",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Get Data'),
                    onPressed: () async {
                      List<MarsPhoto> photos = await repository
                          .fetchData(_selectedDate ?? DateTime(2013));
                      debugPrint(photos.length.toString());
                    },
                  ),
                  Text('$_selectedDate')
                ],
              ),
            );
          },
        ));
  }
}
