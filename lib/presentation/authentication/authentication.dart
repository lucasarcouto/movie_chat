import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/services/localizations/localizations.dart';
import '../../core/services/navigation/navigation_service.dart';
import '../../core/services/navigation/routes.dart';
import '../../core/utils/assets_consts.dart';
import '../../core/widgets/custom_flushbar.dart';
import '../../domain/entities/user_entity.dart';
import '../../injection_container.dart';
import 'bloc/authentication_bloc.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalization.of(context)!;

    return BlocProvider(
      create: (context) => injection<AuthenticationBloc>(),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationUserUpserted) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              injection<NavigationService>()
                  .pushReplacementNamed(Routes.moviesList);
            });
          } else if (state is AuthenticationError) {
            CustomFlushbar.showDefaultErrorFlushbar(context);
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationSetIdle());
          }

          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      assetAuthBackground,
                      fit: BoxFit.fill,
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  _localization.getString(welcomeMovieChat),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                const SizedBox(height: 24),
                                TextField(
                                  decoration: InputDecoration(
                                    hintText:
                                        _localization.getString(whatsYourName),
                                    hintStyle:
                                        const TextStyle(color: Colors.white38),
                                    border: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                  ),
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.words,
                                  style: const TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                  controller: _controller,
                                ),
                                const SizedBox(height: 8),
                                TextButton(
                                  child: Text(_localization
                                      .getString(signIn)
                                      .toUpperCase()),
                                  onPressed: () {
                                    if (_controller.text.isNotEmpty) {
                                      BlocProvider.of<AuthenticationBloc>(
                                              context)
                                          .add(AuthenticationUpsertUser(
                                              UserEntity(
                                                  name: _controller.text
                                                      .trim())));
                                    } else {
                                      CustomFlushbar.showErrorFlushbar(
                                          context,
                                          _localization
                                              .getString(errorEmptyName));
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
