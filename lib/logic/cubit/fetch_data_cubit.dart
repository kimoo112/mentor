import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';

import '../../data/Repository/repository.dart';
import '../../model/mars_photo.dart';

part 'fetch_data_state.dart';

class FetchDataCubit extends Cubit<FetchDataState> {
  FetchDataCubit() : super(FetchDataInitial());
  final Repository _repository = Repository();
  List<MarsPhoto> marsPhotos = [];
  DateTime? selectedDate;
  bool isOnline = false;

checkConnection() async {
  try {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    isOnline = hasConnection;
    emit(isOnline ? UserIsOnline() : UserIsOffline());
  } catch (e) {
    debugPrint("Error checking connection: $e");
    isOnline = false;
    emit(UserIsOffline());
  }
}

  changeSelectedDate(DateTime? selectedDate) {
    if (selectedDate != null) {
      this.selectedDate = selectedDate;

      emit(SelectedDateChanged());
      fetchData(selectedDate);
    } else {
      emit(SelectedDateIsNull());
    }
  }

  fetchData(DateTime earthDate) async {
    emit(DataLoading());
    marsPhotos = await _repository.fetchData(earthDate);
    emit(DataLoaded());
  }
}
