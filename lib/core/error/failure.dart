import 'package:equatable/equatable.dart';

abstract interface class Failure extends Equatable {
  String get msg;

  @override
  List<Object?> get props => [];
}

/// No internet connection
class NoConnection extends Failure {
  @override
  String get msg => 'Sorry! You not have connection!';
}
