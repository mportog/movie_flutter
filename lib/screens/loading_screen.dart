import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sity_movies/screens/welcome_page.dart';
import 'package:sity_movies/services/databasecommands.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    var sql = DbCommand();
    var registros = await sql.getLastId();
    print('registros: $registros');
    var dados;
    if (registros.length == 0)
      dados = null;
    else {
      var id = registros[0]['_id'];
      dados = id > 0 ? json.decode(await sql.consultarByIdFavs(id)) : null;
    }
    await Future.delayed(Duration(
      seconds: 1,
    ));
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WelcomePage(dataUser: dados == null ? "" : dados[0]['name']);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitCubeGrid(color: Colors.deepOrangeAccent, size: 100.0)),
    );
  }
}
