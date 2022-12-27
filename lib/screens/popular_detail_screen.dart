import 'package:favorite_button/favorite_button.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_helper.dart';
import 'package:flutter_application_1/models/cast_model.dart';
import 'package:flutter_application_1/models/favorite_model.dart';
import 'package:flutter_application_1/models/popular_model.dart';
import 'package:flutter_application_1/models/trailer_model.dart';
import 'package:flutter_application_1/network/movie_actors_api.dart';
import 'package:flutter_application_1/network/movie_trailer_api.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class PopularDetailScreen extends StatefulWidget {
  final FavoriteDAO? favoriteModel;
  final PopularModel? popularModel;
  const PopularDetailScreen({Key? key, this.favoriteModel, this.popularModel}) : super(key: key);

  @override
  State<PopularDetailScreen> createState() => _PopularDetailScreenState();
}

class _PopularDetailScreenState extends State<PopularDetailScreen> {
  bool favorite = false;
  bool favorite2 = false;
  DatabaseHelper? _database;

  //PopularModel? popularModel;
  MovieTrailerApi? _movieTrailerApi;
  ActorsMovieApi? _actorsMovieApi;
  TrailerModel? trailerModel;
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    _movieTrailerApi = MovieTrailerApi();
    _actorsMovieApi = ActorsMovieApi();
    _database = DatabaseHelper();
    if (widget.favoriteModel != null) {
      favorite = true;
      favorite2 = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //popularModel = ModalRoute.of(context)?.settings.arguments as PopularModel;
    if(!favorite){
      _database!.getFavoriteMovie(widget.popularModel!.id!).then((value) => {
        if(value != null){
          favorite2 = true,

        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        //title: Text('${widget.popularModel!.title}'),
        title: Text((favorite) ? '${widget.favoriteModel!.title}' : '${widget.popularModel!.title}'),
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
      body: Stack(
        children: <Widget>[
          FutureBuilder(
                future: _movieTrailerApi!.getTrailer((favorite) ? widget.favoriteModel!.id_movie.toString() : widget.popularModel!.id.toString() ),
                builder: (BuildContext context, AsyncSnapshot<List<TrailerModel>?> snapshot) {
                  if(snapshot.hasError) {
                    return Center(child: Text("Hay un error"));
                  }else{
                    if (snapshot.connectionState != ConnectionState.done){
                      return CircularProgressIndicator();
                    } else {
                      return _detailsMovie(snapshot.data, context);
                    }
                  }
                },
              ),
                Positioned(
                  
                  //top: MediaQuery.of(context).size.height,
                  child: FutureBuilder(
                        future: _actorsMovieApi!.getActors((favorite) ? widget.favoriteModel!.id_movie.toString() : widget.popularModel!.id.toString() ),
                        builder: (BuildContext context, AsyncSnapshot<List<Cast>?> snapshot2){
                          if(snapshot2.hasError)
                            return Center(
                              child: Text('Error al recuperar los actores', style: TextStyle(color: Colors.red),),
                            );
                          else{
                            if (snapshot2.connectionState != ConnectionState.done)
                              return Center(child: CircularProgressIndicator());
                            else{
                              return _listActors(snapshot2.data!);
                            }
                          }
                        },
                      ),
                )
        ],
              
        
      ),
    );
  }

  Widget _detailsMovie(List<TrailerModel>? trailer, BuildContext context){

    for (var i = 0; i < trailer!.length; i++) {
      if (trailer[i].type == 'Trailer') {
        trailerModel = trailer[i];
      }
    }

    controller = YoutubePlayerController.fromVideoId(
              videoId: trailerModel!.key!.toString(),
              params: YoutubePlayerParams(
                showControls: true,
                showFullscreenButton: true
              )
    );

    return Container(
          padding: EdgeInsets.only(
            top: 10
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: .8,
              image: NetworkImage('https://image.tmdb.org/t/p/w500/${(favorite) ? widget.favoriteModel!.posterPath : widget.popularModel!.posterPath}'),
              fit: BoxFit.cover
            ),
          ),
          child: ListView(
            children: [
              Container(
                height: 210,
                margin: EdgeInsets.all(10), // Del contenedor hacia afuera
                child: YoutubePlayer(
                  controller: controller,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FavoriteButton(
                          isFavorite: favorite2,
                          iconColor: Colors.pink,
                          iconDisabledColor: Colors.white,
                          valueChanged: (_isFavorited){
                            if(!_isFavorited){
                              _database!.eliminarFavMovie((favorite) ? widget.favoriteModel!.id_movie! : widget.popularModel!.id! , 'tblMovieFav').then((value) {
                                final snackBar = 
                                  SnackBar(content: Text("Pelicula eliminada de favoritos"));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              });
                            }else{
                              _database!.insertar({
                                'id_movie': (favorite) ? widget.favoriteModel!.id_movie :  widget.popularModel!.id,
                                'title' : (favorite) ? widget.favoriteModel!.title : widget.popularModel!.title,
                                'overview' : (favorite) ? widget.favoriteModel!.overview : widget.popularModel!.overview,
                                'posterPath' : (favorite) ? widget.favoriteModel!.posterPath : widget.popularModel!.posterPath,
                                'backdropPath' : (favorite) ? widget.favoriteModel!.backdropPath : widget.popularModel!.backdropPath,
                                'voteAverage' : (favorite) ? widget.favoriteModel!.voteAverage : widget.popularModel!.voteAverage,
                              },'tblMovieFav').then((value) {
                                final snackBar = 
                                  SnackBar(content: Text("Pelicula añadida a favoritos"));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              });
                            }
                          }
                        ),
                        RatingBarIndicator(
                          rating: (favorite) ? widget.favoriteModel!.voteAverage! / 2 : widget.popularModel!.voteAverage! / 2,
                          itemSize: 35,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: .1),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20), //Del contenedor para adentro
                margin: EdgeInsets.all(10), // Del contenedor hacia afuera
                child: Text(
                  '${(favorite) ? widget.favoriteModel!.overview : widget.popularModel!.overview}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.7),
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              // Container(
              //   width: 200,
              //   padding: EdgeInsets.all(60), //Del contenedor para adentro
              //   //margin: EdgeInsets.all(10), // Del contenedor hacia afuera
              //   child: Text(
              //     'Aqui van los actores',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 15,
              //     ),
              //     textAlign: TextAlign.justify,
              //   ),
              //   decoration: BoxDecoration(
              //     color: Colors.black.withOpacity(.7),
              //     borderRadius: BorderRadius.circular(20)
              //   ),
              // ),
            ],
          ),
        );
  }

  Widget _listActors(List<Cast> actors){
    return Container(
      //color: Colors.blue,
      //margin: EdgeInsets.fromLTRB(0, 500, 0, 0),
      margin: EdgeInsets.only(
        top: 570
      ),
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          Cast cast = actors[index];
          return Container(
            margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
            child: Column(
              children: [
                (cast.profilePath != null) ?
                CircleAvatar(                  
                  backgroundImage: NetworkImage("https://image.tmdb.org/t/p/w500/${cast.profilePath}"),
                  backgroundColor: Colors.blue,
                  radius: 30,
                ):
                CircleAvatar(                  
                  backgroundImage: NetworkImage('https://i.pinimg.com/736x/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg'),
                  backgroundColor: Colors.blue,
                  radius: 30,
                ),
                SizedBox(height: 10,),
                Text(
                  cast.name!,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )
              ],
            ),
          );
        }),
        itemCount: actors.length,
      ),
    );
  }

}