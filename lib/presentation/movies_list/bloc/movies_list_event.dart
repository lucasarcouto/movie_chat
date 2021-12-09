part of 'movies_list_bloc.dart';

abstract class MoviesListEvent extends Equatable {
  const MoviesListEvent();

  @override
  List<Object> get props => [];
}

class MoviesListGetInitialData extends MoviesListEvent {
  @override
  List<Object> get props => [];
}

class MoviesListSetIdle extends MoviesListEvent {
  @override
  List<Object> get props => [];
}
