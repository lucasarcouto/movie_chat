class User {
  String name;

  User({this.name = ""});

  factory User.fromJson(Map<String, dynamic> json) {
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
