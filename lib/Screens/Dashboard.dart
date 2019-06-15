import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'dart:async';
//Screens
import 'package:digitalcard/Screens/Home.dart';
import 'package:digitalcard/Screens/Offers.dart';
import 'package:digitalcard/Screens/Services.dart';
import 'package:digitalcard/Screens/More.dart';

import 'package:digitalcard/Screens/AnimatedBottomBar.dart';


class Dashboard extends StatefulWidget {
  final List<BarItem> barItems = [
    BarItem(text: "Home", iconData: Icons.home, color: Colors.indigo),
    BarItem(text: "Service", iconData: Icons.people, color: Colors.yellow.shade900),
    BarItem(text: "Offer", iconData: Icons.local_offer, color: Colors.teal),
    BarItem(text: "More", iconData: Icons.apps, color: Colors.deepOrange.shade600),
  ];

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    });
  }

  final List<Widget> _children = [
    Home(),
    MemberServices(),
    Offers(),
    More(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
        bottomNavigationBar: AnimatedBottomBar(
          barItems: widget.barItems,
          animationDuration: Duration(milliseconds: 200),
          onBarTab:(index){
            setState(() {
              _currentIndex = index;
            });
          }
        )
    );
  }
}
