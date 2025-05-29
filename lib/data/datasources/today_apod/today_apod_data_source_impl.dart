import 'dart:convert';

import 'package:estudo_clean_arch_nasa/core/failures/failure.dart';
import 'package:estudo_clean_arch_nasa/data/models/apod_model.dart';
import 'package:estudo_clean_arch_nasa/environment.dart';
import 'package:http/http.dart' as http;

import './today_apod_data_source.dart';

/// Aqui no dataSource é onde iremos trabalhar com a requisição da API
class TodayApodDataSourceImpl implements TodayApodDataSource {
  
  final http.Client client;

  TodayApodDataSourceImpl({required this.client});

  @override
  Future<ApodModel> fetchTodayApod() async {
    // chamando o try catch e aqui pode trabalhar com o try catch
    http.Response response;
    try {
      response = await client.get(Uri.parse(Environment.urlBase));
    } catch (e) {
      throw ApiFailure();
    }  

    if (response.statusCode == 200) {
      // convertendo o modelo para um json
      // convertendo o body decody em utf8 sendo assim para a gente não perde nenhum caracteres especial e converter corretamente

      final json = jsonDecode(utf8.decode(response.bodyBytes));
      return ApodModel.fromMap(json);
    } else {
      throw ApiFailure();
    }
  }
}
