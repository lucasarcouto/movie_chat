part of 'movie_chat_bloc.dart';

abstract class MovieChatEvent extends Equatable {
  const MovieChatEvent();

  @override
  List<Object> get props => [];
}

class MovieChatGetInitialData extends MovieChatEvent {
  final String movieId;

  const MovieChatGetInitialData(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class MovieChatUpsertMessage extends MovieChatEvent {
  final ChatMessageEntity message;

  const MovieChatUpsertMessage(this.message);

  @override
  List<Object> get props => [];
}

class MovieChatSetIdle extends MovieChatEvent {
  @override
  List<Object> get props => [];
}
