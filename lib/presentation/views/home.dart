import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../../config/utils/strings.dart';
import '../../generated/l10n.dart';
import '../../logic/cubit/fetch_data_cubit.dart';
import '../widgets/empty_mars_photos.dart';
import '../widgets/mars_photos_listview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box switchers = Hive.box(switchersBox);
  String? isArabic;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FetchDataCubit>(context).checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FetchDataCubit, FetchDataState>(
      listener: (context, state) {
    BlocProvider.of<FetchDataCubit>(context).checkConnection();
      },
      child: BlocBuilder<FetchDataCubit, FetchDataState>(
        builder: (context, state) {
          final fetchData = BlocProvider.of<FetchDataCubit>(context);
          return Scaffold(
              appBar: AppBar(
                actions: [
                  fetchData.isOnline
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.wifi,
                            color: Color.fromARGB(255, 11, 160, 6),
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.signal_wifi_off_sharp,
                            color: Color(0xFFA00606),
                          ),
                        )
                ],
                title: Text(
                  S.of(context).title,
                  style: isArabic == 'en'
                      ? const TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.w600)
                      : const TextStyle(
                          fontFamily: 'Almarai', fontWeight: FontWeight.w600),
                ),
                scrolledUnderElevation: 0,
              ),
              body: ValueListenableBuilder(
                valueListenable: Hive.box(switchersBox).listenable(),
                builder: (BuildContext context, box, Widget? child) {
                  String isArabic = box.get(languageValue, defaultValue: "en");
                  bool isDarkMode =
                      switchers.get(darkModeValue, defaultValue: false);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          underline: const SizedBox(),
                          borderRadius: BorderRadius.circular(10),
                          hint: const Text('Select The Language'),
                          value: isArabic,
                          focusColor: const Color.fromARGB(255, 4, 91, 163),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              switchers.put(languageValue, newValue);
                            }
                          },
                          items: const [
                            DropdownMenuItem(
                              value: "en",
                              child: Text(
                                "   English",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            DropdownMenuItem(
                                value: "ar",
                                child: Text(
                                  "    العربية ",
                                  style: TextStyle(
                                      fontFamily: 'Almarai',
                                      fontWeight: FontWeight.w600),
                                )),
                          ],
                          isExpanded: true,
                        ),
                      ),
                      DayNightSwitcher(
                        isDarkModeEnabled: isDarkMode,
                        onStateChanged: (val) {
                          switchers.put(darkModeValue, !isDarkMode);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        trailing: const Icon(CupertinoIcons.time),
                        title: Text(
                          S.of(context).pickTime,
                          style: isArabic == 'en'
                              ? const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600)
                              : const TextStyle(
                                  fontFamily: 'Almarai',
                                  fontWeight: FontWeight.w600),
                        ),
                        subtitle: fetchData.selectedDate != null
                            ? Text(
                                DateFormat.yMMMd()
                                    .format(fetchData.selectedDate!),
                                style: isArabic == 'en'
                                    ? const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600)
                                    : const TextStyle(
                                        fontFamily: 'Almarai',
                                        fontWeight: FontWeight.w600),
                              )
                            : const Text(''),
                        onTap: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: fetchData.selectedDate ??
                                DateTime.now().subtract(
                                  const Duration(days: 30),
                                ),
                            firstDate: DateTime(2018),
                            lastDate: DateTime.now(),
                          );
                          fetchData.changeSelectedDate(selectedDate!);
                        },
                      ),
                      if (state is DataLoading)
                        loadingData()
                      else
                        fetchData.marsPhotos.isNotEmpty
                            ? MarsPhotosListView(
                                fetchData: fetchData,
                                isArabic: isArabic,
                              )
                            : EmptyMarsPhotos(
                                isArabic: isArabic,
                              )
                    ],
                  );
                },
              ));
        },
      ),
    );
  }

  Expanded loadingData() {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
