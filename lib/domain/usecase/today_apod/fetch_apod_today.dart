import 'package:dartz/dartz.dart';
import 'package:estudo_clean_arch_nasa/core/failures/failure.dart';
import 'package:estudo_clean_arch_nasa/domain/entities/apod.dart';
import 'package:estudo_clean_arch_nasa/domain/usecase/core/use_case.dart';

import '../../repositories/today_apod/today_apod_repository.dart';

class FetchApodToday extends UseCase<Apod, NoParameter> {
  /// Dentro do usecase é onde iremos realizar as regras de negocio de cada usecase ou seja
  /// Cada busca ou inserção devera ser criado separadamente e não dentro da mesma class
  final TodayApodRepository repository;

  FetchApodToday({required this.repository});

  @override
  Future<Either<Failure, Apod>> call(NoParameter noParameter) async {
    return await repository.fechApodtoday();
  }
}
