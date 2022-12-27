import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/github_login_request.dart';
import 'package:flutter_application_1/models/github_login_response.dart';
import 'package:http/http.dart' as http;

class GitHubAuthenticator {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> loginWithGitHub(String code) async{
    final response = await http.post(Uri.parse("https://github.com/login/oauth/access_token"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode(GitHubLoginRequest(
        clientId: "",
        clientSecret: "",
        code: code
      )),
    );
    GitHubLoginResponse loginResponse = GitHubLoginResponse.fromJson(json.decode(response.body));

    final AuthCredential credential = GithubAuthProvider.credential(loginResponse.accessToken!);

    final User? user = (await _auth.signInWithCredential(credential)).user;
    return user!;
  }
}
