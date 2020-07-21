import 'package:brewme/screens/home.dart';
import 'package:brewme/static/loading.dart';
import 'package:flutter/material.dart';
import 'package:brewme/static/input_decoration.dart';
import 'package:brewme/services/auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final GoogleSignIn googleSignIn = GoogleSignIn();
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
        title: Text("Sign In Brew Me"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed:(){widget.toggleView(); },
              icon:Icon(Icons.person),
              label:Text("Register")
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(40.0, 25.0, 40.0, 15.0),
        child: Form(
          key: _formKey,
          child:Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              TextFormField(
                decoration: inputDecoration,
                validator: (val) => val.isEmpty ? "Enter a valid Email":null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 10.0),
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
              SizedBox(height: 10.0),
              RaisedButton(onPressed: ()async{
                if(_formKey.currentState.validate()) {
                  setState(() {
                    loading = true;
                  });
                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                  if(result == null){
                    setState(() {
                      loading = false;
                      error = "WRONG CREDENTIALS";
                    });
                  }
                }
              },
                color:Colors.pink ,
                child: Text( "SignIn",
                style: TextStyle(color: Colors.white),
                ),
              ), SizedBox(height: 10.0),
              SizedBox(height: 50),
              _signInButton(),
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
  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        _auth.signInWithGoogle().whenComplete(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Home();
              },
            ),
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
