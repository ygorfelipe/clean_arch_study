import 'package:estudo_clean_arch_nasa/data/models/apod_model.dart';

abstract interface class TodayApodDataSource {
  /// Retorna o data do [ApodModel] caso sucesso, por outro lado
  /// throw a [Failure]

  Future<ApodModel> fetchTodayApod();
}
