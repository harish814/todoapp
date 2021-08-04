import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/components/components.dart';
import 'package:todoapp/screens/todo_home_screen.dart';

import 'intro_screen.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  void initState(){
    super.initState();
    print('hello');
    checkFirstSeen();
  }
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    print('hello');
    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => TodoHomeScreen()));
      print('hello todo');
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroScreen()));
      print('hello intro');
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: bgBlack,
      body: new Center(
        child: new Text('Loading...',
          style: TextStyle(
            fontFamily: 'Abril',
            color: Colors.white,
            fontSize: 43,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),),
      ),
    );
  }
}