import 'package:get_it/get_it.dart';

import 'core/services/navigation/navigation_service.dart';
import 'data/datasources/local/preferences_local_data_source.dart';
import 'data/datasources/remote/chat_messages_remote_data_source.dart';
import 'data/datasources/remote/movies_remote_data_source.dart';
import 'data/repositories/chat_messages_repository_impl.dart';
import 'data/repositories/movies_repository_impl.dart';
import 'data/repositories/preferences_repository_impl.dart';
import 'domain/repositories/chat_messages_repository.dart';
import 'domain/repositories/movies_repository.dart';
import 'domain/repositories/preferences_repository.dart';
import 'domain/usecases/chat_messages/get_all.dart';
import 'domain/usecases/chat_messages/upsert.dart';
import 'domain/usecases/movies/get_movies.dart';
import 'domain/usecases/preferences/get_string.dart';
import 'domain/usecases/preferences/put_string.dart';
import 'presentation/authentication/bloc/authentication_bloc.dart';
import 'presentation/movie_chat/bloc/movie_chat_bloc.dart';
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
  injection.registerLazySingleton<ChatMessagesRepository>(
      () => ChatMessagesRepositoryImpl(
            remoteDataSource: injection(),
          ));
  injection.registerLazySingleton<MoviesRepository>(() => MoviesRepositoryImpl(
        remoteDataSource: injection(),
      ));
  injection.registerLazySingleton<PreferencesRepository>(
      () => PreferencesRepositoryImpl(
            localDataSource: injection(),
          ));

  //* Data sources
  //* --- Local
  injection.registerLazySingleton<PreferencesLocalDataSource>(
      () => PreferencesLocalDataSourceImpl());
  //* --- Remote
  injection.registerLazySingleton<ChatMessagesRemoteDataSource>(
      () => ChatMessagesRemoteDataSourceImpl());
  injection.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImpl());

  //!====================================================
  //! Domain
  //!====================================================
  //* Chat Messages
  injection.registerLazySingleton(() => GetAllChatMessagesUseCase(injection()));
  injection.registerLazySingleton(() => UpsertChatMessageUseCase(injection()));

  //* Movies
  injection.registerLazySingleton(() => GetMoviesUseCase(injection()));

  //* Preferences
  injection
      .registerLazySingleton(() => PreferencesGetStringUseCase(injection()));
  injection
      .registerLazySingleton(() => PreferencesPutStringUseCase(injection()));

  //!====================================================
  //! Presentation
  //!====================================================
  //* Authentication
  injection.registerFactory(() => AuthenticationBloc(
        putString: injection(),
      ));

  //* MoviesList
  injection.registerFactory(() => MoviesListBloc(
        getMovies: injection(),
      ));

  //* MovieChat
  injection.registerFactory(() => MovieChatBloc(
        getString: injection(),
        getAllMessages: injection(),
        upsertChatMessage: injection(),
      ));
}
