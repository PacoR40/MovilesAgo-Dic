import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:flutter_application_1/settings/styles_settings.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tema = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 165, 201, 202),
      body: Container(
        //padding: EdgeInsets.all(MediaQuery.of(context).size.width * .1),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Image.asset(
               'assets/fondo9.png',
               fit: BoxFit.cover,
               width: double.infinity,
              ),
              Text(
               'SELECT THEME',
               style: TextStyle(
                color: Color.fromARGB(255, 41, 51, 51),
                fontSize: 32,
                fontWeight: FontWeight.bold,
               ),
              ),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: (){
                  tema.setthemeData(temaDia());
                },
                icon: Icon(Icons.sunny, color: Colors.yellow,),
                label: Text('Dia'),
              ),
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: (){
                  tema.setthemeData(temaNoche());
                },
                icon: Icon(Icons.dark_mode, color: Colors.black,),
                label: Text('Noche'),
              ),
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: (){
                  tema.setthemeData(temaCalido());
                },
                icon: Icon(Icons.hot_tub_sharp, color: Color.fromARGB(255, 255, 127, 7),),
                label: Text('Calido'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}