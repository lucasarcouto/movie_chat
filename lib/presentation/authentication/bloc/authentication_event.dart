part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUpsertUser extends AuthenticationEvent {
  final UserEntity user;

  const AuthenticationUpsertUser(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationSetIdle extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
