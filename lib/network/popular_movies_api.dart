import 'dart:convert';

import 'package:flutter_application_1/models/popular_model.dart';
import 'package:http/http.dart' as http;

class PopularMoviesAPI {
  final URL = '';

  Future<List<PopularModel>?> getAllPopular() async{
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode ==200 ){
      var popular = jsonDecode(response.body)['results'] as List;
      List<PopularModel> listPopular = popular.map((movie) => PopularModel.fromJSON(movie)).toList();
      return listPopular;
    }else {
      return null;
    }
  }
}
