import '../../data/models/movie.dart';

class MovieEntity extends Movie {
  MovieEntity(
      {String year = "",
      String votes = "",
      String title = "",
      String runtime = "",
      String revenue = "",
      String rating = "",
      String rank = "",
      String metascore = "",
      List<String> genres = const [],
      String director = "",
      String description = "",
      List<String> actors = const []}) {
    this.year = year;
    this.votes = votes;
    this.title = title;
    this.runtime = runtime;
    this.revenue = revenue;
    this.rating = rating;
    this.rank = rank;
    this.metascore = metascore;
    this.genres = genres;
    this.director = director;
    this.description = description;
    this.actors = actors;
  }
}

extension MovieParsing on MovieEntity {
  MovieEntity fromModel(Movie? model) => MovieEntity(
        year: model != null ? model.year : "",
        votes: model != null ? model.votes : "",
        title: model != null ? model.title : "",
        runtime: model != null ? model.runtime : "",
        revenue: model != null ? model.revenue : "",
        rating: model != null ? model.rating : "",
        rank: model != null ? model.rank : "",
        metascore: model != null ? model.metascore : "",
        genres: model != null ? model.genres : [],
        director: model != null ? model.director : "",
        description: model != null ? model.description : "",
        actors: model != null ? model.actors : [],
      );
}
