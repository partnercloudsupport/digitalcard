import 'dart:io';
import 'package:flutter/material.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Component/HeaderComponent.dart';
import 'package:digitalcard/Component/ImagePickerHandlerComponent.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with TickerProviderStateMixin, ImagePickerListener {
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  bool showProfileEdit = false;
  bool showCompanyEdit = false;

  TextEditingController txtDate = new TextEditingController();

  TextEditingController txtName = new TextEditingController();
  TextEditingController txtMobile = new TextEditingController();
  TextEditingController txtAbout = new TextEditingController();
  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtWebsite = new TextEditingController();
  TextEditingController txtWhatsApp = new TextEditingController();
  TextEditingController txtFaceboook = new TextEditingController();
  TextEditingController txtTwitter = new TextEditingController();
  TextEditingController txtGoogle = new TextEditingController();
  TextEditingController txtLinkedin = new TextEditingController();
  TextEditingController txtYoutube = new TextEditingController();
  TextEditingController txtIntagram = new TextEditingController();
  TextEditingController txtImage = new TextEditingController();
  TextEditingController txtCoverImage = new TextEditingController();

  TextEditingController txtCompany = new TextEditingController();
  TextEditingController txtRole = new TextEditingController();
  TextEditingController txtCompanyUrl = new TextEditingController();
  TextEditingController txtAddress = new TextEditingController();
  TextEditingController txtPhone = new TextEditingController();
  TextEditingController txtCompanyEmail = new TextEditingController();
  TextEditingController txtMap = new TextEditingController();

  DateTime date = new DateTime.now();

  var profileHeight = 510.0;
  var profileHeightMax = 510.0;

  var profileEditHeight = 0.0;
  var profileEditHeightMax = 875.0;

  var companyHeight = 300.0;
  var companyHeightMax = 300.0;

  var companyEditHeight = 0.0;
  var companyEditHeightMax = 580.0;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
    txtDate.text = date.year.toString() +
        '-' +
        date.month.toString() +
        '-' +
        date.day.toString();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        children: <Widget>[
          HeaderComponent(
            title: "Profile",
            image: "images/header/offerheader.jpg",
            boxheight: 100,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 100,
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(top: 110),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => imagePicker.showDialog(context),
                        child: Image.asset(
                          "images/profilebg.jpg",
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0,top: 50),
                        child: GestureDetector(
                          onTap: () => imagePicker.showDialog(context),
                          child: new Center(
                            child: _image == null
                                ? Image.asset(
                              "images/user.png",
                              height: 100.0,
                              width: 100.0,
                            )
                                : new Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: new BoxDecoration(
                                color: const Color(0xff7c94b6),
                                image: new DecorationImage(
                                  image: new ExactAssetImage(_image.path),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                    color: cnst.buttoncolor, width: 2.0),
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(60.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Profile View
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: profileHeight,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border:
                            Border.all(color: Colors.grey[600], width: 0.5)),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Profile",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                              GestureDetector(
                                  onTap: () {
                                    /*setState(() {
                                              showProfileEdit = true;
                                              profileHeight = 0.0;
                                            })*/
                                    profileHeight = 0.0;
                                    profileEditHeight = profileEditHeightMax;
                                    setState(() {});
                                  },
                                  child: Icon(Icons.edit))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/profile/user24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("Arpit R Shah",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/profile/telephone24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("9033608708",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/profile/gmail24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("arpitshah24@gmail.com",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/profile/domain24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("http://arpitshah.com",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/social/whatsapp24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("9033608708",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/social/facebook24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("http://facebook.com/arpit24",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/social/twitter24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("http://twitter.com/arpit24",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/social/googleplus24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("http://google.com/arpit24",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/social/linkedin24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("http://linkedin.com/arpit24",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/social/youtube24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("http://youtube.com/arpit24",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/social/instagram24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("http://instagram.com/arpit24",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/profile/negotiation24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 90,
                                    child: Text(
                                        "She is working with Scoie insurance since aug 2018 as Telly marketing executive. She is hard working and honest.",
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Edit Profile
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: profileEditHeight,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border:
                            Border.all(color: Colors.grey[600], width: 0.5)),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Edit Profile",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                              GestureDetector(
                                  onTap: () {
                                    /*setState(() {
                                                showProfileEdit = false;
                                                profileHeight = 200.0;
                                              });*/
                                    profileHeight = profileHeightMax;
                                    profileEditHeight = 0.0;
                                    setState(() {});
                                  },
                                  child: Icon(Icons.done_outline))
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                border: new Border.all(width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon:
                                      Image.asset("images/profile/user24.png"),
                                  hintText: "Name"),
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.black),
                            ),
                            //height: 40,
                            width: MediaQuery.of(context).size.width - 60,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                border: new Border.all(width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                      "images/profile/telephone24.png"),
                                  hintText: "Mobile"),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                            ),
                            //height: 40,
                            width: MediaQuery.of(context).size.width - 60,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                border: new Border.all(width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon:
                                      Image.asset("images/profile/gmail24.png"),
                                  hintText: "Email"),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                            ),
                            //height: 40,
                            width: MediaQuery.of(context).size.width - 60,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                border: new Border.all(width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                      "images/profile/domain24.png"),
                                  hintText: "website"),
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.black),
                            ),
                            //height: 40,
                            width: MediaQuery.of(context).size.width - 60,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                border: new Border.all(width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                      "images/social/whatsapp24.png"),
                                  hintText: "Whatsapp No"),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                            ),
                            //height: 40,
                            width: MediaQuery.of(context).size.width - 60,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                border: new Border.all(width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                      "images/social/facebook24.png"),
                                  hintText: "Facebook"),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                            ),
                            //height: 40,
                            width: MediaQuery.of(context).size.width - 60,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                border: new Border.all(width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                      "images/social/twitter24.png"),
                                  hintText: "Twitter"),
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.black),
                            ),
                            //height: 40,
                            width: MediaQuery.of(context).size.width - 60,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                border: new Border.all(width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                      "images/social/googleplus24.png"),
                                  hintText: "Google"),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                            ),
                            //height: 40,
                            width: MediaQuery.of(context).size.width - 60,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                border: new Border.all(width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                      "images/social/linkedin24.png"),
                                  hintText: "Linkedin"),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                            ),
                            //height: 40,
                            width: MediaQuery.of(context).size.width - 60,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                border: new Border.all(width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                      "images/social/youtube24.png"),
                                  hintText: "Youtube"),
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.black),
                            ),
                            //height: 40,
                            width: MediaQuery.of(context).size.width - 60,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                border: new Border.all(width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                      "images/social/instagram24.png"),
                                  hintText: "Instagram"),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                            ),
                            //height: 40,
                            width: MediaQuery.of(context).size.width - 60,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                border: new Border.all(width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                      "images/social/linkedin24.png"),
                                  hintText: "Linkedin"),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                            ),
                            //height: 40,
                            width: MediaQuery.of(context).size.width - 60,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                border: new Border.all(width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextFormField(
                              maxLines: 3,
                              decoration: InputDecoration(
                                  prefixIcon: Image.asset(
                                      "images/profile/negotiation24.png"),
                                  hintText: "About"),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              style: TextStyle(color: Colors.black),
                            ),
                            //height: 40,
                            width: MediaQuery.of(context).size.width - 60,
                          ),
                        ],
                      ),
                    ),
                  ),

                  //Company View
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: companyHeight,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 10, bottom: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border:
                            Border.all(color: Colors.grey[600], width: 0.5)),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Company",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                              GestureDetector(
                                  onTap: () {
                                    companyHeight = 0.0;
                                    companyEditHeight = companyEditHeightMax;
                                    setState(() {});
                                  },
                                  child: Icon(Icons.edit))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/profile/office24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("IT Futurz",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/profile/role24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("Owner",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/profile/telephoneold24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("9033608708",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/profile/gmail24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("info@itfuturz.com",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/profile/domain24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 90,
                                    child: Text("http://itfuturz.com",
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/profile/google24.png"),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 90,
                                    child: Text(
                                        "216, sns arista, opp. happy residency, near prime shoppers, vesu, surat",
                                        style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Edit Company
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: companyEditHeight,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border:
                            Border.all(color: Colors.grey[600], width: 0.5)),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Edit Company",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600)),
                            GestureDetector(
                                onTap: () {
                                  companyHeight = companyHeightMax;
                                  companyEditHeight = 0.0;
                                  setState(() {});
                                },
                                child: Icon(Icons.done_outline))
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              border: new Border.all(width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon:
                                    Image.asset("images/profile/office24.png"),
                                hintText: "Company Name"),
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black),
                          ),
                          //height: 40,
                          width: MediaQuery.of(context).size.width - 60,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              border: new Border.all(width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon:
                                    Image.asset("images/profile/role24.png"),
                                hintText: "Role"),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                          ),
                          //height: 40,
                          width: MediaQuery.of(context).size.width - 60,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              border: new Border.all(width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Image.asset(
                                    "images/profile/telephoneold24.png"),
                                hintText: "Phone"),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                          ),
                          //height: 40,
                          width: MediaQuery.of(context).size.width - 60,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              border: new Border.all(width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon:
                                    Image.asset("images/profile/gmail24.png"),
                                hintText: "Gmail"),
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.black),
                          ),
                          //height: 40,
                          width: MediaQuery.of(context).size.width - 60,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              border: new Border.all(width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon:
                                    Image.asset("images/profile/domain24.png"),
                                hintText: "Website"),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                          ),
                          //height: 40,
                          width: MediaQuery.of(context).size.width - 60,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              border: new Border.all(width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Image.asset(
                                    "images/profile/telephoneold24.png"),
                                hintText: "Phone"),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                          ),
                          //height: 40,
                          width: MediaQuery.of(context).size.width - 60,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              border: new Border.all(width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon:
                                    Image.asset("images/profile/google24.png"),
                                hintText: "Google Map"),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                          ),
                          //height: 40,
                          width: MediaQuery.of(context).size.width - 60,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              border: new Border.all(width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: TextFormField(
                            maxLines: 3,
                            decoration: InputDecoration(
                                prefixIcon: Image.asset(
                                    "images/profile/placeholder24.png"),
                                hintText: "Address"),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                          ),
                          //height: 40,
                          width: MediaQuery.of(context).size.width - 60,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }
}
