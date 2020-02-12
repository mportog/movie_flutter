import 'dart:convert';

import 'package:sity_movies/services/database.dart';
import 'package:sity_movies/models/favorite.dart';

class DbCommand {
  final dbHelper = DatabaseHelper.instance;

  Future<int> inserir(Favorite fav) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: fav.userName,
      DatabaseHelper.columnImdbId: fav.imdbID,
      DatabaseHelper.columnPoster: fav.poster,
      DatabaseHelper.columnTitle: fav.title
    };
    final id = await dbHelper.insert(row);
    return id;
  }

  Future<String> consultarTodas() async {
    final todasLinhas = await dbHelper.queryAllRows();
    todasLinhas.forEach((row) => print(row));
    return json.encode(todasLinhas);
  }

  Future<List<Map>> getFavoriteByName(String name) async {
    final favUser = await dbHelper.getFavoriteByName(name);
    return favUser;
  }

  Future<List<Map>> getLastId() async {
    final favUser = await dbHelper.queryLastId();
    return favUser;
  }

  Future<String> consultarByIdFavs(int id) async {
    final favUser = await dbHelper.queryById(id);
    favUser.forEach((row) => print(row));
    return json.encode(favUser);
  }

  Future<int> countAll() async {
    final id = await dbHelper.queryRowCount();
    return id;
  }

  void deletar(int id) async {
    final linhaDeletada = await dbHelper.delete(id);
  }

}
