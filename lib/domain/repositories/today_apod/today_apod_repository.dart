import 'package:dartz/dartz.dart';
import 'package:estudo_clean_arch_nasa/core/error/failure.dart';
import 'package:estudo_clean_arch_nasa/domain/entities/apod.dart';

abstract interface class TodayApodRepository {
  /// Retorna o Apod data do lado direito do Either caso sucesso, de outra forma
  /// Retorna Failure do lado esquerdo do Either
  Future<Either<Failure, Apod>> fechApodtoday();
}
