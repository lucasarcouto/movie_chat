import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../core/services/error_handling/failures.dart';
import '../../../core/utils/prefs_consts.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/preferences/put_string.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final PreferencesPutStringUseCase putString;

  AuthenticationBloc({
    required this.putString,
  }) : super(AuthenticationEmpty()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthenticationUpsertUser) {
        emit.call(AuthenticationLoading());

        (await putString(
            ParamsPutString(key: prefsUserUuid, value: const Uuid().v4())));

        (await putString(
            ParamsPutString(key: prefsUserName, value: event.user.name)));

        emit.call(AuthenticationUserUpserted());
      } else if (event is AuthenticationSetIdle) {
        emit.call(AuthenticationIdle());
      }
    });
  }
}
