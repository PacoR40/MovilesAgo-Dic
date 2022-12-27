import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/models/trailer_model.dart';

class MovieTrailerApi{

  Future<List<TrailerModel>?> getTrailer(id) async{
    var URL = Uri.parse('');

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
