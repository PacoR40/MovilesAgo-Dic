import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_helper.dart';
import 'package:flutter_application_1/models/popular_model.dart';
import 'package:flutter_application_1/screens/popular_detail_screen.dart';
import '../models/favorite_model.dart';

class ListFavoritesMovies extends StatefulWidget {
  const ListFavoritesMovies({Key? key}) : super(key: key);

  @override
  State<ListFavoritesMovies> createState() => _ListFavoritesMoviesState();
}

class _ListFavoritesMoviesState extends State<ListFavoritesMovies> {

  DatabaseHelper? _database;

  @override
  void initState() {
    super.initState();
    _database = DatabaseHelper();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
        leading: Row(
            children: <Widget>[
              //SizedBox(width: 8.0),
              IconButton(
                color: Colors.white,
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
      ),
      body: FutureBuilder(
        future: _database!.getFavoritesMovies(),
        builder: (BuildContext context, AsyncSnapshot<List<FavoriteDAO>?> snapshot) {
          if( snapshot.hasError )
            return Center(
              child: Text('Ocurrio un error')
            );
            else{
              if (snapshot.data == null){
                return Center(
                  child: Text('No tienes peliculas favoritas'),
                );
              }else{
                return _listViewPopular(snapshot.data);
              }
            }
          }
      ),
    );
  }

  Widget _listViewPopular(List<FavoriteDAO>? snapshot) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(color: Colors.black,),
      padding: EdgeInsets.all(10),
      itemCount: snapshot!.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                FadeInImage(
                  fadeInDuration: Duration(milliseconds: 500),
                  placeholder: AssetImage('assets/loading_image.gif'),
                  image: NetworkImage('https://image.tmdb.org/t/p/w500/${snapshot[index].backdropPath!}'),
                ),
                Container(
                  color: Colors.black.withOpacity(.6),
                  height: 60,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PopularDetailScreen(favoriteModel: snapshot[index] as FavoriteDAO),),);
                    },
                    title: Text('${snapshot[index].title}',
                    style: TextStyle(color: Colors.white)
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 30,
                      ),
                  ),
                )
              ],
            ),
        );
      },
    );
  }
}