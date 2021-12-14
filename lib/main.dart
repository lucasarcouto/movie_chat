import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'domain/entities/movie_entity.dart';
import 'presentation/authentication/authentication.dart';

import 'core/services/localizations/localizations.dart';
import 'core/services/navigation/navigation_service.dart';
import 'core/services/navigation/routes.dart';
import 'injection_container.dart' as di;
import 'presentation/movie_chat/movie_chat.dart';
import 'presentation/movies_list/movies_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init Firebase
  await Firebase.initializeApp();

  // Init Dependency Injection
  await di.init();

  // Run Application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Activite Personal',
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      //! Navigation
      navigatorKey: di.injection<NavigationService>().navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (routeSettings) {
        switch (routeSettings.name) {
          //! Authentication
          case Routes.authentication:
            return MaterialPageRoute(
                builder: (context) => const AuthenticationScreen(),
                settings: routeSettings);

          //! Movie Chat
          case Routes.moviesList:
            return MaterialPageRoute(
                builder: (context) => const MoviesListScreen(),
                settings: routeSettings);

          //! Movie Chat
          case Routes.movieChat:
            return MaterialPageRoute(
                builder: (context) => MovieChatScreen(
                    movie: routeSettings.arguments != null &&
                            routeSettings.arguments is MovieEntity
                        ? routeSettings.arguments as MovieEntity
                        : MovieEntity()),
                settings: routeSettings);

          default:
            return MaterialPageRoute(
                builder: (context) => const AuthenticationScreen(),
                settings: routeSettings);
        }
      },
    );
  }
}
