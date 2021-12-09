import 'package:get_it/get_it.dart';

final injection = GetIt.instance;

Future<void> init() async {
  //!====================================================
  //! Services
  //!====================================================
  //* AppLocalization
  // injection.registerLazySingleton(() => AppLocalization.of(
  //     injection<NavigationService>().navigatorKey.currentContext));

  //* NavigationService
  // injection.registerLazySingleton(() => NavigationService());

  //!====================================================
  //! Data
  //!====================================================
  //* Repositories
  // injection
  //     .registerLazySingleton<AccountRepository>(() => AccountRepositoryImpl(
  //           remoteDataSource: injection(),
  //         ));

  //* Data sources
  //* --- Remote
  // injection.registerLazySingleton<AccountRemoteDataSource>(
  //     () => AccountRemoteDataSourceImpl());

  //!====================================================
  //! Domain
  //!====================================================
  //* Account
  // injection.registerLazySingleton(() => AcceptNewTermsUseCase(injection()));

  //!====================================================
  //! Presentation
  //!====================================================
  //* Splash Screen
  // injection.registerFactory(() => SplashScreenBloc(
  //       isUserLoggedIn: injection(),
  //       getInt: injection(),
  //       putInt: injection(),
  //     ));

  //!====================================================
  //! Core
  //!====================================================
  // injection
  //     .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(injection()));
}
