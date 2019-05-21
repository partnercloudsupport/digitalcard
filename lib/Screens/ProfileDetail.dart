import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Component/HeaderComponent.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:digitalcard/Common/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digitalcard/Common/ClassList.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:digitalcard/Component/LoadinComponent.dart';

class ProfileDetail extends StatefulWidget {
  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail>
    with TickerProviderStateMixin {
  File _imageCover;
  bool _editCoverImg = false;

  File _imageProfile;
  bool _editProfileImg = false;

  ImageListener _listener;
  String MemberId = "";

  bool showProfileEdit = false;
  bool showCompanyEdit = false;

  MemberClass memberdata = new MemberClass();

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
  TextEditingController txtPersonalPAN = new TextEditingController();

  TextEditingController txtCompany = new TextEditingController();
  TextEditingController txtRole = new TextEditingController();
  TextEditingController txtCompanyUrl = new TextEditingController();
  TextEditingController txtAddress = new TextEditingController();
  TextEditingController txtPhone = new TextEditingController();
  TextEditingController txtCompanyEmail = new TextEditingController();
  TextEditingController txtMap = new TextEditingController();
  TextEditingController txtAboutCompany = new TextEditingController();
  TextEditingController txtGstNo = new TextEditingController();
  TextEditingController txtCompanyPAN = new TextEditingController();

  DateTime date = new DateTime.now();

  bool editName = false;
  bool editMobile = false;
  bool editEmail = false;
  bool editWeb = false;
  bool editWhatsapp = false;
  bool editPersonalPan = false;
  bool editFacebook = false;
  bool editTwitter = false;
  bool editGoogle = false;
  bool editLinkedin = false;
  bool editYoutube = false;
  bool editInstagram = false;
  bool editAbout = false;
  bool editCompany = false;
  bool editRole = false;
  bool editPhone = false;
  bool editCompanyEmail = false;
  bool editCompanyUrl = false;
  bool editCompanyAddress = false;
  bool editCompanyPan = false;
  bool editCompanyGst = false;
  bool editCompanyAbout = false;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    GetProfileData();
    txtDate.text = date.year.toString() +
        '-' +
        date.month.toString() +
        '-' +
        date.day.toString();
  }

  GetProfileData() {
    Services.GetMemberDetail().then((data) {
      setState(() {
        memberdata = data[0];
      });
      SetDataToController();
    });
  }

  SetDataToController() {
    //Profile Data
    txtName.text = memberdata.Name;
    txtMobile.text = memberdata.Mobile;
    txtEmail.text = memberdata.Email;
    txtWebsite.text = memberdata.website;
    txtWhatsApp.text = memberdata.Whatsappno;
    txtFaceboook.text = memberdata.Facebooklink;
    txtTwitter.text = memberdata.Twitter;
    txtGoogle.text = memberdata.Google;
    txtLinkedin.text = memberdata.Linkedin;
    txtYoutube.text = memberdata.Youtube;
    txtIntagram.text = memberdata.Instagram;
    txtAbout.text = memberdata.About;
    txtPersonalPAN.text = memberdata.PersonalPAN;

    //Company Data
    txtCompany.text = memberdata.Company;
    txtRole.text = memberdata.Role;
    txtPhone.text = memberdata.CompanyPhone;
    txtCompanyEmail.text = memberdata.CompanyEmail;
    txtCompanyUrl.text = memberdata.CompanyUrl;
    txtAddress.text = memberdata.CompanyAddress;
    txtGstNo.text = memberdata.GstNo;
    txtCompanyPAN.text = memberdata.CompanyPAN;
    txtAboutCompany.text = memberdata.AboutCompany;

    setState(() {
      MemberId = memberdata.Id;
    });
  }

