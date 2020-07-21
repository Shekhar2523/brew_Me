import 'package:brewme/screens/edit_form.dart';
import 'package:brewme/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brewme/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brewme/models/brew.dart';
import 'package:brewme/models/brew_list.dart';
class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(
          context: context,
          builder: (context){
            return Container(
              padding: EdgeInsets.symmetric(vertical:10.0,horizontal: 60.0),
              child: EditForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(value: DatabaseService().brews,
        child:Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text("Brew Me"),
            backgroundColor: Colors.brown[450],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                onPressed: ()async{
                  await _auth.signOut();
                  },
                icon: Icon(Icons.person),
                label: Text("Logout"),
              ),
              FlatButton.icon(
                  onPressed: (){_showSettingsPanel();},
                  icon: Icon(Icons.edit),
                  label: Text("Edit"),
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              image:DecorationImage(
                image: AssetImage('assets/coffee.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BrewList(),
          ),
        ),
    );
}
}
