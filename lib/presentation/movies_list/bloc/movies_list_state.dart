part of 'movies_list_bloc.dart';

abstract class MoviesListState extends Equatable {
  const MoviesListState();

  @override
  List<Object> get props => [];
}

class MoviesListInitialDataLoaded extends MoviesListState {
  final List<MovieEntity> movies;

  const MoviesListInitialDataLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class MoviesListLoading extends MoviesListState {
  @override
  List<Object> get props => [];
}

class MoviesListError extends MoviesListState {
  final Failure failure;

  const MoviesListError({required this.failure});

  @override
  List<Object> get props => [failure];
}

class MoviesListIdle extends MoviesListState {
  @override
  List<Object> get props => [];
}

class MoviesListEmpty extends MoviesListState {
  @override
  List<Object> get props => [];
}
