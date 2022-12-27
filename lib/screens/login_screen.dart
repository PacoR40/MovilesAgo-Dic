import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/email_authentication.dart';
import 'package:flutter_application_1/firebase/facebook_autentication.dart';
import 'package:flutter_application_1/firebase/github_authentication.dart';
import 'package:flutter_application_1/firebase/google_autentication.dart';
import 'package:flutter_application_1/models/firebase_user.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{

  TextEditingController txtConUser = TextEditingController();
  TextEditingController txtConPwd = TextEditingController();
  ///email Autentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final EmailAuthentication _emailAuth = EmailAuthentication();
  //Google Autentication
  final FirebaseUser _user = FirebaseUser();
  final AuthServiceGoogle _authServiceGoogle = AuthServiceGoogle();
  //Facebook Autentication
  final FacebookAuthenticator _facebookAuthenticator = FacebookAuthenticator();
  //GitHub
  final GitHubAuthenticator _githubAuthenticator = GitHubAuthenticator();
  StreamSubscription? _subs;
  bool? loader;

  String ?correo;
  String ?password;
  bool ?status = false;

  // Future<void> saveData(correo, password, status) async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('correo', correo);
  //   await prefs.setString('password', password);
  //   await prefs.setBool('status', status);
  //   Navigator.pushNamed(context, '/onBoarding', arguments: {
  //     'mail': correo
  //   });
  // }

  // Future<void> checData() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   correo = await prefs.getString('correo');
  //   //password = await prefs.getString('password');
  //   status = await prefs.getBool('status');
  //   if(status == true){
  //     Navigator.pushNamed(context, '/onBoarding', arguments: {
  //       'mail': correo
  //     });
  //   }  
  // }

  void ChechAutentication(){
    //_user.user(_authServiceGoogle.user);  
    Future.delayed(Duration.zero, (() {
      if( _auth.currentUser != null ){
        Navigator.pushNamed(context, '/onBoarding');
      }
    }));
  }

  @override
  void initState() {
    loader = false;
    _initDeepLinkListener();
    ChechAutentication();
    super.initState();
  }

  @override
  void dispose() {
    _disposeDeepLinkListener();
    super.dispose();
  }

  ///INICA GIIITTTT
  void _initDeepLinkListener() async {
    _subs = linkStream.listen((String? link) {
      _checkDeepLink(link!);
    }, cancelOnError: true);
  }

  void _checkDeepLink(String link) {
    if (link != null) {
      String code = link.substring(link.indexOf(RegExp('code=')) + 5);
      _githubAuthenticator.loginWithGitHub(code)
        .then((firebaseUser) {
          // print(firebaseUser.email);
          // print(firebaseUser.photoURL);
          // print(firebaseUser.displayName);
        }).catchError((e) {
          print("LOGIN ERROR: " + e.toString());
        });
    }
  }

  void _disposeDeepLinkListener() {
    if (_subs != null) {
      _subs!.cancel();
      _subs = null;
    }
  }
///Termina GIT

  @override
  Widget build(BuildContext context) {

    final txtUser = TextField(
      controller: txtConUser,
      decoration: InputDecoration(
        hintText: 'Introduce el correo electronico',
        label: Text('Correo Electronico'),
      ),
      //onChanged: (value) {}, recuperar los cambios en la caja de texto y se vallan guardando sobre value
    );

    final txtPwd = TextField(
      controller: txtConPwd,
      obscureText: true,
      decoration:  InputDecoration(
        hintText: 'Introduce el password', 
        label: Text('Contraseña'),
      ),
    );

    final cbRemember = CheckboxListTile(
      checkColor: Colors.white,
      value: status,
      title: const Text('Recuerdame'),
      onChanged: (bool? value){
        setState(() {
          status = value!;
        });
      },
      secondary: const Icon(Icons.safety_check),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 20),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/whalpaper.jpg'),
          fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.width / 10,
              child: Image.asset(
                'assets/luna.png',
                width: MediaQuery.of(context).size.width / 2,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 20,
                right: MediaQuery.of(context).size.width / 20,
                bottom: MediaQuery.of(context).size.width / 20,
              ),
              color: Colors.white,
              child: ListView(
                shrinkWrap: true,
                children: [
                    txtUser,
                    SizedBox(height: 15,),
                    txtPwd,
                    cbRemember
                  ],
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width / 2,
              right: MediaQuery.of(context).size.width / 20,
              child: GestureDetector(
                onTap: () async {
                  var ban = await _emailAuth.signInWithEmailAndPassword(mail: txtConUser.text, password: txtConPwd.text);
                  if(ban == true){
                    if (_auth.currentUser!.emailVerified) {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString('correo', txtConUser.text);
                      await prefs.setBool('status', cbRemember.value!);
                      Navigator.pushNamed(context, '/onBoarding', arguments: {
                        'mail': txtConUser.text
                      });
                    }else{
                      print('Usuario no verificado');
                    }
                  }else{
                    print("Credenciales no validas");
                  }
                  //saveData(txtConUser.text, txtConPwd.text, cbRemember.value);
                  //Navigator.pushNamed(context, '/onBoarding');
                },
                child: Image.asset('assets/nube.png',
                  height: MediaQuery.of(context).size.width /4),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width / 100,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20 ),
                width: MediaQuery.of(context).size.width / 1.1,
                child: Column(
                  children: [
                    SocialLoginButton(
                    buttonType: SocialLoginButtonType.facebook,
                    onPressed: () async {
                      var ban = await _facebookAuthenticator.iniciarSesion(context: context);
                      if (ban != null){
                        print("Se logeo correctamente");
                        Navigator.pushNamed(context, '/onBoarding');
                      }
                    },
                    ),
                    SizedBox(height: 10,),
                    SocialLoginButton(
                      buttonType: SocialLoginButtonType.github,
                      onPressed: () {
                        onClickGitHubLoginButton();
                        Navigator.pushNamed(context, '/onBoarding');
                      },
                    ),
                    SizedBox(height: 10,),
                    SocialLoginButton(
                    buttonType: SocialLoginButtonType.google,
                    onPressed: () async {
                      var ban = await _authServiceGoogle.signInGoogle();
                      if (ban != null){
                        print("Se logeo correctamente");
                        Navigator.pushNamed(context, '/onBoarding');
                      }
                    },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width / 1.9,
              child: TextButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/singup');
                },
                child: Text(
                  'SING UP',
                  style: TextStyle(color: Colors.white, fontSize: 20  )
               )
              ),
            )
          ],
        ),
      ),
    );
  }

  void onClickGitHubLoginButton() async {
  const String url = "https://github.com/login/oauth/authorize" +
        "?client_id=" + "1f19c4565d5566be8d54" +
        "&scope=public_repo%20read:user%20user:email";
  if (await canLaunch(url)) {
      setState(() {
        loader = true;

      });
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
      print("Se logeoo");
    } else {
      setState(() {
        loader = false;
      });
      print("No Se logeoo");
      print("CANNOT LAUNCH THIS URL!");
    }}

}