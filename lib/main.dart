import 'package:flutter/material.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;

//Screens
import 'package:digitalcard/Screens/Splash.dart';
import 'package:digitalcard/Screens/Login.dart';
import 'package:digitalcard/Screens/MobileLogin.dart';
import 'package:digitalcard/Screens/Dashboard.dart';
import 'package:digitalcard/Screens/More.dart';
//import 'package:digitalcard/Screens/OfferDetail.dart';
import 'package:digitalcard/Screens/OfferInterestedMembers.dart';
import 'package:digitalcard/Screens/InviteFriends.dart';
import 'package:digitalcard/Screens/EarnHistory.dart';
import 'package:digitalcard/Screens/RedeemHisory.dart';
import 'package:digitalcard/Screens/Signup.dart';
import 'package:digitalcard/Screens/ShareHistory.dart';
import 'package:digitalcard/Screens/PhoneContact.dart';
import 'package:digitalcard/Screens/AddOffer.dart';
import 'package:digitalcard/Screens/AddService.dart';
import 'package:digitalcard/Screens/EditProfile.dart';
import 'package:digitalcard/Screens/ProfileDetail.dart';
import 'package:digitalcard/Screens/AppIntro.dart';
import 'package:digitalcard/Screens/Payment.dart';
import 'package:digitalcard/Screens/AddCard.dart';
//Flare Login
import 'package:digitalcard/Screens/FlareLogin/FlareLogin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Digital Card",
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/AppIntro': (context) => AppIntro(),
        '/Login': (context) => Login(),
        '/Dashboard': (context) => Dashboard(),
        '/More': (context) => More(),
        //'/OfferDetail': (context) => OfferDetail(),
        '/OfferInterestedMembers': (context) => OfferInterestedMembers(),
        '/InviteFriends': (context) => InviteFriends(),
        '/EarnHistory': (context) => EarnHistory(),
        '/RedeemHisory': (context) => RedeemHisory(),
        '/Signup': (context) => Signup(),
        '/ShareHistory': (context) => ShareHistory(),
        '/PhoneContact': (context) => PhoneContact(),
        '/AddOffer': (context) => AddOffer(),
        '/AddService': (context) => AddService(),
        '/EditProfile': (context) => EditProfile(),
        '/ProfileDetail': (context) => ProfileDetail(),
        '/FlareLogin': (context) => FlareLogin(),
        '/MobileLogin': (context) => MobileLogin(),
        '/Payment': (context) => Payment(),
        '/AddCard': (context) => AddCard(),
      },
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: cnst.appMaterialColor,
        accentColor: Colors.blue,
        buttonColor: Color.fromRGBO(145, 194, 41, 1),
      ),
    );
  }
}
