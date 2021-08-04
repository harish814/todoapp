import 'package:flutter/material.dart';
import 'package:todoapp/components/components.dart';
import 'package:todoapp/screens/todo_home_screen.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgBlack,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.arrow_forward_ios_sharp,
        color: Colors.black,),
        onPressed: (){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
            return TodoHomeScreen();
          }), (Route<dynamic> route) => false);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '∎ Double Tap to Remove the Item',
            style: heading,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '∎ Long Press to Toggle Between the Days',
            style: heading,
          ),
        ],
      ),
    );
  }
}