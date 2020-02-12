import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:sity_movies/models/favorite.dart';
import 'package:sity_movies/screens/CustomShape.dart';
import 'package:sity_movies/screens/details_page.dart';
import 'package:sity_movies/screens/favorites_page.dart';
import 'package:sity_movies/services/apiData.dart';
import 'package:sity_movies/services/databasecommands.dart';
import 'package:fluttertoast/fluttertoast.dart';

Color firstColor = Colors.redAccent;
Color secondColor = Colors.deepOrange;

class SearchPage extends StatefulWidget {
  SearchPage({this.dataModel});

  final String dataModel;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _search = '';
  bool firstSearch = false;
  bool isMovie = true;
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          BackgroundScreen(context),
          if (firstSearch) BuildResults(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FavoritesPage(userData: widget.dataModel);
          }));
        },
        child: Icon(Icons.favorite_border),
        backgroundColor: Colors.redAccent,
      ),
    );
  }



  Widget BackgroundScreen(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 200.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [firstColor, secondColor],
              ),
            ),
            child: Column(children: <Widget>[
              SizedBox(
                height: 60.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  child: TextField(
                    controller: _controller,
                    onChanged: (text) {
                      _search = text;
                    },
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 14.0),
                      suffixIcon: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus)
                              currentFocus.unfocus();
                            setState(() {
                              firstSearch = true;
                            });
                            _controller.clear();
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      border: InputBorder.none,
                      hintText: 'Pesquisar Filmes OMDB',
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.navigate_before),
                    onPressed: () {
                      setState(() {
                        _nextPage(false);

                      });
                    },
                    iconSize: 50,
                  ),
                  FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(
                            color: isMovie ? Colors.red : Colors.green)),
                    color: isMovie ? Colors.red : Colors.white,
                    textColor: isMovie ? Colors.white : Colors.red,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {
                      setState(() {
                        isMovie = false;
                        print('isMovie: $isMovie');

                      });
                    },
                    child: Text(
                      "Séries",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(
                            color: isMovie ? Colors.green : Colors.red)),
                    onPressed: () {
                      setState(() {
                        isMovie = true;
                        print('isMovie: $isMovie');
                      });
                    },
                    color: isMovie ? Colors.white : Colors.red,
                    textColor: isMovie ? Colors.red : Colors.white,
                    child: Text("Filmes", style: TextStyle(fontSize: 14)),
                  ),
                  IconButton(
                    icon: Icon(Icons.navigate_next),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        _nextPage(true);
                      });
                    },
                    iconSize: 50,
                  ),
                ],
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
          future: _getMovieList(_search, isMovie, _page),
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
    return GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Image.network(
              snapshot.data[index]["Poster"] != "N/A"
                  ? snapshot.data[index]["Poster"]
                  : "https://www.amulyamica.com/files/noimage.jpg",
            ),
            onTap: () {
              var detail = snapshot.data[index]['imdbID'];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(movieData: detail)));
            },
            onLongPress: () {
              Share.share(
                  'Olha só ${isMovie ? 'esse filme' : 'essa série'} que encontrei, vamos ver juntos ? Pesquise aí, chama : ${snapshot.data[index]["Title"]}');
            },
            onDoubleTap: () {
              _saveData(snapshot.data[index], widget.dataModel);
            },
          );
        });
  }
}

void _nextPage(bool next) {
  if (_page < 100 && _page > 0) next ? _page++ : _page--;
  print('next: $next');
}
int _page = 1;
String _lastSearch = '';
bool _lastType=false;

Future _getMovieList(String text, bool toggle, int page) async {
  var response;
  if (_lastSearch != text || _lastType != toggle) page = 1;
  if (text != null && text.isNotEmpty) text = text.trim().replaceAll(' ', '+');
  response = await DataModel().getMovieSearchData(text, page, isMovie: toggle);
  _lastSearch = text;
  _lastType = toggle;
  _page = page;
  return response;
}

void _saveData(Object imdbId, String name) async {
  Favorite fav = Favorite.fromMap(imdbId);
  print('fav: $fav');
  var value = _insertFavorite(fav, name);
  String message = value != 0 || value != null
      ? "${fav.title} adicionado aos favoritos"
      : "Não foi possivel adicionar ${fav.title} aos favoritos";
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.deepOrangeAccent,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future<int> _insertFavorite(Favorite fav, String name) async {
  var sql = DbCommand();
  var dataCount = await sql.countAll();
  fav.id = dataCount + 1;
  fav.userName = name;
  var linhaAdd = await sql.inserir(fav);
  return linhaAdd;
}
