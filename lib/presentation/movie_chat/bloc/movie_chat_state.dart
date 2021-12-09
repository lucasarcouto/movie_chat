part of 'movie_chat_bloc.dart';

abstract class MovieChatState extends Equatable {
  const MovieChatState();
  
  @override
  List<Object> get props => [];
}

class MovieChatInitial extends MovieChatState {}
