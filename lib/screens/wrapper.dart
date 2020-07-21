import 'package:brewme/models/user.dart';
import 'package:brewme/screens/authenticate.dart';
import 'package:brewme/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
