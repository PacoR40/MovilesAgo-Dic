import 'dart:convert';
import 'package:flutter_application_1/models/cast_model.dart';
import 'package:http/http.dart' as http;

class ActorsMovieApi{

  Future<List<Cast>?> getActors(id) async{
    var URL = Uri.parse('https://api.themoviedb.org/3/movie/${id}/credits?api_key=febe7b80e4d0152ebb43c89af42c114c&language=en-MX');

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