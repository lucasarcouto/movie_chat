import 'dart:convert';

import 'package:http/http.dart';

import '../../../../data/models/movie.dart';
import '../../error_handling/service_errors.dart';
import 'movies_response.dart';

const moviesListURL =
    'https://tender-mclean-00a2bd.netlify.app/mobile/movies.json';

class MoviesService {
  static Future<MoviesResponse> getMovies() async {
    try {
      Response response = await _getJson();

      MoviesResponse serviceResponse =
          MoviesResponse(error: noError, errorCode: -1, movies: const []);

      if (response.statusCode == 200) {
        List<dynamic> arrayResponse = jsonDecode(response.body);

        if (arrayResponse.isEmpty) {
          serviceResponse.error = errorServer;
          serviceResponse.errorCode = response.statusCode;
        } else {
          serviceResponse.error = noError;
        }
        serviceResponse.movies =
            arrayResponse.map((json) => Movie.fromJson(json)).toList();
      } else {
        serviceResponse.error = errorCommunication;
      }

      return serviceResponse;
    } catch (ex) {
      return MoviesResponse(error: localError, errorCode: -1, movies: const []);
    }
  }

  static Future<Response> _getJson() async {
    try {
      return get(Uri.parse(moviesListURL));
    } catch (ex) {
      return Response("", -1);
    }
  }
}
