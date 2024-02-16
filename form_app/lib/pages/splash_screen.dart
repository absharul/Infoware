import 'dart:async';
import 'package:flutter/material.dart';
import 'package:form_app/pages/homepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay and then navigate to the main screen
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 200.0,),
            Image(image: AssetImage('asset/catlogo.png'),width: 300, height: 300,),
            SizedBox(height: 15.0,),
            Text("Sir please fill up your details",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),)
          ],
        )
        ),
    );
  }
}
