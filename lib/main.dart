import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/profile_model..dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:flutter_application_1/screens/about_us_screen.dart';
import 'package:flutter_application_1/screens/add_place_screen.dart';
import 'package:flutter_application_1/screens/dashboard_screen.dart';
import 'package:flutter_application_1/screens/inserUser_screen.dart';
import 'package:flutter_application_1/screens/list_favorite_movies_screen.dart';
import 'package:flutter_application_1/screens/list_popular_screen.dart';
import 'package:flutter_application_1/screens/list_task_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/onboardin_screen.dart';
import 'package:flutter_application_1/screens/places_screen.dart';
import 'package:flutter_application_1/screens/popular_detail_screen.dart';
import 'package:flutter_application_1/screens/profile_edit_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:flutter_application_1/screens/sing_up_screen.dart';
import 'package:flutter_application_1/screens/splash_screen.dart';
import 'package:flutter_application_1/screens/task_screen.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: PMSNApp()
    );
  }
}

class PMSNApp extends StatelessWidget {
  const PMSNApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: tema.getthemeData(),
        home: const SplashScreen(),
        routes: {
          '/splash' : (BuildContext) => SplashScreen(),
          '/dash' : (BuildContext) => DashboardScreen(),
          '/login' : (BuildContext) => LoginScreen(),
          '/task' : (BuildContext) => ListTaskScreen(),
          '/add' : (BuildContext) => TaskScreen(),
          '/list' : (BuildContext) => ListPopularScreen(),
          //'/profile' : (BuildContext) => ProfileScreen(profile: ProfileModel()),
          //'/profileEdit' : (BuildContext) => profileEditScreen(),
          '/onBoarding' : (BuildContext) => onBoardingScreen(),
          '/detail' : (BuildContext) => PopularDetailScreen(),
          '/singup' : (BuildContext) => SignUpScreen(),
          '/alta' : (BuildContext) => profileEditScreenAlta(),
          '/favMovie' : (BuildContext) => ListFavoritesMovies(),
          '/about' : (BuildContext) => AbaoutUsScreen(),
          '/places' : (BuildContext) => PlacesScreen(),
          '/addplace' : (BuildContext) => AddPlaceScreen(),
        },
      );
  }
}