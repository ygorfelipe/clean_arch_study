import 'dart:convert';
import 'dart:io';

import 'package:estudo_clean_arch_nasa/core/failures/failure.dart';
import 'package:estudo_clean_arch_nasa/data/datasources/today_apod/today_apod_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixtures.dart';
import '../../../mocks/mocks.mocks.dart';
import '../../../test_values.dart';

void main() {
  late MockClient client;
  late TodayApodDataSourceImpl dataSource;

  setUp(() {
    client = MockClient();
    dataSource = TodayApodDataSourceImpl(client: client);
  });

  group('Funcion fetchTodayApod', () {
    // sucesso = Apod, retornando o json e convertando na nossa class
    // os datasorce retorna a model e não a entidade
    test('Deve retornar um ApodModel', () async {
      // cenario
      // aqui podemos fazer a busca aqui, nesse caso seria um dio por exemplo;
      // quando a função get chamar qlqr valor do any, podemos mandar um arquivo especifico
      // o bytes é para garantir que não perdeu nada, onde que iremos receber a lista de inteiros.
      // convetendo um valor para bytes
      when(
        client.get(any),
      ).thenAnswer(
        (_) async => http.Response.bytes(
          utf8.encode(fixture('image_response.json')),
          200,
        ),
      );

      // acao
      final result = await dataSource.fetchTodayApod();

      // esperado
      expect(result, tApodModel());
    });

    // falha1 de status code apiFailure != 200
    test(
      'Deve lançar (throw) uma apiFailure quando a api retornar um valor diferente de 200',
      () async {
        when(client.get(any)).thenAnswer(
          (_) async => http.Response.bytes(
            utf8.encode(fixture('image_response.json')),
            500,
          ),
        );
        // capturando a exception
        expect(() => dataSource.fetchTodayApod(), throwsA(isA<ApiFailure>()));
      },
    );

    // falha2 retorna apiFailure cliente exceptions

    test(
      'Deve lançar (throw) uma apiFailure quando houver uma exceptions',
      () async {
        when(client.get(any)).thenThrow(const SocketException('message'));
        // capturando a exception
        expect(() => dataSource.fetchTodayApod(), throwsA(isA<ApiFailure>()));
      },
    );
  });
}
