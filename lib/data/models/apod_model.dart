import 'package:estudo_clean_arch_nasa/domain/entities/apod.dart';

class ApodModel extends Apod {
  const ApodModel({
    super.copyright,
    super.date,
    super.explanation,
    super.hdurl,
    super.mediaType,
    super.serviceVersion,
    super.thumbnailUrl,
    super.title,
    super.url,
  });

  // aqui pode ser tanto fromMap como fromJson, desde que converta de forma correta
  // como estamos trabalhando como clean code e irei trabalhar com nomenclatura padrão
  // irei manter a conveção de fromMap para compreender melhor os conceitos.

  factory ApodModel.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'date': String date,
        'explanation': String explanation,
        'media_type': String mediaType,
        'service_version': String serviceVersion,
        'title': String title,
        'url': String url,
      } =>
        ApodModel(
          copyright: json['copyright'] ?? 'Nasa APOD',
          date: date,
          explanation: explanation,
          hdurl: json['hdurl'],
          mediaType: mediaType,
          serviceVersion: serviceVersion,
          thumbnailUrl: json['thumbnail_url'],
          title: title,
          url: url,
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }

  Map<String, dynamic> toJson() => {
    'copyright': copyright,
    'date': date,
    'explanation': explanation,
    'hdurl': hdurl,
    'media_type': mediaType,
    'service_version': serviceVersion,
    'thumbnail_url': thumbnailUrl,
    'title': title,
    'url': url,
  };
}
