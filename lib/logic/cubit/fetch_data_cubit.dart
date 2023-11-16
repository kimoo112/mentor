// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../../data/Repository/repository.dart';
import '../../model/mars_photo.dart';

part 'fetch_data_state.dart';

class FetchDataCubit extends Cubit<FetchDataState> {
  FetchDataCubit() : super(FetchDataInitial());
  final Repository _repository = Repository();
  List<MarsPhoto> marsPhotos = [];
  DateTime? selectedDate;

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
