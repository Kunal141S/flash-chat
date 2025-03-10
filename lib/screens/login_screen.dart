import 'package:flutter/material.dart';
import 'package:flashchat/components/rounded_button.dart';
import 'package:flashchat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flashchat/screens/chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var email;
  var passwrd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                email = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              obscuringCharacter: '*',
              style: TextStyle(color: Colors.black),
              onChanged: (value) {
                passwrd = value;
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Password'),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              color: Colors.lightBlueAccent,
              title: 'Log In',
              onPressed: () async{
              try {
                await Firebase.initializeApp();
                final user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: passwrd);
                
                // ignore: unnecessary_null_comparison
                if (user != null) {
                  Navigator.pushNamed(context, ChatScreen.id);
                }
                
              } on Exception catch (e) {
                print(e);
              }
              },
            ),
          ],
        ),
      ),
    );
  }
}
