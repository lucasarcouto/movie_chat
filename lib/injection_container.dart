import 'package:get_it/get_it.dart';

import 'core/services/navigation/navigation_service.dart';
import 'data/datasources/remote/movies_remote_data_source.dart';
import 'data/repositories/movies_repository_impl.dart';
import 'domain/repositories/movies_repository.dart';
import 'domain/usecases/movies/get_movies.dart';
import 'presentation/movies_list/bloc/movies_list_bloc.dart';

final injection = GetIt.instance;

Future<void> init() async {
  //!====================================================
  //! Services
  //!====================================================
  //* NavigationService
  injection.registerLazySingleton(() => NavigationService());

  //!====================================================
  //! Data
  //!====================================================
  //* Repositories
  injection.registerLazySingleton<MoviesRepository>(() => MoviesRepositoryImpl(
        remoteDataSource: injection(),
      ));

  //* Data sources
  //* --- Remote
  injection.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImpl());

  //!====================================================
  //! Domain
  //!====================================================
  //* Account
  injection.registerLazySingleton(() => GetMoviesUseCase(injection()));

  //!====================================================
  //! Presentation
  //!====================================================
  //* Splash Screen
  injection.registerFactory(() => MoviesListBloc(
        getMovies: injection(),
      ));
}
