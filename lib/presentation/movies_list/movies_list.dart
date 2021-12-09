import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../core/services/localizations/localizations.dart';
import '../../core/services/navigation/navigation_service.dart';
import '../../core/services/navigation/routes.dart';
import '../../core/widgets/custom_flushbar.dart';
import '../../domain/entities/movie_entity.dart';
import '../../injection_container.dart';
import 'bloc/movies_list_bloc.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({Key? key}) : super(key: key);

  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  late BuildContext _currentContext;

  List<MovieEntity> _moviesList = const [];

  double _getPercent(String score) =>
      score.isNotEmpty ? double.parse(score) / 100 : 0;

  void _resolveInitialData(MoviesListInitialDataLoaded state) {
    _moviesList = state.movies;

    BlocProvider.of<MoviesListBloc>(_currentContext).add(MoviesListSetIdle());
  }

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalization.of(context)!;

    return BlocProvider(
      create: (context) => injection<MoviesListBloc>(),
      child: BlocBuilder<MoviesListBloc, MoviesListState>(
        builder: (BuildContext context, MoviesListState state) {
          _currentContext = context;

          if (state is MoviesListEmpty) {
            BlocProvider.of<MoviesListBloc>(context)
                .add(MoviesListGetInitialData());
          } else if (state is MoviesListInitialDataLoaded) {
            _resolveInitialData(state);
          } else if (state is MoviesListError) {
            CustomFlushbar.showDefaultErrorFlushbar(context);
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(_localization.getString(moviesList)),
            ),
            body: state is MoviesListLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SpinKitFadingCube(
                        color: Colors.blueAccent,
                      ),
                      const SizedBox(height: 32),
                      Text(_localization.getString(moviesListLoading),
                          textAlign: TextAlign.center)
                    ],
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircularPercentIndicator(
                          radius: 48.0,
                          lineWidth: 5.0,
                          percent: _getPercent(_moviesList[index].metascore),
                          center: Text(_moviesList[index].metascore.isNotEmpty
                              ? _moviesList[index].metascore
                              : "0"),
                          progressColor: Colors.green,
                        ),
                        title: Text(
                            "${_moviesList[index].title} (${_moviesList[index].year})"),
                        subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(_moviesList[index].description)),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        contentPadding: const EdgeInsets.all(8),
                        onTap: () => injection<NavigationService>()
                            .pushNamed(Routes.MOVIE_CHAT),
                      );
                    },
                    itemCount: _moviesList.length,
                  ),
          );
        },
      ),
    );
  }
}
