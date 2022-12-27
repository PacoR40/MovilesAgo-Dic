import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class FacebookAuthenticator{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FacebookLogin _objFacebookSignIn = new FacebookLogin();

  User? get user {
    return _auth.currentUser;
  }

  //var usedr;

  Future<User?> iniciarSesion({required BuildContext context}) async {
    User? user;

    FacebookLoginResult objFacebookSignInAccount = await _objFacebookSignIn.logIn(
      permissions: [
        FacebookPermission.email,
        FacebookPermission.publicProfile
      ]);

    if (objFacebookSignInAccount != null ) {
      FacebookAccessToken objAccessToken = objFacebookSignInAccount.accessToken!;
      AuthCredential objCredential = FacebookAuthProvider.credential(objAccessToken.token);
      try {
        UserCredential objUserCredential = await FirebaseAuth.instance.signInWithCredential(objCredential);
        user = objUserCredential.user;
        return user;
      } on FirebaseAuthException catch (e) {
        print("Error en la autenticacion");
      }
    }else{
      return null;
    }
  }

  Future<void> signOutFacebook() async {
    try {
      await _objFacebookSignIn.logOut();
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

}