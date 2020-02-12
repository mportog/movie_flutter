import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sity_movies/screens/CustomShape.dart';
import 'package:sity_movies/screens/search_page.dart';
import 'package:sity_movies/services/databasecommands.dart';


Color firstColor = Colors.redAccent;
Color secondColor = Colors.deepOrange;

class WelcomePage extends StatefulWidget {
  WelcomePage({this.dataUser});
  final String dataUser;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String name = '' ;
  var sql = new DbCommand();
  final TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    updateUI(widget.dataUser);
  }

  void updateUI(dynamic dataUser) {
    setState(() {
      if (dataUser == null) {
        name = '';
        return;
      }
      name = dataUser;
      _controller.text = name;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          BackgroundScreen(context),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if(name != '' && name != null && name.isNotEmpty){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SearchPage(
              dataModel: name,
            );
          }));}
          else{


          }
        },
        label: Text('Navegar pelos filmes'),
        icon: Icon(Icons.movie_filter),
        backgroundColor: Colors.deepOrangeAccent,
      ),
    );
  }

  //TODO: fazer um widget de layout para reaproveitar
  Widget BackgroundScreen(BuildContext context) {
    return Stack(children: <Widget>[
      ClipPath(
        clipper: CustomShapeClipper(),
        child: Container(
          //TODO:fazer widget aqui HEIGHT
          height: 400.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [firstColor, secondColor],
            ),
          ),
          child: Column(children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            Text(
              'Olá!\n Seja bem vindo\n $name',
              style: TextStyle(
                fontSize: 35.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50.0,
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
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                    BlacklistingTextInputFormatter.singleLineFormatter,
                  ],
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                  },
                  onChanged: (text) {
                    //TODO: mudar para PROVIDER
                    setState(() {
                      name = text;
                    });
                  },
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                    suffixIcon: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.all(
                        Radius.circular(70.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            name = '';
                            _controller.clear();
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(
                              width: 5,
                            ),Text('Trocar'),
                            SizedBox(
                              width: 5,
                            ),
                            Material(
                              elevation: 3.0,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                              child: Icon(
                                Icons.supervisor_account,
                                color: Colors.black,
                              ),
                            ),SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    border: InputBorder.none,
                    hintText: 'Seu nome aqui',
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    ]);
  }
}
