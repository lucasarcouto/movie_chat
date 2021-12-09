class Movie {
  int date;
  User ;
  String nameSender;
  String runtime;
  String revenue;
  String rating;
  String rank;
  String metascore;
  List<String> genres;
  String director;
  String description;
  List<String> actors;

  Movie(
      {this.year = "",
      this.votes = "",
      this.title = "",
      this.runtime = "",
      this.revenue = "",
      this.rating = "",
      this.rank = "",
      this.metascore = "",
      this.genres = const [],
      this.director = "",
      this.description = "",
      this.actors = const []});

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<dynamic>? listActors = json['actors'];
    List<String> actors = listActors != null ? List.from(listActors) : [];

    return Movie(
      year: json['year'],
      votes: json['votes'],
      title: json['title'],
      runtime: json['runtime'],
      revenue: json['revenue'],
      rating: json['rating'],
      rank: json['rank'],
      metascore: json['metascore'],
      genres: json['genres'] ?? [],
      director: json['director'],
      description: json['description'],
      actors: actors,
    );
  }
}
