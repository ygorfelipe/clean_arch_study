import 'package:dartz/dartz.dart';
import 'package:estudo_clean_arch_nasa/core/error/failure.dart';

abstract class UseCase<R, P> {
  /// Padrao useCase
  /// R retorna a função de call
  /// P é o parametro da função call

  /// Essa clss sera responsavel por manter um padrao dentro dos usecase
  /// Basicamente ele vai retornar o call sempre, então a unica certeza que temos é
  /// que Sempre ira retornar o Failure e Alguma coisa, esse alguma é o R de retorno
  Future<Either<Failure, R>> call(P parameter);
}

class NoParameter {}
