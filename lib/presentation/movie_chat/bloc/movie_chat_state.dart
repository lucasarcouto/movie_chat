part of 'movie_chat_bloc.dart';

abstract class MovieChatState extends Equatable {
  const MovieChatState();

  @override
  List<Object> get props => [];
}

class MovieChatInitialDataLoaded extends MovieChatState {
  final String userUuid;
  final String userName;
  final Stream<List<ChatMessageEntity>>? messages;

  const MovieChatInitialDataLoaded(
      {required this.userUuid, required this.userName, required this.messages});

  @override
  List<Object> get props => [userUuid, userName];
}

class MovieChatMessageUpserted extends MovieChatState {
  @override
  List<Object> get props => [];
}

class MovieChatLoading extends MovieChatState {
  @override
  List<Object> get props => [];
}

class MovieChatError extends MovieChatState {
  final Failure failure;

  const MovieChatError({required this.failure});

  @override
  List<Object> get props => [failure];
}

class MovieChatIdle extends MovieChatState {
  @override
  List<Object> get props => [];
}

class MovieChatEmpty extends MovieChatState {
  @override
  List<Object> get props => [];
}
