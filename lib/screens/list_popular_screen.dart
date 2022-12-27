import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/popular_model.dart';
import 'package:flutter_application_1/network/popular_movies_api.dart';
import 'package:flutter_application_1/screens/popular_detail_screen.dart';

class ListPopularScreen extends StatefulWidget {
  const ListPopularScreen({Key? key}) : super(key: key);

  @override
  State<ListPopularScreen> createState() => _ListPopularScreenState();
}

class _ListPopularScreenState extends State<ListPopularScreen> {

  PopularMoviesAPI popularAPI = PopularMoviesAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular Movies'),
      actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.pink,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/favMovie');
              },
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
      ),
      body: FutureBuilder(
        future: popularAPI.getAllPopular(),
        builder: (BuildContext context, AsyncSnapshot<List<PopularModel>?> snapshot){
          if(snapshot.hasData)
            return _listViewPopular(snapshot.data);
          else
            if( snapshot.hasError )
              return Center(child: Text('Ocurrio un error en la peticion'));
            else
              return Center(
                child: CircularProgressIndicator(),
              );
        },
      ),
    );
  }

  Widget _listViewPopular(List<PopularModel>? snapshot) {
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
                    // onTap: () => Navigator.popAndPushNamed(
                    //   context,
                    //   '/detail',
                    //   arguments:
                    //     snapshot[index],
                    //   ),
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(profile: profileModel!)));
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PopularDetailScreen(popularModel: snapshot[index] as PopularModel),),),
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