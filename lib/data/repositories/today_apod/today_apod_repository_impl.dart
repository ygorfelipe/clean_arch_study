import 'package:dartz/dartz.dart';
import 'package:estudo_clean_arch_nasa/core/failures/failure.dart';
import 'package:estudo_clean_arch_nasa/data/datasources/network/network_info.dart';
import 'package:estudo_clean_arch_nasa/data/datasources/today_apod/today_apod_data_source.dart';
import 'package:estudo_clean_arch_nasa/domain/entities/apod.dart';
import 'package:estudo_clean_arch_nasa/domain/repositories/today_apod/today_apod_repository.dart';

class TodayApodRepositoryImpl implements TodayApodRepository {
  final TodayApodDataSource dataSource;
  final NetworkInfo networkInfo;

  TodayApodRepositoryImpl({
    required this.dataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Apod>> fechApodtoday() async {
    // verifica conecao com internet senão falha
    if (await networkInfo.isConnected) {
      try {
        final model = await dataSource.fetchTodayApod();
        return Right(model);
      } on Failure catch (e) {
        return Left(e);
      }
    } else {
      return Left(NoConnection());
    }
  }
}
