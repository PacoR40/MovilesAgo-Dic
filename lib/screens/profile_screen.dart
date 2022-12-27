import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/profile_model..dart';
import 'package:flutter_application_1/screens/profile_edit_screen.dart';

class ProfileScreen extends StatefulWidget {
  final ProfileModel profile;
  const ProfileScreen({Key? key, required this.profile}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * .1),
        physics: BouncingScrollPhysics(),
        children: [
          buildImage(),
          const SizedBox(height: 24,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(200, 21, 67, 96),
            ),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.account_box, color: Colors.white),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 110,
                          ),
                          Text(widget.profile.name!, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white))
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.alternate_email, color: Colors.white),
                        ],
                      ),
                      Expanded(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        child: 
                          Column(
                            children: [
                              SizedBox(
                                width: 110,
                              ),
                              Text(widget.profile.mail!, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white)),
                            ],
                          )
                        ,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.call_end_rounded, color: Colors.white),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 130,
                          ),
                          Text(widget.profile.number!, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white))
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.code, color: Colors.white),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 110,
                          ),
                          Text(widget.profile.github!, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white))
                        ],
                      )
                    ],
                  ),
                ]
              ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 4,
              right: MediaQuery.of(context).size.width / 4,
            ),
            child: ElevatedButton(
              child: Text('EDITAR'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 33, 47, 60),
                onPrimary: Colors.white,
                shadowColor: Color.fromARGB(255, 136, 159, 231),
                elevation: 5,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => profileEditScreen(profile: widget.profile)));
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildImage() {
    return Hero(
      tag: 'logo',
      // child: ClipRRect(
      //   borderRadius: BorderRadius.circular(200),
      //   child: Image.file(
      //             File(widget.profile.image!),
      //             fit: BoxFit.cover,
      //             height: 280,
      //             width: 200,
      //             )
      // ),
      child: CircleAvatar(
        radius: 110,
        backgroundImage: NetworkImage('https://i.pinimg.com/736x/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg'),
      ),
    );
  }

}