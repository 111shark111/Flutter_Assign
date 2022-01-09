import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login.dart';
import '../screens/homeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var id;
  @override
  void initState() {
    getLoginData();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.push(context, MaterialPageRoute(builder: (context) {
        return (id != null ? HomeScreen(id: id) : const Login());
      })),
    );

    super.initState();
  }

  Future getLoginData() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    var tmp = sharedpref.getInt('id');
    setState(() {
      id = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Lottie.asset(
            'lib/assets/rocket.json',
          ),
        ),
      ),
    );
  }
}
