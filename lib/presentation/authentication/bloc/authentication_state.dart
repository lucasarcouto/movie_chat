part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationUserUpserted extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationError extends AuthenticationState {
  final Failure failure;

  const AuthenticationError({required this.failure});

  @override
  List<Object> get props => [failure];
}

class AuthenticationIdle extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationEmpty extends AuthenticationState {
  @override
  List<Object> get props => [];
}
