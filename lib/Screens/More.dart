import 'package:flutter/material.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Component/HeaderComponent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            HeaderComponent(
              title: "More Options",
              image: "images/header/moreheader.jpg",
              boxheight: 110,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 170,
              margin: EdgeInsets.only(top: 120),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/InviteFriends");
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5, color: Colors.grey[600]))),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: <Widget>[
                              Image.asset("images/refer.png",
                                  height: 50, width: 50),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text("Refer & Earn",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, "/ShareHistory"),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5, color: Colors.grey[600]))),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: <Widget>[
                              Image.asset("images/refer.png",
                                  height: 50, width: 50),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text("Share History",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          )),
                    ),
                    /*GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, "/PhoneContact"),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5, color: Colors.grey[600]))),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: <Widget>[
                              Image.asset("images/refer.png",
                                  height: 50, width: 50),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text("Phone Contact",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          )),
                    ),*/
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove(cnst.Session.MemberId);
                        prefs.remove(cnst.Session.Name);
                        prefs.remove(cnst.Session.Mobile);
                        prefs.remove(cnst.Session.Company);
                        Navigator.pushNamed(context, "/MobileLogin");
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5, color: Colors.grey[600]))),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.power_settings_new, size: 50),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text("Logout",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
