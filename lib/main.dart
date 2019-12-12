import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Accountability Partners',
      home: new PartnerList()
    );
  }
}

class PartnerList extends StatefulWidget {
  @override
  createState() => new PartnerListState();
}

class PartnerListState extends State<PartnerList> {

  List<String> _partners = [];

  void _addPartner(String partnerName) {
    if(partnerName.length > 0) {
      setState(() => _partners.add(partnerName));
    }
  }

  void _removePartner(int index) {
    setState(() => _partners.removeAt(index));
  }

  void _promptRemovePartner(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Are you sure you want to remove "${_partners[index]}"?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop()
            ),
            new FlatButton(
              child: new Text('REMOVE'),
              onPressed: () {
                _removePartner(index);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  Widget _buildPartnerList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if(index < _partners.length) {
          return _buildParter(_partners[index], index);
        }
      },
    );
  }

  Widget _buildParter(String partnerName, int index) {
    return new ListTile(
      title: new Text(partnerName),
      onLongPress: () => _promptRemovePartner(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Accountability Partners')
      ),
      body: _buildPartnerList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddPartnerScreen,
        tooltip: 'Add Partner',
        child: new Icon(Icons.add)
      ),
    );
  }

  void _pushAddPartnerScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Add a new partner')
            ),
            body: new TextField(
              autofocus: true,
              onSubmitted: (val) {
                _addPartner(val);
                Navigator.pop(context); // Close the add partner screen
              },
              decoration: new InputDecoration(
                hintText: 'Enter the name of the accountability partner...',
                contentPadding: const EdgeInsets.all(16.0)
              ),
            )
          );
        }
      )
    );
  }
}