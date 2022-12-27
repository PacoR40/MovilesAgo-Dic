import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/email_authentication.dart';


class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtNick = TextEditingController();
  TextEditingController txtMail = TextEditingController();
  TextEditingController txtPwd = TextEditingController();
  EmailAuthentication? _emailAuth;

  @override
  void initState() {
    super.initState();
    _emailAuth = EmailAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de usuarios'),
      ),
      body: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            padding: EdgeInsets.all(35),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close),
                    ),
                    GestureDetector(
                      onTap: () {
                        _emailAuth!.createUserWithEmailAndPassword(mail: txtMail.text, password: txtPwd.text).then((value) {
                          print(value);
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Guardar Perfil',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Swiss',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: txtName,
                  decoration: InputDecoration(
                    hintText: 'Nombre',
                  ),
                ),
                TextFormField(
                  controller: txtMail,
                  decoration: InputDecoration(
                    hintText: 'Correo',
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  controller: txtPwd,
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                  ),
                ),
              ],
            ),
            //color: Colors.white,
          ),
        ),
      ),
    );
  }
}

