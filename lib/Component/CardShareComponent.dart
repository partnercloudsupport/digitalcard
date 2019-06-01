import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:digitalcard/Common/Services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardShareComponent extends StatefulWidget {
  final String memberId;
  final String memberName;
  final bool isRegular;

  const CardShareComponent(
      {Key key, this.memberId, this.memberName, this.isRegular})
      : super(key: key);

  @override
  _CardShareComponentState createState() => _CardShareComponentState();
}

class _CardShareComponentState extends State<CardShareComponent> {
  TextEditingController txtName = new TextEditingController();
  TextEditingController txtMobile = new TextEditingController();

  String sender = "";
  Iterable<Contact> _contacts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  showMsg(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Digital Card"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.disabled) {
      Map<PermissionGroup, PermissionStatus> permissionStatus =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.contacts]);
      return permissionStatus[PermissionGroup.contacts] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to location data denied",
          details: null);
    } else if (permissionStatus == PermissionStatus.disabled) {
      throw new PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }

  String ShareMessage() {
    String shareMessage = cnst.shareMessage;
    String url = cnst.profileUrl;

    //Replace static string with userid
    url = url.replaceAll("#id", widget.memberId);

    //Replace static string with recever
    String urlwithrecever =
        shareMessage.replaceAll("#recever", txtName.text.trim());

    //Replace static string with Sender
    String urlwithsender =
        urlwithrecever.replaceAll("#sender", widget.memberName);

    //Replace static string with Link
    String urlwithprofilelink =
        urlwithsender.replaceAll("#link", Uri.encodeComponent(url));

    return urlwithprofilelink;
  }

  SaveShare(String val, bool isurl) async {
    if (isurl == true)
      launch(val);
    else
      Share.share(val);

    var data = {
      'type': 'share',
      'name': txtName.text.trim(),
      'mobile': txtMobile.text.trim(),
      'memberid': widget.memberId.toString(),
    };

    Future res = Services.SaveShare(data);
    res.then((data) {
      if (data != null && data.ERROR_STATUS == false) {
        print("Share Saved");
      } else {
        print("Saher Not Saved");
      }
      Navigator.pop(context);
    }, onError: (e) {
      print(e.toString());
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.90),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widget.isRegular != null && widget.isRegular == true
                    ? Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Text("Share Your Digital Card",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                            TextField(
                              controller: txtName,
                              decoration: InputDecoration(
                                  border: new OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.teal)),
                                  hintText: 'Name',
                                  labelText: 'Name',
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.green,
                                  ),
                                  suffixStyle:
                                      const TextStyle(color: Colors.green)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: TextFormField(
                                controller: txtMobile,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.teal)),
                                    hintText: 'Mobile',
                                    labelText: 'Mobile',
                                    prefixIcon: const Icon(
                                      Icons.phone_android,
                                      color: Colors.green,
                                    ),
                                    suffixStyle:
                                        const TextStyle(color: Colors.green)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  MaterialButton(
                                    onPressed: () {
                                      if (txtName.text.trim() != null &&
                                          txtName.text.trim() != "" &&
                                          txtMobile.text.trim() != null &&
                                          txtMobile.text.trim() != "" &&
                                          txtMobile.text.trim().length == 10) {
                                        String whatsAppLink = cnst.whatsAppLink;

                                        String msg = ShareMessage();

                                        String urlwithmobile =
                                            whatsAppLink.replaceAll("#mobile",
                                                "91${txtMobile.text.trim()}");
                                        String urlwithmsg = urlwithmobile
                                            .replaceAll("#msg", msg);

                                        SaveShare(urlwithmsg, true);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Please fill all details",
                                            backgroundColor: Colors.red,
                                            gravity: ToastGravity.TOP,
                                            toastLength: Toast.LENGTH_SHORT);
                                      }
                                    },
                                    child: Image.asset(
                                      "images/social/whatsapp.png",
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.contain,
                                    ),
                                    minWidth: 30,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      if (txtName.text.trim() != null &&
                                          txtName.text.trim() != "" &&
                                          txtMobile.text.trim() != null &&
                                          txtMobile.text.trim() != "" &&
                                          txtMobile.text.trim().length == 10) {
                                        String smsLink = cnst.smsLink;

                                        String msg = ShareMessage();

                                        String urlwithmobile =
                                            smsLink.replaceAll("#mobile",
                                                "91${txtMobile.text.trim()}");
                                        String urlwithmsg = urlwithmobile
                                            .replaceAll("#msg", msg);

                                        SaveShare(urlwithmsg, true);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Please fill all details",
                                            backgroundColor: Colors.red,
                                            gravity: ToastGravity.TOP,
                                            toastLength: Toast.LENGTH_SHORT);
                                      }
                                    },
                                    child: Image.asset(
                                      "images/social/chat.png",
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.contain,
                                    ),
                                    minWidth: 30,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      if (txtName.text.trim() != null &&
                                          txtName.text.trim() != "" &&
                                          txtMobile.text.trim() != null &&
                                          txtMobile.text.trim() != "" &&
                                          txtMobile.text.trim().length == 10) {
                                        String mailLink = cnst.mailLink;
                                        String msg = ShareMessage();

                                        String urlwithmail =
                                            mailLink.replaceAll("#mail", "");
                                        String urlwithsubject =
                                            urlwithmail.replaceAll("#subject",
                                                "$sender Digital Card");
                                        String urlwithmsg = urlwithsubject
                                            .replaceAll("#msg", msg);

                                        SaveShare(urlwithmsg, true);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Please fill all details",
                                            backgroundColor: Colors.red,
                                            gravity: ToastGravity.TOP,
                                            toastLength: Toast.LENGTH_SHORT);
                                      }
                                    },
                                    child: Image.asset(
                                      "images/social/mail.png",
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.contain,
                                    ),
                                    minWidth: 30,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  MaterialButton(
                                    onPressed: () async {
                                      if (txtName.text.trim() != null &&
                                          txtName.text.trim() != "" &&
                                          txtMobile.text.trim() != null &&
                                          txtMobile.text.trim() != "" &&
                                          txtMobile.text.trim().length == 10) {
                                        PermissionStatus permissionStatus =
                                            await _getContactPermission();
                                        try {
                                          if (permissionStatus ==
                                              PermissionStatus.granted) {
                                            Item item = Item(
                                                label: 'office',
                                                value: txtMobile.text
                                                    .trim()
                                                    .toString());

                                            Contact newContact = new Contact(
                                                givenName: txtName.text.trim(),
                                                phones: [item]);

                                            await ContactsService.addContact(
                                                newContact);
                                            Fluttertoast.showToast(
                                                msg: "Contact saved to phone",
                                                backgroundColor: Colors.green,
                                                gravity: ToastGravity.TOP,
                                                toastLength:
                                                    Toast.LENGTH_SHORT);
                                          } else {
                                            _handleInvalidPermissions(
                                                permissionStatus);
                                          }
                                        } catch (ex) {
                                          print(ex.toString());
                                          if (ex.toString() ==
                                              "PlatformException(PERMISSION_DENIED, Access to location data denied, null)") {
                                            showMsg(
                                                "Access permission is denied by user. \nplease go to setting -> app -> digitalcard -> permission, and allow permission");
                                          }
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Please fill all details",
                                            backgroundColor: Colors.red,
                                            gravity: ToastGravity.TOP,
                                            toastLength: Toast.LENGTH_SHORT);
                                      }
                                    },
                                    color: cnst.appcolor,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.contact_phone,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text("Save contact",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                    minWidth: 30,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      if (txtName.text.trim() != null &&
                                          txtName.text.trim() != "" &&
                                          txtMobile.text.trim() != null &&
                                          txtMobile.text.trim() != "" &&
                                          txtMobile.text.trim().length == 10) {
                                        String msg = ShareMessage();

                                        SaveShare(msg, false);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Please fill all details",
                                            backgroundColor: Colors.red,
                                            gravity: ToastGravity.TOP,
                                            toastLength: Toast.LENGTH_SHORT);
                                      }
                                    },
                                    color: cnst.appcolor,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.share,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text("More...",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                    minWidth: 30,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                                child: Image.asset('images/addmoney.png',height: 80,width: 80)
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("Your trial is expired!",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1)),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Text(
                                    "you can pay online by clicking on bellow button",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0))),
                            MaterialButton(
                              minWidth: MediaQuery.of(context).size.width - 40,
                              color: Colors.green,
                              child: Text('Pay Online',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              padding: EdgeInsets.all(10),
                              onPressed: () => Navigator.pushNamed(context, '/Payment'),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 10,bottom: 10),
                                child: Text(
                                    "Or contact to digital card team for purchase / renewal.",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text("Arpit R Shah \n9879208321",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1)),
                                GestureDetector(
                                    onTap: () {
                                      launch("tel:9879208321");
                                    },
                                    child: Icon(Icons.phone_in_talk,
                                        size: 40, color: cnst.appcolor))
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text("Thank you,\nRegards\nDigital Card",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600))),
                          ],
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 50,
                      color: Colors.grey.shade700,
                    ),
                    minWidth: 30,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
