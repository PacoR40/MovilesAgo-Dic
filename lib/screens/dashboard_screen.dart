import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_helper.dart';
import 'package:flutter_application_1/firebase/facebook_autentication.dart';
import 'package:flutter_application_1/models/profile_model..dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/firebase/google_autentication.dart';
import 'package:flutter_application_1/models/firebase_user.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //Firebase Autentication
  final FirebaseUser _user = FirebaseUser();
  //Google Autentication
  final AuthServiceGoogle _authServiceGoogle = AuthServiceGoogle();
  //Facebook Autentication
  final FacebookAuthenticator _facebookAuthenticator = FacebookAuthenticator();
  FacebookLogin _objFacebookSignIn = new FacebookLogin();
  var imge;



  DatabaseHelper? _database;
  String correo = "";
  String name = "";
  String photho = "";
  ProfileModel? profileModel;

  @override
  void initState(){
    //getImage();
    super.initState();
    //Obtengo el usuario de Google
    //_user.user(_authServiceGoogle.user);
    _user.user(_facebookAuthenticator.user);
    _database = DatabaseHelper();
  }

  Future<void> getImage() async{
    final img = await _objFacebookSignIn.getProfileImageUrl(width: 100);
    imge = img;
    print(imge);
  }

  Future<void> claarData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('correo');
    prefs.remove('password');
    await prefs.setBool('status', false);
  }

  Future<void> closeSession() async{
    AuthServiceGoogle().signOutGoogle();
    _facebookAuthenticator.signOutFacebook();
    Navigator.pushNamed(context, '/splash');
    //await _authServiceGoogle.signOutGoogle();
  }

  @override
  Widget build(BuildContext context) {

    // final profile = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    // _database!.getProfile(profile['mail']).then((value) => {
    //   if(value != null){
    //     profileModel = value,
    //     correo = value.mail!,
    //     name = value.name!,
    //     photho = value.image!,
    //     //print(photho),
    //     setState(() {},)
    //   }
    // });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).hoverColor,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://static.vecteezy.com/system/resources/previews/006/571/605/original/illustration-of-beautiful-scenery-mountains-in-dark-blue-gradient-color-vector.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              currentAccountPicture:
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(profile: profileModel!)));
                  },
                  child: Hero(
                    tag: 'logo',
                    // child: ClipRRect(
                    //   borderRadius: BorderRadius.circular(35),
                    //   child: Image.file(
                    //     File(photho),
                    //     fit: BoxFit.cover,
                    //     height: 100,
                    //     width: 100,
                    //   ),
                    // ),
                    child: CircleAvatar(              
                      //backgroundImage: NetworkImage('https://i.pinimg.com/736x/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg')
                      backgroundImage: NetworkImage(_user.imageUrl!)
                      //backgroundImage: NetworkImage(imge)
                    ),
                  ),
                ),
              //accountName: Text(name, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              //accountEmail: Text(correo, style: TextStyle(color: Colors.white),),
              accountName: Text(_user.name!, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              accountEmail: Text(_user.email!, style: TextStyle(color: Colors.white),),
            ),
            ListTile(
              //leading: Image.asset('assets/estrella.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Base de datos'),
              onTap: () {
                Navigator.pushNamed(context, '/task');
              },
            ),
            ListTile(
              //leading: Image.asset('assets/estrella.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Popular Movies'),
              onTap: () {
                Navigator.pushNamed(context, '/list');
              },
            ),
            ListTile(
              //leading: Image.asset('assets/estrella.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('About us'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              //leading: Image.asset('assets/estrella.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Places'),
              onTap: () {
                Navigator.pushNamed(context, '/places');
              },
            ),
            ListTile(
              //leading: Image.asset('assets/estrella.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Cerrar Sesion'),
              onTap: () {
                claarData();
                closeSession();
                //Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }

}