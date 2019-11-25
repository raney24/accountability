import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new HomePage(), // takes to first page  
        '/login': (BuildContext context) => new LoginPage(),
      },
    );
  }
}
