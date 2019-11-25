import 'main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';

class CompanyPage extends StatefulWidget {
  // this is the group of classes that allows the tiles of users to be selected.
  final String pageIcon; // define the picture to go with the page
  final String pageTitle; //define the title to go with the page
  final String pageDescription; // define description
  final String pageBlurb;
  final int currentInvestments;
  final String companyID;
  final int companyPosition;
  final String userId; // define short descriptive sentence on the page
  var teamMembers = []; // initialize the teamMembers to empty
  CompanyPage(
      {Key key,
      @required this.pageTitle,
      this.pageIcon,
      this.pageDescription,
      this.pageBlurb,
      this.currentInvestments,
      this.companyID,
      this.companyPosition,
      this.userId})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CompanyPageState();
  }
}

class CompanyPageState extends State<CompanyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
      ),
      body: StreamBuilder(stream: Firestore.instance.collection('companyNames').snapshots(), builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('Loading data... Please Wait..');
          return StreamBuilder(stream: Firestore.instance.collection('users').snapshots(), builder: (context, snapshot2) {
            if (!snapshot.hasData) return Text('Loading data... Please Wait..');
            return Center(
        child: ListView(
          children: <Widget>[
            Text(widget.pageTitle),
            Image.asset(widget.pageIcon),
            Text(widget.pageDescription),
            Text(widget.pageBlurb),
            RaisedButton(
              child: Text("INVEST"),
              onPressed: () {
                int currentInvested = snapshot.data.documents[widget.companyPosition]['investments'];
                int investment = 300;
                print(widget.companyID);
                updateInvestments(currentInvested,investment, widget.companyID);
                int currentCash = snapshot2.data.documents[0]['cash'];
                updateWallet(investment, widget.userId, currentCash);
                print("touched");
              },
            )
          ],
        ),
      );
          }); 
      // This trailing comma makes auto-formatting nicer for build methods.
      }));
  }
}

void updateInvestments(cash,investment, company) async {
  print(investment);
  print(cash);
  cash += investment;
  DocumentReference ref = Firestore.instance
      .collection('companyNames')
      .document(company);

  return ref.setData({
    'investments': cash,
  }, merge: true);
}

void updateWallet(investment,uid,currentCash) async {
  print(investment);
  DocumentReference ref = Firestore.instance
      .collection('users')
      .document(uid);
      
      int newBalance = currentCash - investment;

  return ref.setData({
    'cash': newBalance,
  }, merge: true);
}
