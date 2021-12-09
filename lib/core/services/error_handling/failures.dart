import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
}

class ServerFailure extends Failure {
  final dynamic errorCode;
  final dynamic exception;

  const ServerFailure({this.errorCode, this.exception});

  @override
  List<Object> get props => [errorCode, exception];
}
