part of 'fetch_data_cubit.dart';

@immutable
sealed class FetchDataState {}

final class FetchDataInitial extends FetchDataState {}
final class DataLoading extends FetchDataState {}
final class DataLoaded extends FetchDataState {}
final class SelectedDateChanged extends FetchDataState {}
final class SelectedDateIsNull extends FetchDataState {}
