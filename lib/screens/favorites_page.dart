import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sity_movies/models/favorite.dart';
import 'package:sity_movies/screens/CustomShape.dart';
import 'package:sity_movies/screens/details_page.dart';
import 'package:sity_movies/screens/search_page.dart';
import 'package:sity_movies/services/databasecommands.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({this.userData});

  final String userData;

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String name = '';

  final Color firstColor = Colors.redAccent;
  final Color secondColor = Colors.deepOrange;
  final Color discountBackgroundColor = Color(0xFFFFE08D);

  final Color flightBorderColor = Color(0xFFE6E6E6);
  final Color chipBackgroundColor = Color(0xFFF6F6F6);

  String updateUI(dynamic dataUser) {
    if (dataUser == null) return name = '';
    return name = 'Olá $dataUser, aqui estão seus filmes favoritados';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
            children: <Widget>[
              BackgroundScreen(),
              BuildResults(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage(dataModel: widget.userData);
              }));
            },
            child: Icon(Icons.search),
            backgroundColor: Colors.blueAccent,
          ),

    );
  }

  Widget BackgroundScreen() {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 280.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [firstColor, secondColor],
              ),
            ),
            child: Column(children: <Widget>[
              SizedBox(
                height: 75.0,
              ),
              Text(
                updateUI(widget.userData),
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget BuildResults() {
    return Expanded(
      child: FutureBuilder(
          future: _popularListaFavoritos(widget.userData),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Container(
                  width: 200.0,
                  height: 200.0,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                    strokeWidth: 5.0,
                  ),
                );
              default:
                if (snapshot.hasError || snapshot.data == null)
                  return Container();
                else
                  return _movieTable(context, snapshot);
            }
          }),
    );
  }

  Widget _movieTable(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 10.0),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
            background: Container(
              color: Colors.red,
              child: Align(
                alignment: Alignment(-0.9, 0.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            direction: DismissDirection.startToEnd,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GestureDetector(
                onTap: () {
                  var id = snapshot.data[index]['imdbId'];
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailPage(
                      movieData: id,
                    );
                  }));
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 0, 16.0, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        border: Border.all(color: flightBorderColor),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 100.0,
                            height: 150.0,
                            child: Image.network(
                                '${snapshot.data[index]['poster']}'),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${snapshot.data[index]['title']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onDismissed: (direction) {
              setState(
                () {
                  var idBanco = snapshot.data[index]['_id'];
                  var titulo = snapshot.data[index]['title'];
                  _deleteFavorite(idBanco);
                  final snack = SnackBar(
                    content: Text("Favorito $titulo removido!"),
                    duration: Duration(seconds: 1),
                  );
                  Scaffold.of(context).removeCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(snack);
                },
              );
            },
          );
        });
  }

  Future<void> _deleteFavorite(dynamic id) async {
    var sql = DbCommand();
    sql.deletar(id);
  }

  Future<Null> _waitForaWhile() async {
    await Future.delayed(Duration(seconds: 1));
  }

  Future _popularListaFavoritos(String nome) async {
    _waitForaWhile();
    var sql = DbCommand();
    var res = sql.getFavoriteByName(nome); //busca lista do banco
    return res;
  }
}
