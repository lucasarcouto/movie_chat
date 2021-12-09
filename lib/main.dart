import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          case Routes.MOVIES_LIST:
            return MaterialPageRoute(
                builder: (context) => const MoviesListScreen(),
                settings: routeSettings);

          //! Features Presentation
          case Routes.MOVIE_CHAT:
            return MaterialPageRoute(
                builder: (context) => const MovieChatScreen(),
                settings: routeSettings);

          default:
            return MaterialPageRoute(
                builder: (context) => const MoviesListScreen(),
                settings: routeSettings);
        }
      },
    );
  }
}
