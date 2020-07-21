import 'package:brewme/static/loading.dart';
import 'package:flutter/material.dart';
import 'package:brewme/services/auth.dart';
import 'package:brewme/static/input_decoration.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email ="";
  String password = "";
  String error = "";
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign Up Brew Me"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed:(){
                widget.toggleView();
              },
              icon:Icon(Icons.person),
              label:Text("Sign In")
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(40.0, 25.0, 40.0, 15.0),
        child: Form(
          key: _formKey,
          child:Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: inputDecoration,
                validator: (val) => val.isEmpty ? "Enter a valid Email":null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: inputDecoration.copyWith(hintText: "Password"),
                validator: (val) => val.length < 7 ? "Enter a strong password":null,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              RaisedButton(onPressed: ()async{
                if(_formKey.currentState.validate()) {
                  setState(() {
                    loading = true;
                  });
                  dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                  if(result == null){
                    setState(() {
                      loading = false;
                      error = "please supply valid email";
                    });
                  }
                }
              },
                color:Colors.pink ,
                child: Text( "Register",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize: 14.0 ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