  Future<bool> updateProfile(String column, String columndata) async {
    setState(() {
      isLoading = true;
    });
    var data = {
      'type': 'profile',
      'column': column.toString(),
      'columndata': columndata.replaceAll("'", "''").toString(),
      'memberid': MemberId.toString(),
    };
    print(data);
    Services.UpdateProfile(data).then((data) {
      if (data != null && data.ERROR_STATUS == false) {
        Fluttertoast.showToast(
            msg: "Data Saved",
            backgroundColor: Colors.green,
            gravity: ToastGravity.TOP);
        setState(() {
          isLoading = false;
        });
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "Data Not Saved" + data.MESSAGE,
            backgroundColor: Colors.red,
            gravity: ToastGravity.TOP,
            toastLength: Toast.LENGTH_LONG);
        setState(() {
          isLoading = false;
        });
        return false;
      }
    }, onError: (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Data Not Saved" + e.toString(), backgroundColor: Colors.red);
      return false;
    });
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
            boxheight: 150,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 100,
            //padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(top: 110),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      _imageCover == null
                          ? memberdata.CoverImage != null
                              ? FadeInImage.assetNetwork(
                                  placeholder: "images/profilebg.jpg",
                                  image: memberdata.CoverImage,
                                  height: 230,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover)
                              : Image.asset("images/profilebg.jpg",
                                  height: 230,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover)
                          : Image.file(File(_imageCover.path),
                              height: 230,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0, top: 50),
                        child: new Center(
                          child: _imageProfile == null
                              ? memberdata.Image != null
                                  ? ClipOval(
                                      child: FadeInImage.assetNetwork(
                                          placeholder: "images/users.png",
                                          image: memberdata.Image,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover),
                                    )
                                  : Image.asset(
                                      "images/users.png",
                                      height: 100.0,
                                      width: 100.0,
                                    )
                              : ClipOval(
                                  child: Image.file(File(_imageProfile.path),
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover),
                                ),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          color: Color.fromRGBO(0, 0, 0, 0.4),
                          margin: EdgeInsets.only(top: 180),
                          height: 50,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              _editProfileImg
                                  ? Container(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  30) /
                                              2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          GestureDetector(
                                              child: Icon(Icons.done_outline,
                                                  color: Colors.white),
                                              onTap: () async {
                                                String img = '';

                                                if (_imageProfile != null) {
                                                  List<int> imageBytes =
                                                      await _imageProfile
                                                          .readAsBytesSync();
                                                  String base64Image =
                                                      base64Encode(imageBytes);
                                                  img = base64Image;
                                                }

                                                updateProfile('Image', img)
                                                    .then((val) {
                                                  setState(() {
                                                    _editProfileImg = false;
                                                  });
                                                }, onError: (e) {
                                                  setState(() {
                                                    _editProfileImg = false;
                                                  });
                                                });
                                              }),
                                          GestureDetector(
                                              child: Icon(Icons.close,
                                                  color: Colors.white),
                                              onTap: () async {
                                                setState(() {
                                                  _editProfileImg = false;
                                                  _imageProfile = null;
                                                });
                                              })
                                        ],
                                      ),
                                    )
                                  : MaterialButton(
                                      onPressed: () {
                                        _profileImagePopup(context);
                                      },
                                      child: Text(
                                        "Edit Photo",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      minWidth:
                                          (MediaQuery.of(context).size.width -
                                                  30) /
                                              2,
                                    ),
                              //Divider
                              Container(
                                height: 30,
                                width: 3,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              //Divider End
                              _editCoverImg
                                  ? Container(
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  30) /
                                              2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          GestureDetector(
                                              child: Icon(Icons.done_outline,
                                                  color: Colors.white),
                                              onTap: () async {
                                                String img = '';

                                                if (_imageCover != null) {
                                                  List<int> imageBytes =
                                                      await _imageCover
                                                          .readAsBytesSync();
                                                  String base64Image =
                                                      base64Encode(imageBytes);
                                                  img = base64Image;
                                                }

                                                updateProfile('CoverImage', img)
                                                    .then((val) {
                                                  setState(() {
                                                    _editCoverImg = false;
                                                  });
                                                }, onError: (e) {
                                                  setState(() {
                                                    _editCoverImg = false;
                                                  });
                                                });
                                              }),
                                          GestureDetector(
                                              child: Icon(Icons.close,
                                                  color: Colors.white),
                                              onTap: () async {
                                                setState(() {
                                                  _editCoverImg = false;
                                                  _imageCover = null;
                                                });
                                              })
                                        ],
                                      ),
                                    )
                                  : MaterialButton(
                                      onPressed: () {
                                        _coverImagePopup(context);
                                      },
                                      child: Text(
                                        "Edit Cover",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      minWidth:
                                          (MediaQuery.of(context).size.width -
                                                  30) /
                                              2,
                                    )
                            ],
                          ))
                    ],
                  ),
                  // Profile View
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border:
                            Border.all(color: Colors.grey[600], width: 0.5)),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text("Profile",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600)),
                          ),
                          //Name
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editName
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/profile/user24.png"),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                    memberdata.Name != null
                                                        ? memberdata.Name
                                                        : "",
                                                    style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editName = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          //margin: EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              border: new Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: TextFormField(
                                            controller: txtName,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                    "images/profile/user24.png"),
                                                hintText: "Name"),
                                            keyboardType: TextInputType.text,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          //height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (txtName.text != "") {
                                                  updateProfile(
                                                          'Name', txtName.text)
                                                      .then((val) {
                                                    memberdata.Name =
                                                        txtName.text;
                                                    setState(() {
                                                      editName = false;
                                                    });
                                                  }, onError: (e) {
                                                    txtName.text =
                                                        memberdata.Name;
                                                    setState(() {
                                                      editName = false;
                                                    });
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Enter Data First",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      textColor: Colors.black,
                                                      fontSize: 15.0);
                                                }
                                              },
                                              child: Icon(Icons.done_outline)),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                txtName.text = memberdata.Name;
                                                editName = false;
                                              });
                                            },
                                            child: Icon(Icons.close))
                                      ],
                                    ),
                            ),
                          ),

                          //Mobile
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editMobile
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/profile/telephone24.png"),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                    memberdata.Mobile != null
                                                        ? memberdata.Mobile
                                                        : "",
                                                    style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editMobile = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          //margin: EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              border: new Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: TextFormField(
                                            controller: txtMobile,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                    "images/profile/telephone24.png"),
                                                hintText: "Mobile"),
                                            keyboardType: TextInputType.phone,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          //height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (txtMobile.text != "") {
                                                  updateProfile('Mobile',
                                                          txtMobile.text)
                                                      .then((val) {
                                                    memberdata.Mobile =
                                                        txtMobile.text;
                                                    setState(() {
                                                      editMobile = false;
                                                    });
                                                  }, onError: (e) {
                                                    txtMobile.text =
                                                        memberdata.Mobile;
                                                    setState(() {
                                                      editMobile = false;
                                                    });
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Enter Data First",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      textColor: Colors.black,
                                                      fontSize: 15.0);
                                                }
                                              },
                                              child: Icon(Icons.done_outline)),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                txtMobile.text =
                                                    memberdata.Mobile;
                                                editMobile = false;
                                              });
                                            },
                                            child: Icon(Icons.close))
                                      ],
                                    ),
                            ),
                          ),

                          //Email
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editEmail
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/profile/gmail24.png"),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                    memberdata.Email != null
                                                        ? memberdata.Email
                                                        : "",
                                                    style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editEmail = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          //margin: EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              border: new Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: TextFormField(
                                            controller: txtEmail,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                    "images/profile/gmail24.png"),
                                                hintText: "Email"),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          //height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (txtEmail.text != "") {
                                                  updateProfile('Email',
                                                          txtEmail.text)
                                                      .then((val) {
                                                    memberdata.Email =
                                                        txtEmail.text;
                                                    setState(() {
                                                      editEmail = false;
                                                    });
                                                  }, onError: (e) {
                                                    txtEmail.text =
                                                        memberdata.Email;
                                                    setState(() {
                                                      editEmail = false;
                                                    });
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Enter Data First",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      textColor: Colors.black,
                                                      fontSize: 15.0);
                                                }
                                              },
                                              child: Icon(Icons.done_outline)),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                txtEmail.text =
                                                    memberdata.Email;
                                                editEmail = false;
                                              });
                                            },
                                            child: Icon(Icons.close))
                                      ],
                                    ),
                            ),
                          ),

                          //Website
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editWeb
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/profile/domain24.png"),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                    memberdata.website != null
                                                        ? memberdata.website
                                                        : "",
                                                    style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editWeb = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          //margin: EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              border: new Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: TextFormField(
                                            controller: txtWebsite,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                    "images/profile/domain24.png"),
                                                hintText: "website"),
                                            keyboardType: TextInputType.url,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          //height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (txtWebsite.text != "") {
                                                  updateProfile('website',
                                                          txtWebsite.text)
                                                      .then((val) {
                                                    memberdata.website =
                                                        txtWebsite.text;
                                                    setState(() {
                                                      editWeb = false;
                                                    });
                                                  }, onError: (e) {
                                                    txtWebsite.text =
                                                        memberdata.website;
                                                    setState(() {
                                                      editWeb = false;
                                                    });
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Enter Data First",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      textColor: Colors.black,
                                                      fontSize: 15.0);
                                                }
                                              },
                                              child: Icon(Icons.done_outline)),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              txtWebsite.text =
                                                  memberdata.website;
                                              setState(() {
                                                editWeb = false;
                                              });
                                            },
                                            child: Icon(Icons.close))
                                      ],
                                    ),
                            ),
                          ),

                          //Whatsapp
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editWhatsapp
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/social/whatsapp24.png"),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                    memberdata.Whatsappno !=
                                                            null
                                                        ? memberdata.Whatsappno
                                                        : "",
                                                    style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editWhatsapp = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          //margin: EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              border: new Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: TextFormField(
                                            controller: txtWhatsApp,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                    "images/social/whatsapp24.png"),
                                                hintText: "Whatsapp No"),
                                            keyboardType: TextInputType.phone,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          //height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (txtWhatsApp.text != "") {
                                                  updateProfile('Whatsappno',
                                                          txtWhatsApp.text)
                                                      .then((val) {
                                                    memberdata.Whatsappno =
                                                        txtWhatsApp.text;
                                                    setState(() {
                                                      editWhatsapp = false;
                                                    });
                                                  }, onError: (e) {
                                                    txtWhatsApp.text =
                                                        memberdata.Whatsappno;
                                                    setState(() {
                                                      editWhatsapp = false;
                                                    });
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Enter Data First",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      textColor: Colors.black,
                                                      fontSize: 15.0);
                                                }
                                              },
                                              child: Icon(Icons.done_outline)),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              txtWhatsApp.text =
                                                  memberdata.Whatsappno;
                                              setState(() {
                                                editWhatsapp = false;
                                              });
                                            },
                                            child: Icon(Icons.close))
                                      ],
                                    ),
                            ),
                          ),

                          //PAN
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editPersonalPan
                                  ? Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width -
                                        80,
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                            "images/profile/pan.png"),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10),
                                          child: Text(
                                              memberdata.PersonalPAN !=
                                                  null
                                                  ? memberdata.PersonalPAN
                                                  : "",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 15,
                                                  fontWeight:
                                                  FontWeight.w600)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          editPersonalPan = true;
                                        });
                                      },
                                      child: Icon(Icons.edit))
                                ],
                              )
                                  : Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width -
                                        150,
                                    //margin: EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(
                                            255, 255, 255, 0.5),
                                        border: new Border.all(width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: TextFormField(
                                      controller: txtPersonalPAN,
                                      decoration: InputDecoration(
                                          prefixIcon: Image.asset(
                                              "images/profile/pan.png"),
                                          hintText: "PAN No"),
                                      keyboardType: TextInputType.text,
                                      style:
                                      TextStyle(color: Colors.black),
                                    ),
                                    //height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: GestureDetector(
                                        onTap: () {
                                          if (txtPersonalPAN.text != "") {
                                            updateProfile('PersonalPAN',
                                                txtPersonalPAN.text)
                                                .then((val) {
                                              memberdata.PersonalPAN =
                                                  txtPersonalPAN.text;
                                              setState(() {
                                                editPersonalPan = false;
                                              });
                                            }, onError: (e) {
                                              txtPersonalPAN.text =
                                                  memberdata.PersonalPAN;
                                              setState(() {
                                                editPersonalPan = false;
                                              });
                                            });
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                "Please Enter Data First",
                                                toastLength:
                                                Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.TOP,
                                                backgroundColor:
                                                Colors.yellow,
                                                textColor: Colors.black,
                                                fontSize: 15.0);
                                          }
                                        },
                                        child: Icon(Icons.done_outline)),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        txtPersonalPAN.text =
                                            memberdata.PersonalPAN;
                                        setState(() {
                                          editPersonalPan = false;
                                        });
                                      },
                                      child: Icon(Icons.close))
                                ],
                              ),
                            ),
                          ),

                          //Facebook
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editFacebook
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/social/facebook24.png"),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    110,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                      memberdata.Facebooklink !=
                                                              null
                                                          ? memberdata
                                                              .Facebooklink
                                                          : "",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editFacebook = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          //margin: EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              border: new Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: TextFormField(
                                            controller: txtFaceboook,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                    "images/social/facebook24.png"),
                                                hintText: "Facebook Page"),
                                            keyboardType: TextInputType.url,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          //height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (txtFaceboook.text != "") {
                                                  updateProfile('Facebooklink',
                                                          txtFaceboook.text)
                                                      .then((val) {
                                                    memberdata.Facebooklink =
                                                        txtFaceboook.text;
                                                    setState(() {
                                                      editFacebook = false;
                                                    });
                                                  }, onError: (e) {
                                                    txtFaceboook.text =
                                                        memberdata.Facebooklink;
                                                    setState(() {
                                                      editFacebook = false;
                                                    });
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Enter Data First",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      textColor: Colors.black,
                                                      fontSize: 15.0);
                                                }
                                              },
                                              child: Icon(Icons.done_outline)),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              txtFaceboook.text =
                                                  memberdata.Facebooklink;
                                              setState(() {
                                                editFacebook = false;
                                              });
                                            },
                                            child: Icon(Icons.close))
                                      ],
                                    ),
                            ),
                          ),

                          //Twitter
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editTwitter
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/social/twitter24.png"),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    110,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                      memberdata.Twitter != null
                                                          ? memberdata.Twitter
                                                          : "",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editTwitter = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          //margin: EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              border: new Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: TextFormField(
                                            controller: txtTwitter,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                    "images/social/twitter24.png"),
                                                hintText: "Twitter Page"),
                                            keyboardType: TextInputType.url,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          //height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (txtTwitter.text != "") {
                                                  updateProfile('Twitter',
                                                          txtTwitter.text)
                                                      .then((val) {
                                                    memberdata.Twitter =
                                                        txtTwitter.text;
                                                    setState(() {
                                                      editTwitter = false;
                                                    });
                                                  }, onError: (e) {
                                                    txtTwitter.text =
                                                        memberdata.Twitter;
                                                    setState(() {
                                                      editTwitter = false;
                                                    });
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Enter Data First",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      textColor: Colors.black,
                                                      fontSize: 15.0);
                                                }
                                              },
                                              child: Icon(Icons.done_outline)),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              txtTwitter.text =
                                                  memberdata.Twitter;
                                              setState(() {
                                                editTwitter = false;
                                              });
                                            },
                                            child: Icon(Icons.close))
                                      ],
                                    ),
                            ),
                          ),

                          //Google
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editGoogle
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/social/googleplus24.png"),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    110,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                      memberdata.Google != null
                                                          ? memberdata.Google
                                                          : "",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editGoogle = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          //margin: EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              border: new Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: TextFormField(
                                            controller: txtGoogle,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                    "images/social/googleplus24.png"),
                                                hintText: "Google Page"),
                                            keyboardType: TextInputType.url,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          //height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (txtGoogle.text != "") {
                                                  updateProfile('Google',
                                                          txtGoogle.text)
                                                      .then((val) {
                                                    memberdata.Google =
                                                        txtGoogle.text;
                                                    setState(() {
                                                      editGoogle = false;
                                                    });
                                                  }, onError: (e) {
                                                    txtGoogle.text =
                                                        memberdata.Google;
                                                    setState(() {
                                                      editGoogle = false;
                                                    });
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Enter Data First",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      textColor: Colors.black,
                                                      fontSize: 15.0);
                                                }
                                              },
                                              child: Icon(Icons.done_outline)),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              txtGoogle.text =
                                                  memberdata.Google;
                                              setState(() {
                                                editGoogle = false;
                                              });
                                            },
                                            child: Icon(Icons.close))
                                      ],
                                    ),
                            ),
                          ),

                          //Linkedin
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editLinkedin
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/social/linkedin24.png"),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    110,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                      memberdata.Linkedin !=
                                                              null
                                                          ? memberdata.Linkedin
                                                          : "",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editLinkedin = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          //margin: EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              border: new Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: TextFormField(
                                            controller: txtLinkedin,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                    "images/social/linkedin24.png"),
                                                hintText: "Linkedin Page"),
                                            keyboardType: TextInputType.url,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          //height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (txtLinkedin.text != "") {
                                                  updateProfile('Linkedin',
                                                          txtLinkedin.text)
                                                      .then((val) {
                                                    memberdata.Linkedin =
                                                        txtLinkedin.text;
                                                    setState(() {
                                                      editLinkedin = false;
                                                    });
                                                  }, onError: (e) {
                                                    txtLinkedin.text =
                                                        memberdata.Linkedin;
                                                    setState(() {
                                                      editLinkedin = false;
                                                    });
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Enter Data First",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      textColor: Colors.black,
                                                      fontSize: 15.0);
                                                }
                                              },
                                              child: Icon(Icons.done_outline)),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              txtLinkedin.text =
                                                  memberdata.Linkedin;
                                              setState(() {
                                                editLinkedin = false;
                                              });
                                            },
                                            child: Icon(Icons.close))
                                      ],
                                    ),
                            ),
                          ),

                          //Youtube
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editYoutube
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/social/youtube24.png"),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    110,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                      memberdata.Youtube != null
                                                          ? memberdata.Youtube
                                                          : "",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editYoutube = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          //margin: EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              border: new Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: TextFormField(
                                            controller: txtYoutube,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                    "images/social/youtube24.png"),
                                                hintText: "Youtube Page"),
                                            keyboardType: TextInputType.url,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          //height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (txtYoutube.text != "") {
                                                  updateProfile('Youtube',
                                                          txtYoutube.text)
                                                      .then((val) {
                                                    memberdata.Youtube =
                                                        txtYoutube.text;
                                                    setState(() {
                                                      editYoutube = false;
                                                    });
                                                  }, onError: (e) {
                                                    txtYoutube.text =
                                                        memberdata.Youtube;
                                                    setState(() {
                                                      editYoutube = false;
                                                    });
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Enter Data First",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      textColor: Colors.black,
                                                      fontSize: 15.0);
                                                }
                                                setState(() {
                                                  editYoutube = false;
                                                });
                                              },
                                              child: Icon(Icons.done_outline)),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              txtYoutube.text =
                                                  memberdata.Youtube;
                                              setState(() {
                                                editYoutube = false;
                                              });
                                            },
                                            child: Icon(Icons.close))
                                      ],
                                    ),
                            ),
                          ),

                          //Instagram
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editInstagram
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/social/instagram24.png"),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    110,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                      memberdata.Instagram !=
                                                              null
                                                          ? memberdata.Instagram
                                                          : "",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editInstagram = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          //margin: EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              border: new Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: TextFormField(
                                            controller: txtIntagram,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                    "images/social/instagram24.png"),
                                                hintText: "Instagram Page"),
                                            keyboardType: TextInputType.url,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          //height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (txtIntagram.text != "") {
                                                  updateProfile('Instagram',
                                                          txtIntagram.text)
                                                      .then((val) {
                                                    memberdata.Instagram =
                                                        txtIntagram.text;
                                                    setState(() {
                                                      editInstagram = false;
                                                    });
                                                  }, onError: (e) {
                                                    txtIntagram.text =
                                                        memberdata.Instagram;
                                                    setState(() {
                                                      editInstagram = false;
                                                    });
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Enter Data First",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      textColor: Colors.black,
                                                      fontSize: 15.0);
                                                }
                                              },
                                              child: Icon(Icons.done_outline)),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              txtIntagram.text =
                                                  memberdata.Instagram;
                                              setState(() {
                                                editInstagram = false;
                                              });
                                            },
                                            child: Icon(Icons.close))
                                      ],
                                    ),
                            ),
                          ),

                          //About
                          AnimatedSize(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            vsync: this,
                            child: !editAbout
                                ? Row(
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                80,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                                "images/profile/negotiation24.png"),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  110,
                                              child: Text(
                                                  memberdata.About != null
                                                      ? memberdata.About
                                                      : "",
                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              editAbout = true;
                                            });
                                          },
                                          child: Icon(Icons.edit))
                                    ],
                                  )
                                : Row(
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                150,
                                        //margin: EdgeInsets.only(top: 20),
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.5),
                                            border: new Border.all(width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: TextFormField(
                                          controller: txtAbout,
                                          maxLines: 3,
                                          decoration: InputDecoration(
                                              prefixIcon: Image.asset(
                                                  "images/profile/negotiation24.png"),
                                              hintText: "About"),
                                          keyboardType: TextInputType.text,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        //height: 40,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: GestureDetector(
                                            onTap: () {
                                              if (txtAbout.text != "") {
                                                updateProfile(
                                                        'About', txtAbout.text)
                                                    .then((val) {
                                                  memberdata.About =
                                                      txtAbout.text;
                                                  setState(() {
                                                    editAbout = false;
                                                  });
                                                }, onError: (e) {
                                                  txtAbout.text =
                                                      memberdata.About;
                                                  setState(() {
                                                    editAbout = false;
                                                  });
                                                });
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Please Enter Data First",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.TOP,
                                                    backgroundColor:
                                                        Colors.yellow,
                                                    textColor: Colors.black,
                                                    fontSize: 15.0);
                                              }
                                            },
                                            child: Icon(Icons.done_outline)),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            txtAbout.text = memberdata.About;
                                            setState(() {
                                              editAbout = false;
                                            });
                                          },
                                          child: Icon(Icons.close))
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Company View
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border:
                            Border.all(color: Colors.grey[600], width: 0.5)),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text("Company",
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600))),

                          //Company
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editCompany
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/profile/office24.png"),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    110,
                                                child: Text(
                                                    memberdata.Company != null
                                                        ? memberdata.Company
                                                        : "",
                                                    style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editCompany = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          //margin: EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              border: new Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: TextFormField(
                                            controller: txtCompany,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                    "images/profile/office24.png"),
                                                hintText: "Company Name"),
                                            keyboardType: TextInputType.text,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          //height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (txtCompany.text != "") {
                                                  updateProfile('Company',
                                                          txtCompany.text)
                                                      .then((val) {
                                                    memberdata.Company =
                                                        txtCompany.text;
                                                    setState(() {
                                                      editCompany = false;
                                                    });
                                                  }, onError: (e) {
                                                    txtCompany.text =
                                                        memberdata.Company;
                                                    setState(() {
                                                      editCompany = false;
                                                    });
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Enter Data First",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      textColor: Colors.black,
                                                      fontSize: 15.0);
                                                }
                                              },
                                              child: Icon(Icons.done_outline)),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              txtCompany.text =
                                                  memberdata.Company;
                                              setState(() {
                                                editCompany = false;
                                              });
                                            },
                                            child: Icon(Icons.close))
                                      ],
                                    ),
                            ),
                          ),

                          //Role
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editRole
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/profile/role24.png"),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    110,
                                                child: Text(
                                                    memberdata.Role != null
                                                        ? memberdata.Role
                                                        : "",
                                                    style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editRole = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          //margin: EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              border: new Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: TextFormField(
                                            controller: txtRole,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                    "images/profile/role24.png"),
                                                hintText: "Role"),
                                            keyboardType: TextInputType.text,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          //height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (txtRole.text != "") {
                                                  updateProfile(
                                                          'Role', txtRole.text)
                                                      .then((val) {
                                                    memberdata.Role =
                                                        txtRole.text;
                                                    setState(() {
                                                      editRole = false;
                                                    });
                                                  }, onError: (e) {
                                                    txtRole.text =
                                                        memberdata.Role;
                                                    setState(() {
                                                      editRole = false;
                                                    });
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Enter Data First",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      textColor: Colors.black,
                                                      fontSize: 15.0);
                                                }
                                              },
                                              child: Icon(Icons.done_outline)),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              txtRole.text = memberdata.Role;
                                              setState(() {
                                                editRole = false;
                                              });
                                            },
                                            child: Icon(Icons.close))
                                      ],
                                    ),
                            ),
                          ),

                          //Phone
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editPhone
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/profile/telephoneold24.png"),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    110,
                                                child: Text(
                                                    memberdata.CompanyPhone !=
                                                            null
                                                        ? memberdata
                                                            .CompanyPhone
                                                        : "",
                                                    style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editPhone = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          //margin: EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              border: new Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: TextFormField(
                                            controller: txtPhone,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                    "images/profile/telephoneold24.png"),
                                                hintText: "Phone"),
                                            keyboardType: TextInputType.phone,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          //height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (txtPhone.text != "") {
                                                  updateProfile('CompanyPhone',
                                                          txtPhone.text)
                                                      .then((val) {
                                                    memberdata.CompanyPhone =
                                                        txtPhone.text;
                                                    setState(() {
                                                      editPhone = false;
                                                    });
                                                  }, onError: (e) {
                                                    txtPhone.text =
                                                        memberdata.CompanyPhone;
                                                    setState(() {
                                                      editPhone = false;
                                                    });
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Enter Data First",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      textColor: Colors.black,
                                                      fontSize: 15.0);
                                                }
                                              },
                                              child: Icon(Icons.done_outline)),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              txtPhone.text =
                                                  memberdata.CompanyPhone;
                                              setState(() {
                                                editPhone = false;
                                              });
                                            },
                                            child: Icon(Icons.close))
                                      ],
                                    ),
                            ),
                          ),

                          //PAN
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editCompanyPan
                                  ? Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width -
                                        80,
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                            "images/profile/pan.png"),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10),
                                          child: Text(
                                              memberdata.CompanyPAN !=
                                                  null
                                                  ? memberdata.CompanyPAN
                                                  : "",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 15,
                                                  fontWeight:
                                                  FontWeight.w600)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          editCompanyPan = true;
                                        });
                                      },
                                      child: Icon(Icons.edit))
                                ],
                              )
                                  : Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width -
                                        150,
                                    //margin: EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(
                                            255, 255, 255, 0.5),
                                        border: new Border.all(width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: TextFormField(
                                      controller: txtCompanyPAN,
                                      decoration: InputDecoration(
                                          prefixIcon: Image.asset(
                                              "images/profile/pan.png"),
                                          hintText: "PAN No"),
                                      keyboardType: TextInputType.text,
                                      style:
                                      TextStyle(color: Colors.black),
                                    ),
                                    //height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: GestureDetector(
                                        onTap: () {
                                          if (txtCompanyPAN.text != "") {
                                            updateProfile('CompanyPAN',
                                                txtCompanyPAN.text)
                                                .then((val) {
                                              memberdata.CompanyPAN =
                                                  txtCompanyPAN.text;
                                              setState(() {
                                                editCompanyPan = false;
                                              });
                                            }, onError: (e) {
                                              txtCompanyPAN.text =
                                                  memberdata.CompanyPAN;
                                              setState(() {
                                                editCompanyPan = false;
                                              });
                                            });
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                "Please Enter Data First",
                                                toastLength:
                                                Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.TOP,
                                                backgroundColor:
                                                Colors.yellow,
                                                textColor: Colors.black,
                                                fontSize: 15.0);
                                          }
                                        },
                                        child: Icon(Icons.done_outline)),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        txtCompanyPAN.text =
                                            memberdata.CompanyPAN;
                                        setState(() {
                                          editCompanyPan = false;
                                        });
                                      },
                                      child: Icon(Icons.close))
                                ],
                              ),
                            ),
                          ),

                          //GST
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editCompanyGst
                                  ? Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width -
                                        80,
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                            "images/profile/gst.png",height: 24,width: 24),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10),
                                          child: Text(
                                              memberdata.GstNo !=
                                                  null
                                                  ? memberdata.GstNo
                                                  : "",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 15,
                                                  fontWeight:
                                                  FontWeight.w600)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          editCompanyGst = true;
                                        });
                                      },
                                      child: Icon(Icons.edit))
                                ],
                              )
                                  : Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context)
                                        .size
                                        .width -
                                        150,
                                    //margin: EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(
                                            255, 255, 255, 0.5),
                                        border: new Border.all(width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: TextFormField(
                                      controller: txtGstNo,
                                      decoration: InputDecoration(
                                          prefixIcon: Image.asset(
                                              "images/profile/gst.png",height: 10,width: 10),
                                          hintText: "GST No"),
                                      keyboardType: TextInputType.text,
                                      style:
                                      TextStyle(color: Colors.black),
                                    ),
                                    //height: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: GestureDetector(
                                        onTap: () {
                                          if (txtGstNo.text != "") {
                                            updateProfile('GstNo',
                                                txtGstNo.text)
                                                .then((val) {
                                              memberdata.GstNo =
                                                  txtGstNo.text;
                                              setState(() {
                                                editCompanyGst = false;
                                              });
                                            }, onError: (e) {
                                              txtGstNo.text =
                                                  memberdata.GstNo;
                                              setState(() {
                                                editCompanyGst = false;
                                              });
                                            });
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                "Please Enter Data First",
                                                toastLength:
                                                Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.TOP,
                                                backgroundColor:
                                                Colors.yellow,
                                                textColor: Colors.black,
                                                fontSize: 15.0);
                                          }
                                        },
                                        child: Icon(Icons.done_outline)),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        txtGstNo.text =
                                            memberdata.GstNo;
                                        setState(() {
                                          editCompanyGst = false;
                                        });
                                      },
                                      child: Icon(Icons.close))
                                ],
                              ),
                            ),
                          ),

                          //Company Email
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editCompanyEmail
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/profile/gmail24.png"),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    110,
                                                child: Text(
                                                    memberdata.CompanyEmail !=
                                                            null
                                                        ? memberdata
                                                            .CompanyEmail
                                                        : "",
                                                    style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editCompanyEmail = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          //margin: EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              border: new Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: TextFormField(
                                            controller: txtCompanyEmail,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                    "images/profile/gmail24.png"),
                                                hintText: "mail"),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          //height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (txtCompanyEmail.text !=
                                                    "") {
                                                  updateProfile('CompanyEmail',
                                                          txtCompanyEmail.text)
                                                      .then((val) {
                                                    memberdata.CompanyEmail =
                                                        txtCompanyEmail.text;
                                                    setState(() {
                                                      editCompanyEmail = false;
                                                    });
                                                  }, onError: (e) {
                                                    txtCompanyEmail.text =
                                                        memberdata.CompanyEmail;
                                                    setState(() {
                                                      editCompanyEmail = false;
                                                    });
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Enter Data First",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      textColor: Colors.black,
                                                      fontSize: 15.0);
                                                }
                                              },
                                              child: Icon(Icons.done_outline)),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              txtCompanyEmail.text =
                                                  memberdata.CompanyEmail;
                                              setState(() {
                                                editCompanyEmail = false;
                                              });
                                            },
                                            child: Icon(Icons.close))
                                      ],
                                    ),
                            ),
                          ),

                          //Company Website
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editCompanyUrl
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/profile/domain24.png"),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    110,
                                                child: Text(
                                                    memberdata.CompanyUrl !=
                                                            null
                                                        ? memberdata.CompanyUrl
                                                        : "",
                                                    style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editCompanyUrl = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          //margin: EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              border: new Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: TextFormField(
                                            controller: txtCompanyUrl,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                    "images/profile/domain24.png"),
                                                hintText: "Website"),
                                            keyboardType: TextInputType.url,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          //height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (txtCompanyUrl.text != "") {
                                                  updateProfile('CompanyUrl',
                                                          txtCompanyUrl.text)
                                                      .then((val) {
                                                    memberdata.CompanyUrl =
                                                        txtCompanyUrl.text;
                                                    setState(() {
                                                      editCompanyUrl = false;
                                                    });
                                                  }, onError: (e) {
                                                    txtCompanyUrl.text =
                                                        memberdata.CompanyUrl;
                                                    setState(() {
                                                      editCompanyUrl = false;
                                                    });
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Enter Data First",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      textColor: Colors.black,
                                                      fontSize: 15.0);
                                                }
                                              },
                                              child: Icon(Icons.done_outline)),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              txtCompanyUrl.text =
                                                  memberdata.CompanyUrl;
                                              setState(() {
                                                editCompanyUrl = false;
                                              });
                                            },
                                            child: Icon(Icons.close))
                                      ],
                                    ),
                            ),
                          ),

                          //Comapny Address
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              vsync: this,
                              child: !editCompanyAddress
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width -
                                                  80,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                  "images/profile/google24.png"),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    110,
                                                child: Text(
                                                    memberdata.CompanyAddress !=
                                                            null
                                                        ? memberdata
                                                            .CompanyAddress
                                                        : "",
                                                    style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editCompanyAddress = true;
                                              });
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width -
                                                  150,
                                          //margin: EdgeInsets.only(top: 20),
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.5),
                                              border: new Border.all(width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: TextFormField(
                                            maxLines: 5,
                                            controller: txtAddress,
                                            decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                    "images/profile/google24.png"),
                                                hintText: "Address"),
                                            keyboardType: TextInputType.text,
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          //height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: GestureDetector(
                                              onTap: () {
                                                if (txtAddress.text != "") {
                                                  updateProfile('CompanyAddress',
                                                          txtAddress.text)
                                                      .then((val) {
                                                    memberdata.CompanyAddress =
                                                        txtAddress.text;
                                                    setState(() {
                                                      editCompanyAddress = false;
                                                    });
                                                  }, onError: (e) {
                                                    txtAddress.text =
                                                        memberdata.CompanyAddress;
                                                    setState(() {
                                                      editCompanyAddress = false;
                                                    });
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Enter Data First",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.TOP,
                                                      backgroundColor:
                                                          Colors.yellow,
                                                      textColor: Colors.black,
                                                      fontSize: 15.0);
                                                }
                                              },
                                              child: Icon(Icons.done_outline)),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              txtAddress.text =
                                                  memberdata.CompanyAddress;
                                              setState(() {
                                                editCompanyAddress = false;
                                              });
                                            },
                                            child: Icon(Icons.close))
                                      ],
                                    ),
                            ),
                          ),

                          //About
                          AnimatedSize(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            vsync: this,
                            child: !editCompanyAbout
                                ? Row(
                              children: <Widget>[
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width -
                                      80,
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                          "images/profile/negotiation24.png"),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10),
                                        width: MediaQuery.of(context)
                                            .size
                                            .width -
                                            110,
                                        child: Text(
                                            memberdata.AboutCompany != null
                                                ? memberdata.AboutCompany
                                                : "",
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.w600)),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        editCompanyAbout = true;
                                      });
                                    },
                                    child: Icon(Icons.edit))
                              ],
                            )
                                : Row(
                              children: <Widget>[
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width -
                                      150,
                                  //margin: EdgeInsets.only(top: 20),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(
                                          255, 255, 255, 0.5),
                                      border: new Border.all(width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5))),
                                  child: TextFormField(
                                    controller: txtAboutCompany,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                        prefixIcon: Image.asset(
                                            "images/profile/negotiation24.png"),
                                        hintText: "About Company"),
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  //height: 40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: GestureDetector(
                                      onTap: () {
                                        if (txtAboutCompany.text != "") {
                                          updateProfile(
                                              'AboutCompany', txtAboutCompany.text)
                                              .then((val) {
                                            memberdata.AboutCompany =
                                                txtAboutCompany.text;
                                            setState(() {
                                              editCompanyAbout = false;
                                            });
                                          }, onError: (e) {
                                            txtAboutCompany.text =
                                                memberdata.AboutCompany;
                                            setState(() {
                                              editCompanyAbout = false;
                                            });
                                          });
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                              "Please Enter Data First",
                                              toastLength:
                                              Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.TOP,
                                              backgroundColor:
                                              Colors.yellow,
                                              textColor: Colors.black,
                                              fontSize: 15.0);
                                        }
                                      },
                                      child: Icon(Icons.done_outline)),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      txtAboutCompany.text = memberdata.AboutCompany;
                                      setState(() {
                                        editCompanyAbout = false;
                                      });
                                    },
                                    child: Icon(Icons.close))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          isLoading ? LoadinComponent() : Container()
        ],
      ),
    ));
  }

  void _coverImagePopup(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera_alt),
                    title: new Text('Camera'),
                    onTap: () async {
                      var image = await ImagePicker.pickImage(
                          source: ImageSource.camera);
                      if (image != null)
                        setState(() {
                          _imageCover = image;
                          _editCoverImg = true;
                        });
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: new Icon(Icons.photo),
                    title: new Text('Gallery'),
                    onTap: () async {
                      var image = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (image != null)
                        setState(() {
                          _imageCover = image;
                          _editCoverImg = true;
                        });
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }

  void _profileImagePopup(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera_alt),
                    title: new Text('Camera'),
                    onTap: () async {
                      var image = await ImagePicker.pickImage(
                          source: ImageSource.camera);
                      if (image != null)
                        setState(() {
                          _imageProfile = image;
                          _editProfileImg = true;
                        });
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: new Icon(Icons.photo),
                    title: new Text('Gallery'),
                    onTap: () async {
                      var image = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (image != null)
                        setState(() {
                          _imageProfile = image;
                          _editProfileImg = true;
                        });
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        });
  }
}
