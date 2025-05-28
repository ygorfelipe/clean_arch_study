import 'package:equatable/equatable.dart';

abstract interface class Failure extends Equatable {
  String get msg;

  @override
  List<Object?> get props => [];
}

/// No internet connection
class NoConnection extends Failure {
  @override
  String get msg => 'Desculpa! Você não tem conexão';
}

/// is no possible access API
class ApiFailure extends Failure {
  @override
  String get msg => 'Desculpa! Não é possível acessar o Servidor';
}
