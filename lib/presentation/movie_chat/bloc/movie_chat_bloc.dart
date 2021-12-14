import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/services/error_handling/failures.dart';
import '../../../core/services/error_handling/service_errors.dart';
import '../../../core/utils/prefs_consts.dart';
import '../../../domain/entities/chat_message_entity.dart';
import '../../../domain/usecases/chat_messages/get_all.dart';
import '../../../domain/usecases/chat_messages/upsert.dart';
import '../../../domain/usecases/preferences/get_string.dart';

part 'movie_chat_event.dart';
part 'movie_chat_state.dart';

class MovieChatBloc extends Bloc<MovieChatEvent, MovieChatState> {
  final PreferencesGetStringUseCase getString;
  final GetAllChatMessagesUseCase getAllMessages;
  final UpsertChatMessageUseCase upsertChatMessage;

  MovieChatBloc({
    required this.getString,
    required this.getAllMessages,
    required this.upsertChatMessage,
  }) : super(MovieChatEmpty()) {
    on<MovieChatEvent>((event, emit) async {
      if (event is MovieChatGetInitialData) {
        emit.call(MovieChatLoading());

        String userUuid = "";
        (await getString(const ParamsGetString(key: prefsUserUuid, defVal: "")))
            .fold((failure) {
          userUuid = "";
        }, (response) {
          userUuid = response;
        });

        String userName = "";
        (await getString(const ParamsGetString(key: prefsUserName, defVal: "")))
            .fold((failure) {
          userName = "";
        }, (response) {
          userName = response;
        });

        (await getAllMessages(ParamsGetChatMessages(movieId: event.movieId)))
            .fold((failure) {
          emit.call(MovieChatError(failure: failure));
        }, (response) {
          if (response.error == noError) {
            emit.call(MovieChatInitialDataLoaded(
                userUuid: userUuid,
                userName: userName,
                messages: response.messages?.map((messages) => messages
                    .map((message) => ChatMessageEntity().fromModel(message))
                    .toList())));
          } else {
            emit.call(MovieChatError(
                failure: ServerFailure(errorCode: response.errorCode)));
          }
        });
      } else if (event is MovieChatUpsertMessage) {
        emit.call(MovieChatLoading());

        (await upsertChatMessage(
                ParamsUpsertChatMessage(message: event.message)))
            .fold((failure) {
          emit.call(MovieChatError(failure: failure));
        }, (response) {
          if (response.error == noError) {
            emit.call(MovieChatMessageUpserted());
          } else {
            emit.call(MovieChatError(
                failure: ServerFailure(errorCode: response.errorCode)));
          }
        });
      } else if (event is MovieChatSetIdle) {
        emit.call(MovieChatIdle());
      }
    });
  }
}
