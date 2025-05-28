import 'package:dartz/dartz.dart';
import 'package:estudo_clean_arch_nasa/core/error/failure.dart';
import 'package:estudo_clean_arch_nasa/domain/entities/apod.dart';
import 'package:estudo_clean_arch_nasa/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:estudo_clean_arch_nasa/domain/usecase/core/use_case.dart';
import 'package:estudo_clean_arch_nasa/domain/usecase/today_apod/fetch_apod_today.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'fetch_apod_today_test.mocks.dart';

// mock irá criar tipos de repostas em cada cenario

@GenerateNiceMocks([MockSpec<TodayApodRepository>()])
/// Classe de teste serve para testar unitarios são voltados para um classe especifica ou função
void main() {
  late MockTodayApodRepository repository;
  late FetchApodToday usecase;

  // aqui garante que cada teste seja único, sendo assim possível criar vários cenários para cada teste
  // e que funções que vier de outro teste não atrapalhe o outro.
  // no qual ele garante que seu cada teste esteja em seu estado inicial
  setUp(() {
    repository = MockTodayApodRepository();
    usecase = FetchApodToday(repository: repository);
  });

  // retorna apod

  test('Deve retornar uma entidade Apod do lado direito do Either', () async {
    // descrevendo o cenario
    when(
      repository.fechApodtoday(),
    ).thenAnswer(
      (_) async => Right<Failure, Apod>(tApod()),
    );

    // ação
    final result = await usecase.call(
      NoParameter(),
    );

    // esperado
    expect(
      result,
      Right<Failure, Apod>(tApod()),
    );
  });

  // retorna falha
  test('Deve retornar uma Failure no lado esquerdo do Either', () async {
    // descrevendo o cenario
    when(
      repository.fechApodtoday(),
    ).thenAnswer((_) async => Left<Failure, Apod>(tNoConnection()));

    // ação
    final result = await usecase.call(NoParameter());

    // esperado
    expect(result, Left<Failure, Apod>(tNoConnection()));
  });
}
