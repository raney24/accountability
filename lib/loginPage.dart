import 'package:firebase_auth/firebase_auth.dart';
import 'package:five_across/auth.dart';
import 'package:five_across/homePage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'companyPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  onPressed: () async {
                    String userName = await authService.testSignInWithGoogle();
                    print(userName);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage(userId: userName)));
                        
                  },
                  color: Colors.white,
                  textColor: Colors.black,
                  child: Text("Login with Google"),
                ),
                MaterialButton(
                  onPressed: () {
                    authService.signOut();
                  },
                  color: Colors.red,
                  textColor: Colors.black,
                  child: Text("Signout"),
                )
              ],
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
