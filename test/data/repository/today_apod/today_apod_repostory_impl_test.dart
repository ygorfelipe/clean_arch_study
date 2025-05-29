import 'package:dartz/dartz.dart';
import 'package:estudo_clean_arch_nasa/core/failures/failure.dart';
import 'package:estudo_clean_arch_nasa/data/datasources/network/network_info.dart';
import 'package:estudo_clean_arch_nasa/data/datasources/today_apod/today_apod_data_source.dart';
import 'package:estudo_clean_arch_nasa/data/repositories/today_apod/today_apod_repository_impl.dart';
import 'package:estudo_clean_arch_nasa/domain/entities/apod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values.dart';
import 'today_apod_repostory_impl_test.mocks.dart';

// Nessa mock é diferente, pois iremos testar também a conexão

@GenerateNiceMocks([MockSpec<TodayApodDataSource>(), MockSpec<NetworkInfo>()])
void main() {
  late MockTodayApodDataSource dataSource;
  late MockNetworkInfo networkInfo;
  late TodayApodRepositoryImpl repository;

  setUp(() {
    dataSource = MockTodayApodDataSource();
    networkInfo = MockNetworkInfo();
    repository = TodayApodRepositoryImpl(
      dataSource: dataSource,
      networkInfo: networkInfo,
    );
  });

  // group no qual agrupa os testes, sobre as funções fetchApodToday

  group('function fetchApodToday', () {
    // com internet = sucesso ApodModel
    test('Deve retornar uma entidade Apod do lado direito do Eiter', () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(dataSource.fetchTodayApod()).thenAnswer((_) async => tApodModel());

      final result = await repository.fechApodtoday();

      expect(result, Right<Failure, Apod>(tApodModel()));
    });
    // com internet = exception
    test(
      'Deve retornar uma Failure no lado esquerdo do EIther vindo do datasource',
      () async {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.fetchTodayApod()).thenThrow(ApiFailure());

        final result = await repository.fechApodtoday();

        expect(result, Left<Failure, Apod>(ApiFailure()));
      },
    );
    // sem internet = falha
    test(
      'Deve retornar uma Failure no lado esquerdo do tipo NoConnection',
      () async {
        when(networkInfo.isConnected).thenAnswer((_) async => false);

        final result = await repository.fechApodtoday();

        // Verificando se o datasource não seja chamado
        verifyNever(dataSource.fetchTodayApod());
        expect(result, Left<Failure, Apod>(NoConnection()));
      },
    );
  });
}
