import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/database/database_helper.dart';
import 'package:flutter_application_1/firebase/google_autentication.dart';
import 'package:flutter_application_1/models/profile_model..dart';
import 'package:flutter_application_1/provider/theme_provider.dart';
import 'package:flutter_application_1/screens/theme_screen.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../models/firebase_user.dart';

class onBoardingScreen extends StatefulWidget {
  const onBoardingScreen({Key? key}) : super(key: key);
  
  
  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {

  //Google Autentication
  final FirebaseUser _user = FirebaseUser();
  final AuthServiceGoogle _authServiceGoogle = AuthServiceGoogle();
  
  final controller = PageController();
  bool isLastPage = false;

  @override
  void initState() {
    // TODO: implement initState
    _user.user(_authServiceGoogle.user);
    print(_user.uid);
    super.initState();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    //final profile = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      body: 
        Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() => isLastPage = index ==2 );
            },
            children: [            
              buildPage(
                color: Color.fromARGB(255, 231, 246, 242),
                urlImage: 'assets/fondo3.png',
                title: 'IMAGINE',
                colortext: Color.fromARGB(255, 41, 51, 51),
                subtitle: 'La imaginacion es el comienzo de la creacion. Imaginas lo que deseas, deseas lo que imaginas y finalmente creas lo que deseas.',
              ),
              buildPageContent(),
              buildPage(
                color: Color.fromARGB(255, 57, 91, 100),
                urlImage: 'assets/fondo8.png',
                title: 'READY',
                colortext: Color.fromARGB(255, 231, 246, 242),
                subtitle: 'Cada logro comienza con la decision de intentarlo.'
              ),
            ],
          ),
        ),
      bottomSheet: isLastPage 
        ? TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            primary: Colors.white,
            backgroundColor: Color.fromARGB(255, 41, 51, 51),
            minimumSize: const Size.fromHeight(80),
          ),
            child: const Text(
              '¡GO!',
              style: TextStyle(fontSize: 24),
            ),
            // onPressed: () async {
            //   Navigator.pushNamed(context, '/dash', arguments: {
            //     'mail': profile['mail']
            //   });
            // },
            onPressed: () async {
              Navigator.pushNamed(context, '/dash');
            },
        ): Container(
            color: Theme.of(context).hoverColor,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  child: const Text('SKIP'),
                  onPressed: () => controller.jumpToPage(2),
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: WormEffect(
                      spacing: 16,
                      dotColor: Theme.of(context).primaryColor,
                      activeDotColor: Color.fromARGB(255, 142, 143, 143),
                    ),
                    onDotClicked: (index) => controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  child: const Text('NEXT'),
                  onPressed: () => controller.nextPage(
                    duration: const Duration(microseconds: 500),
                    curve: Curves.easeInOut,
                  )
                ),
              ],
            ),
        ),
    );
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
    required Color colortext,
  }) => Container(
    color: color,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          urlImage,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            color: colortext,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17
              ),
          ),
        )
      ],
    ),
  );

  Widget buildPageContent() => Scaffold(
    body: ThemeScreen()
  );
}