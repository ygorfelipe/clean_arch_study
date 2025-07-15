part of 'today_apod_bloc.dart';

abstract interface class TodayApodEvent extends Equatable {
  const TodayApodEvent();

  @override
  List<Object?> get props => [];
}

class FetchApodTodayEvent extends TodayApodEvent {}
