import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_chat_event.dart';
part 'movie_chat_state.dart';

class MovieChatBloc extends Bloc<MovieChatEvent, MovieChatState> {
  MovieChatBloc() : super(MovieChatInitial()) {
    on<MovieChatEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
