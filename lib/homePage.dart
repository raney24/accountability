import 'main.dart';
import 'package:flutter/material.dart';
import 'companyPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomePage extends StatelessWidget {
  final String userId;
  HomePage(
      {Key key,
      @required this.userId,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userId),
      ),
      body: StreamBuilder(stream: Firestore.instance.collection('companyNames').snapshots(), builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('Loading data... Please Wait..');
          return Center(
        child: ListView(
          children: <Widget>[
            for (var i = 0; i < 5; i++)
              Card(
                child: ListTile(
                  leading: FlutterLogo(),
                  title: Text(snapshot.data.documents[i]['name']),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompanyPage(
                              pageTitle: snapshot.data.documents[i]['name'],
                              pageDescription: snapshot.data.documents[i]['description'],
                              pageIcon: 'assets/placeholder.png',
                              pageBlurb: snapshot.data.documents[i]['blurb'],
                              currentInvestments: snapshot.data.documents[i]['investments'],
                              companyID: snapshot.data.documents[i]['id'],
                              companyPosition: i,
                              userId: userId ),
                        ));
                  },
                ),
              ),
          ],
        ),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
      );
      // This trailing comma makes auto-formatting nicer for build methods.
      }));
  }
}
