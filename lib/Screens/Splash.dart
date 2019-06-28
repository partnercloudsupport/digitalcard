import 'dart:async';
import 'package:flutter/material.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String MemberId = prefs.getString(cnst.Session.MemberId);

      bool IsAppIntroCompleted =
          prefs.getBool(cnst.Session.IsAppIntroCompleted);

      if (MemberId != null && MemberId != "")
        Navigator.pushReplacementNamed(context, '/Dashboard');
      else {
        if (IsAppIntroCompleted != null && IsAppIntroCompleted == true)
          Navigator.pushReplacementNamed(context, '/MobileLogin');
        else
          Navigator.pushReplacementNamed(context, '/AppIntro');
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      color: cnst.appcolor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("images/logo.png",
              width: 200.0, height: 200.0, fit: BoxFit.contain),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          Text(
            'Digital Card',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700
                //fontSize: 18.0,
                ),
          )
        ],
      ),
    ));
  }
}
