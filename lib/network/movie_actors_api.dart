import 'dart:convert';
import 'package:flutter_application_1/models/cast_model.dart';
import 'package:http/http.dart' as http;

class ActorsMovieApi{

  Future<List<Cast>?> getActors(id) async{
    var URL = Uri.parse('');

    final response = await http.get(URL);
    if(response.statusCode == 200){
      var actors = jsonDecode(response.body)['cast'] as List;
      List<Cast> listActors = actors.map((actor) => Cast.fromJSON(actor)).toList();
      return listActors;
    }else{
      return null;
    }
  }
}
