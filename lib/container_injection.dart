import 'package:estudo_clean_arch_nasa/data/datasources/network/network_info.dart';
import 'package:estudo_clean_arch_nasa/data/datasources/network/network_info_impl.dart';
import 'package:estudo_clean_arch_nasa/data/datasources/today_apod/today_apod_data_source.dart';
import 'package:estudo_clean_arch_nasa/data/datasources/today_apod/today_apod_data_source_impl.dart';
import 'package:estudo_clean_arch_nasa/data/repositories/today_apod/today_apod_repository_impl.dart';
import 'package:estudo_clean_arch_nasa/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:estudo_clean_arch_nasa/domain/usecase/today_apod/fetch_apod_today.dart';
import 'package:estudo_clean_arch_nasa/presentation/bloc/today_apod/today_apod_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

GetIt getIt = GetIt.instance;

// aqui é onde iremos colocar todas as dependencias
Future<void> setUpContainer() async {
  // dependendia externa
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.instance,
  );
  // interna
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(internetConnection: getIt()),
  );

  // features
  apodToday();
}

void apodToday() {
  getIt.registerLazySingleton<TodayApodDataSource>(
    () => TodayApodDataSourceImpl(client: getIt()),
  );
  getIt.registerLazySingleton<TodayApodRepository>(
    () => TodayApodRepositoryImpl(dataSource: getIt(), networkInfo: getIt()),
  );

  getIt.registerLazySingleton<FetchApodToday>(
    () => FetchApodToday(repository: getIt()),
  );

  getIt.registerFactory(() => TodayApodBloc(fetchApodToday: getIt()));
}
