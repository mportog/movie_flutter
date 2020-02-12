import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:sity_movies/models/favorite.dart';
import 'package:sity_movies/screens/CustomShape.dart';
import 'package:sity_movies/services/apiData.dart';
import 'package:sity_movies/services/databasecommands.dart';

Color firstColor = Colors.redAccent;
Color secondColor = Colors.deepOrange;

class DetailPage extends StatelessWidget {
  DetailPage({this.movieData, this.userData});

  final String userData;
  final movieData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder(
                  future: _getMovieData(movieData),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Container(
                          width: 200.0,
                          height: 200.0,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.deepOrange),
                            strokeWidth: 5.0,
                          ),
                        );
                      default:
                        if (snapshot.hasError || snapshot.data == null)
                          return Container();
                        else
                          return _movieTable(snapshot);
                    }
                  }),
            ],
          ),
        ),

    );
  }

  Widget _movieTable(AsyncSnapshot snapshot) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: 400.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [firstColor, secondColor],
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Center(
                heightFactor: 1.15,
                child: Card(
                  elevation: 5,
                  child: Hero(
                    tag: snapshot.data.imdbID,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 380,
                          width: 270,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                snapshot.data.poster,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                snapshot.data.title,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                snapshot.data.genre,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.8,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    snapshot.data.year,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    snapshot.data.country,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    snapshot.data.runtime,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Text(
                  snapshot.data.plot,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.local_movies,
                            size: 45,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            ('${snapshot.data.type}' == 'movie'
                                ? 'filme'
                                : 'série'),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.star_border,
                            size: 45,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.data.imdbRating,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              IconButton(
                  icon: Icon(Icons.share),
                  iconSize: 50,
                  onPressed: () {
                    var tipo =
                        snapshot.data.type == 'movie' ? 'filme' : 'série';
                    Share.share(
                        'Saiba mais sobre ${snapshot.data.title}, $tipo  de ${snapshot.data.year}, em: https://www.imdb.com/title/${snapshot.data.imdbID} ');
                  }),
            ],
          ),
        ],
      ),
    );
  }

  Future _getMovieData(String id) async {
    var data;
    if (id != null) data = await DataModel().getMovieDataById(id);
    print('data: $data');
    return data;
  }
}
