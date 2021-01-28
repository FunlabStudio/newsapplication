import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newsapplication/screens/homePage.dart';
import 'package:newsapplication/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userId = prefs.getString('UserId');
      if(userId == null){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }else{
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
            'https://w7.pngwing.com/pngs/982/544/png-transparent-news-graphy-logo-icon-news-logo-text-photography-computer-wallpaper.png'),
      ),
    );
  }
}
