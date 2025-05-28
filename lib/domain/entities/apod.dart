import 'package:equatable/equatable.dart';

// o Equatable explicado na aula, determina que o objeto por si só se cada elemento
// for igual ele é identico
// exemplo, final a = 'title' final b = 'title'
// a == b return ?
// nesse caso o dart ira entender que o a não é igual a b, pois ele não esta referenciando na mesma memoria
// ou seja, o a esta em alocado em um x da memoria e o b em outro x da memoria, o equetable faz com que ele entenda que o objeto por si esta alocado na memoria

class Apod extends Equatable {
  final String? copyright;
  final String? date;
  final String? explanation;
  final String? hdurl;
  final String? mediaType;
  final String? serviceVersion;
  final String? thumbnailUrl;
  final String? title;
  final String? url;
  const Apod({
    this.copyright,
    this.date,
    this.explanation,
    this.hdurl,
    this.mediaType,
    this.serviceVersion,
    this.thumbnailUrl,
    this.title,
    this.url,
  });

  @override
  List<Object?> get props => [
    copyright,
    date,
    explanation,
    hdurl,
    mediaType,
    serviceVersion,
    thumbnailUrl,
    title,
    url,
  ];
}
