import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/trailer_model.dart';

class MovieTrailerApi{

  Future<List<TrailerModel>?> getTrailer(id) async{
    var URL = Uri.parse('https://api.themoviedb.org/3/movie/${id}/videos?api_key=febe7b80e4d0152ebb43c89af42c114c&language=en-MX');

    final response = await http.get(URL);
    if(response.statusCode == 200){
      var trailers = jsonDecode(response.body)['results'] as List;
      List<TrailerModel> listTrailer = trailers.map((trailer) => TrailerModel.fromJSON(trailer)).toList();
      return listTrailer;
    }else{
      return null;
    }
  }
}