import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/database_helper.dart';
import 'package:image_picker/image_picker.dart';

class profileEditScreenAlta extends StatefulWidget {
  const profileEditScreenAlta({Key? key}) : super(key: key);

  @override
  State<profileEditScreenAlta> createState() => _profileEditScreenAlta();
}

class _profileEditScreenAlta extends State<profileEditScreenAlta> {

  late final TextEditingController controller;

  DatabaseHelper? _database;
  bool ban = false;
  String? imagePath;
  String? imageRute;

  @override
  void initState(){
    super.initState();
    _database = DatabaseHelper();
  }
  @override
  Widget build(BuildContext context) {

    TextEditingController txtContName = TextEditingController();
    TextEditingController txtContMail = TextEditingController();
    TextEditingController txtContNumber =  TextEditingController();
    TextEditingController txtContGit = TextEditingController();

    // if(imageRute == null){
    //   imagePath = widget.profile.image!;
    // }else{
    //   imagePath = imageRute;
    // }


    final txtName = TextField(
      controller: txtContName,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11)
        )
      ),
    );

    final txtMail = TextField(
      controller: txtContMail,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11)
        )
      ),
    );

    final txtNumber = TextField(
      //keyboardType: TextInputType.number,
      controller: txtContNumber,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11)
        )
      ),
    );

    final txtGit = TextField(
      controller: txtContGit,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11)
        )
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('INSERT Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * .1),
        physics: BouncingScrollPhysics(),
          children:[
              (imagePath == null) ? 
              CircleAvatar(
                radius: 110,
                backgroundImage: NetworkImage('https://i.pinimg.com/736x/8b/16/7a/8b167af653c2399dd93b952a48740620.jpg'),
              ) : 
              ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.file(
                  File(imagePath!),
                  fit: BoxFit.cover,
                  height: 280,
                  width: 200,
                  )
              ),
              IconButton(
                icon: Icon(Icons.add_a_photo),
                iconSize: 40,
                color: Color.fromARGB(255, 33, 47, 60),
                onPressed: () async {
                  final ImagePicker _picker = ImagePicker();
                  XFile? _pickerFile = await _picker.pickImage(source: ImageSource.gallery);
                  //imageRute = _pickerFile?.path;
                  imagePath = _pickerFile?.path;
                  // print(imagePath);
                  setState(() {});
                  //print(imagePath);
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "NAME",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                    ),
                  const SizedBox(height: 8),
                  txtName,
                  const SizedBox(height: 15),
                  Text(
                    "E-MAIL",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                    ),
                  const SizedBox(height: 8),
                  txtMail,
                  const SizedBox(height: 15),
                  Text(
                    "PHONE NUMBER",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                    ),
                  const SizedBox(height: 8),
                  txtNumber,
                  const SizedBox(height: 15),
                  Text(
                    "GITHUB",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                    ),
                  const SizedBox(height: 8),
                  txtGit,
                ]
              ),
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 4,
                  right: MediaQuery.of(context).size.width / 4,
                ),
                child: ElevatedButton(
                  child: Text('SAVE'),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 33, 47, 60),
                    onPrimary: Colors.white,
                    shadowColor: Color.fromARGB(255, 136, 159, 231),
                    elevation: 5,
                  ),
                  onPressed: () {
                    _database!.insertar({
                      'image': imagePath,
                      'name': txtContName.text,
                      'mail': txtContMail.text,
                      'number': txtContNumber.text,
                      'github': txtContGit.text
                    },'tblProfile').then((value) {
                      final snackBar =
                        SnackBar(content: Text("Usuario dado de alta correctamente"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ),
          ],
      ),
    );

  } 

}