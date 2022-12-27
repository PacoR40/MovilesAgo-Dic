import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/firebase/places_firebase.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({Key? key}) : super(key: key);

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {

  PlacesFirebase? _placesFirebase;

  @override
  void initState() {
    super.initState();
    _placesFirebase = PlacesFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Streambuilder Firebase"),
      ),
      body: StreamBuilder(
        stream: _placesFirebase!.getAllPlaces(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            //return Text(snapshot.data!.docs.first.get('titlePlace'));
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var place = snapshot.data!.docs[index];
                return ListTile(
                  //leading: Image.network(place.get('imgPlace')),
                  title: Text(place.get('titlePlace')),
                  subtitle: Text(place.get('dscPlace')),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton( onPressed: (){}, icon: Icon(Icons.edit) ),
                        IconButton( onPressed: (){
                          _placesFirebase!.delPlace(place.id);
                        }, icon: Icon(Icons.delete) ),
                      ],
                    ),
                    ),
                  
                );
              },
            );
          }else{
            if (snapshot.hasError) {
              return const Center(child: Text('Error'));
            }else{
              return const CircularProgressIndicator();
            }
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context,'addplace') ,
        child: Icon(Icons.add)
      )
     );
  }
}