import 'package:estudo_clean_arch_nasa/data/datasources/network/network_info_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateNiceMocks([MockSpec<InternetConnectionChecker>()])
void main() {
  late MockInternetConnectionChecker internetConnection;
  late NetworkInfoImpl networkInfo;

  setUp(() {
    internetConnection = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(internetConnection: internetConnection);
  });

  // teremos um campo chamado hasConnectio, e nosso NetworkInfo ele retorna também um bool, pois iremos fazer os testes
  // nós devemos passar esse valor lá para o nosso network info

  test('Deve retornar um true se houver conexão', () async {
    when(internetConnection.hasConnection).thenAnswer((_) async => true);

    final result = await networkInfo.isConnected;

    expect(result, true);
  });
  test('Deve retornar um false se não houver conexão', () async {
    when(internetConnection.hasConnection).thenAnswer((_) async => false);

    final result = await networkInfo.isConnected;

    expect(result, false);
  });
}
