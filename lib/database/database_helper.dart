import 'dart:io';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/models/favorite_model.dart';
import 'package:flutter_application_1/models/profile_model..dart';
import 'package:flutter_application_1/models/tareas_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // static final nombreBD = 'TAREASBD';
  // static final versionBD = 1;
  // static final nombreBD = 'PROFILEBD';
  // static final versionBD = 2;
  static final nombreBD = 'FavoriteMov';
  static final versionBD = 6;

  static Database? _database;
  Future<Database> get database async{
    if(_database != null) return _database!;
    return _database = await _initDatabase();
  }

  _initDatabase() async{
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaBD = join(carpeta.path, nombreBD);
    return await openDatabase(
      rutaBD,
      version: versionBD,
      onCreate: _crearTablas
    );
  }

  _crearTablas(Database db, int version) async{
    String queryProfile = "CREATE TABLE tblProfile(idProfile INTEGER PRIMARY KEY, image VARCHAR(5000), name VARCHAR(300), mail VARCHAR(100), number VARCHAR(100), github VARCHAR(100) )";
    String queryTareas = "CREATE TABLE tblTareas(idTarea INTEGER PRIMARY KEY, decTarea VARCHAR(100), fechaEnt DATE)";
    String queryMovieFavorite = "CREATE TABLE tblMovieFav(id INTEGER PRIMARY KEY, id_movie INTEGER, title VARCHAR(100), overview VARCHAR(500), posterPath VARCHAR(500), backdropPath VARCHAR(500), voteAverage REAL )";
    db.execute(queryProfile);
    db.execute(queryTareas);
    db.execute(queryMovieFavorite);
  }

  _crearTablaProfile(Database db, int version) async{
    String query = "CREATE TABLE tblProfile(idProfile INTEGER PRIMARY KEY, image VARCHAR(5000), name VARCHAR(300), mail VARCHAR(100), number VARCHAR(100), github VARCHAR(100) )";
    db.execute(query);
  }

  Future<int> insertar(Map<String, dynamic> row, String nomTabla) async{
    var conexion = await database;
    return await conexion.insert(nomTabla, row);
  }


  ////////----------------------- TAREAS ---------------------------------
  Future<int> actualizar(Map<String,dynamic> row, String nomTabla)async{
    var conexion = await database;
    return await conexion.update(nomTabla, row, where: 'idTarea = ?', whereArgs: [row['idTarea']]);
  }

  Future<int> eliminar (int idTarea, String nomTabla) async{
    var conexion = await database;
    return await conexion.delete(nomTabla, where: "idTarea = ?", whereArgs: [idTarea]);
  }

  Future<List<TareasDAO>> getAllTareas () async{
    var conexion = await database;
    var result = await conexion.query('tblTareas');
    return result.map((mapTarea) => TareasDAO.fromJSON(mapTarea)).toList();
  }

  //---------------------- PROFILE -------------------------------------------
  Future<int> actualizarProfile(Map<String,dynamic> row, String nomTabla)async{
    var conexion = await database;
    return await conexion.update(nomTabla, row, where: 'idProfile = ?', whereArgs: [row['idProfile']]);
  }

  Future<int> eliminarProfile (int idProfile, String nomTabla) async{
    var conexion = await database;
    return await conexion.delete(nomTabla, where: "idProfile = ?", whereArgs: [idProfile]);
  }

  Future<ProfileModel?> getProfile (String mail) async{
    var conexion = await database;
    var result = await conexion.query('tblProfile', where: 'mail = ?', whereArgs: [mail]);
    var lista = result.map((resultJSON) => ProfileModel.fromJSON(resultJSON)).toList();

    return lista.length > 0 ? lista[0] : null;
    //return result.map((result) => ProfileDAO.fromJSON(result)).toList();
  }

  //------------------------------ FAV MOVIES -----------------------------------

Future<FavoriteDAO?> getFavoriteMovie (int id_movie) async {
  var conexion = await database;
  var result = await conexion.query('tblMovieFav', where: "id_movie = ?", whereArgs: [id_movie]);
  var lista = result.map((item) => FavoriteDAO.fromJSON(item)).toList();
  return lista.length > 0 ? lista[0] : null;
}

Future<List<FavoriteDAO>?> getFavoritesMovies() async{
  var conexion = await database;
  var result = await conexion.query('tblMovieFav');
  var lista = result.map((item) => FavoriteDAO.fromJSON(item)).toList();
  return lista.length > 0 ? lista : null;
}

Future<int> eliminarFavMovie (int id_movie, String nomTabla) async{
    var conexion = await database;
    return await conexion.delete(nomTabla, where: "id_movie = ?", whereArgs: [id_movie]);
  }

Future<List<TareasDAO>> getAllFavorites () async{
    var conexion = await database;
    var result = await conexion.query('tblMovieFav');
    return result.map((mapTarea) => TareasDAO.fromJSON(mapTarea)).toList();
  }
  
}