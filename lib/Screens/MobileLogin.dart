import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/rendering.dart';
import 'package:digitalcard/Screens/FlareLogin/signin_button.dart';
import 'package:digitalcard/Component/TeddyController.dart';
import 'package:digitalcard/Screens/FlareLogin/tracking_text_input.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;

class MobileLogin extends StatefulWidget {
  MobileLogin({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MobileLoginState createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  TeddyController _teddyController;
  @override
  initState() {
    _teddyController = TeddyController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;

    return Scaffold(
      //backgroundColor: cnst.appcolor,
      body: Container(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      // Box decoration takes a gradient
                      gradient: LinearGradient(
                        // Where the linear gradient begins and ends
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        // Add one stop for each color. Stops should increase from 0 to 1
                        //stops: [0.0, 1.0],
                        colors: [
                          cnst.appcolor,
                          Color.fromRGBO(0, 121, 214,1),
                          Color.fromRGBO(0, 75, 147,1)
                        ],
                      ),
                    ),
                  )),
              Positioned.fill(
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: devicePadding.top + 50.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                           child: Text("Digital Card",
                               style: TextStyle(
                                   fontSize: 20,
                                   fontWeight: FontWeight.w600,
                                   color: Colors.white)),
                          ),
                          Container(
                              height: 200,
                              padding: const EdgeInsets.only(left: 30.0, right:30.0),
                              child: FlareActor(
                                "assets/Teddy.flr",
                                shouldClip: false,
                                alignment: Alignment.bottomCenter,
                                fit: BoxFit.contain,
                                controller: _teddyController,
                              )),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Form(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        TrackingTextInput(
                                            label: "Mobile No",
                                            hint: "What's your mobile no",
                                            keyboardType: TextInputType.phone,
                                            onCaretMoved: (Offset caret) {
                                              _teddyController.lookAt(caret);
                                            },
                                          onTextChanged: (String value) {
                                            _teddyController.setMobile(value);
                                          }),
                                        SigninButton(
                                            child: Text("Sign In",
                                                style: TextStyle(
                                                    fontFamily: "RobotoMedium",
                                                    fontSize: 16,
                                                    color: Colors.white)),
                                            onPressed: () {
                                              _teddyController.submitLogin(context);
                                            })
                                      ],
                                    )),
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 30),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text("Not a memeber yet?",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(170, 207, 212, 1.0))),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, "/Signup");
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text("Signup Now",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ))
                        ])),
              ),
            ],
          )),
    );
  }
}