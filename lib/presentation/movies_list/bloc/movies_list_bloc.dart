import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../core/services/error_handling/failures.dart';
import '../../../core/services/error_handling/service_errors.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../../domain/usecases/movies/get_movies.dart';

part 'movies_list_event.dart';
part 'movies_list_state.dart';

class MoviesListBloc extends Bloc<MoviesListEvent, MoviesListState> {
  final GetMoviesUseCase getMovies;

  MoviesListBloc({
    required this.getMovies,
  }) : super(MoviesListEmpty()) {
    on<MoviesListEvent>((event, emit) async {
      if (event is MoviesListGetInitialData) {
        emit.call(MoviesListLoading());

        (await getMovies(NoParams())).fold((failure) {
          emit.call(MoviesListError(failure: failure));
        }, (response) {
          if (response.error == noError) {
            emit.call(MoviesListInitialDataLoaded(
                movies: response.movies
                    .map((movie) => MovieEntity().fromModel(movie))
                    .toList()));
          } else {
            emit.call(MoviesListError(
                failure: ServerFailure(errorCode: response.errorCode)));
          }
        });
      } else if (event is MoviesListSetIdle) {
        emit.call(MoviesListIdle());
      }
    });
  }
}
