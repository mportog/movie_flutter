class Movie {
  String title;
  String year;
  String rated;
  String released;
  String runtime;
  String genre;
  String director;
  String actors;
  String plot;
  String country;
  String awards;
  String poster;
  String imdbRating;
  String imdbID;
  String type;
  String production;

  String Response;
  String Website;
  String BoxOffice;
  String DVD;
  String imdbVotes;
  String Metascore;
  String Language;
  String Writer;
  String Director;

  Movie.fromJson(Map<String, dynamic> json)
      : title = json['Title'],
        year = json['Year'],
        rated = json['Rated'],
        released = json['Released'],
        runtime = json['Runtime'],
        genre = json['Genre'],
        director = json['Director'],
        actors = json['Actors'],
        plot = json['Plot'],
        country = json['Country'],
        awards = json['Awards'],
        poster = json['Poster'],
        imdbRating = json['imdbRating'],
        imdbID = json['imdbID'],
        type = json['Type'],
        production = json['Production'],
        Response = json['Response'],
        Website = json['Website'],
        BoxOffice = json['BoxOffice'],
        DVD = json['DVD'],
        imdbVotes = json['imdbVotes'],
        Metascore = json['Metascore'],
        Language = json['Language'],
        Writer = json['Writer'],
        Director = json['Director'];

  Map<String, dynamic> toJson() => {
        'Title': title,
        'Year': year,
        'Rated': rated,
        'Released': released,
        'Runtime': runtime,
        'Genre': genre,
        'Director': director,
        'Actors': actors,
        'Plot': plot,
        'Country': country,
        'Awards': awards,
        'Poster': poster,
        'imdbRating': imdbRating,
        'imdbID': imdbID,
        'Type': type,
        'Production': production,
        'Response': Response,
        'Website': Website,
        'BoxOffice': BoxOffice,
        'DVD': DVD,
        'imdbVotes': imdbVotes,
        'Metascore': Metascore,
        'Language': Language,
        'Writer': Writer,
        'Director': Director,
      };
}
