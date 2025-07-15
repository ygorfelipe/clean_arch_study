import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:estudo_clean_arch_nasa/domain/entities/apod.dart';
import 'package:estudo_clean_arch_nasa/domain/usecase/core/use_case.dart';
import 'package:estudo_clean_arch_nasa/domain/usecase/today_apod/fetch_apod_today.dart';

part 'today_apod_event.dart';
part 'today_apod_state.dart';

class TodayApodBloc {
  final FetchApodToday fetchApodToday;

  TodayApodBloc({required this.fetchApodToday}) {
    _inputController.stream.listen(_blocEventController);
  }

  // trabalhando com bloc manualmente, utilizando StreamController
  // para o estudo ele sera utilizado para facilitar, porém a melhor forma para trabalhar é utilizando a forma mais atual que utilizamos

  final StreamController<TodayApodEvent> _inputController =
      StreamController<TodayApodEvent>();
  final StreamController<TodayApodState> _outputController =
      StreamController<TodayApodState>();

  Sink<TodayApodEvent> get input => _inputController.sink;
  Stream<TodayApodState> get stream => _outputController.stream;

  void _blocEventController(TodayApodEvent event) {
    _outputController.add(LoadingTodayApodState());

    if (event is FetchApodTodayEvent) {
      fetchApodToday(
        NoParameter(),
      ).then(
        (value) => value.fold(
          (l) => _outputController.add(ErrorTodayApodState(msg: l.msg)),
          (r) => _outputController.add(SuccessTodayApodState(apod: r)),
        ),
      );
    }
  }
}
