
import 'dart:convert';

class Favorite{
   int id;
   String userName;
   String title;
   String poster;
   String imdbID;

  Favorite({this.id, this.userName, this.title, this.poster, this.imdbID});

  Favorite.fromMap(Map<String, dynamic> json)
      : title = json['Title'],
        poster = json['Poster'],
        imdbID = json['imdbID'],
        id= json['id'],
        userName = json['userName'];

  Map<String, dynamic> toMap() =>
      {
        'Title': title,
        'Poster': poster,
        'imdbID': imdbID,
        'id': id,
        'userName': userName
      };

   Favorite favoriteFromJson(String str) {
     final jsonData = json.decode(str);
     return Favorite.fromMap(jsonData);
   }

   String favoriteToJson(Favorite data) {
     final dyn = data.toMap();
     return json.encode(dyn);
   }
}