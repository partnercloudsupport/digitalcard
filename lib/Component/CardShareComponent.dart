import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class CardShareComponent extends StatefulWidget {
  @override
  _CardShareComponentState createState() => _CardShareComponentState();
}

class _CardShareComponentState extends State<CardShareComponent> {
  TextEditingController txtName = new TextEditingController();
  TextEditingController txtMobile = new TextEditingController();

  String sender = "Kapil R Singh";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.90),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 20)),
              Text("Share Your Digital Card",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: txtName,
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal)),
                          hintText: 'Name',
                          labelText: 'Name',
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.green,
                          ),
                          suffixStyle: const TextStyle(color: Colors.green)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        controller: txtMobile,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.teal)),
                            hintText: 'Mobile',
                            labelText: 'Mobile',
                            prefixIcon: const Icon(
                              Icons.phone_android,
                              color: Colors.green,
                            ),
                            suffixStyle: const TextStyle(color: Colors.green)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () {
                              if (txtName.text != null &&
                                  txtName.text != "" &&
                                  txtMobile.text != null &&
                                  txtMobile.text != "") {
                                String whatsAppLink = cnst.whatsAppLink;
                                String shareMessage = cnst.shareMessage;
                                String url = cnst.profileUrl;

                                //Replace static string with userid
                                url = url.replaceAll("#id", '1');

                                //Replace static string with userid
                                String urlwithrecever = shareMessage.replaceAll(
                                    "#recever", txtName.text);
                                String urlwithsender = urlwithrecever
                                    .replaceAll("#sender", sender);
                                String urlwithprofilelink =
                                    urlwithsender.replaceAll(
                                        "#link", Uri.encodeComponent(url));

                                String urlwithmobile = whatsAppLink.replaceAll(
                                    "#mobile", "91${txtMobile.text}");
                                String urlwithmsg = urlwithmobile.replaceAll(
                                    "#msg", urlwithprofilelink);

                                launch(urlwithmsg.toString());
                                Navigator.pop(context);
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
                              if (txtName.text != null &&
                                  txtName.text != "" &&
                                  txtMobile.text != null &&
                                  txtMobile.text != "") {
                                String smsLink = cnst.smsLink;
                                String shareMessage = cnst.shareMessage;
                                String url = cnst.profileUrl;

                                //Replace static string with userid
                                url = url.replaceAll("#id", '1');

                                //Replace static string with userid
                                String urlwithrecever = shareMessage.replaceAll(
                                    "#recever", txtName.text);
                                String urlwithsender = urlwithrecever
                                    .replaceAll("#sender", sender);
                                String urlwithprofilelink =
                                    urlwithsender.replaceAll(
                                        "#link", Uri.encodeComponent(url));

                                String urlwithmobile = smsLink.replaceAll(
                                    "#mobile", "91${txtMobile.text}");
                                String urlwithmsg = urlwithmobile.replaceAll(
                                    "#msg", urlwithprofilelink);

                                launch(urlwithmsg.toString());
                                Navigator.pop(context);
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
                              if (txtName.text != null &&
                                  txtName.text != "" &&
                                  txtMobile.text != null &&
                                  txtMobile.text != "") {
                                String mailLink = cnst.mailLink;
                                String shareMessage = cnst.shareMessage;
                                String url = cnst.profileUrl;

                                //Replace static string with userid
                                url = url.replaceAll("#id", '1');

                                //Replace static string with userid
                                String urlwithrecever = shareMessage.replaceAll(
                                    "#recever", txtName.text);
                                String urlwithsender = urlwithrecever
                                    .replaceAll("#sender", sender);
                                String urlwithprofilelink =
                                    urlwithsender.replaceAll(
                                        "#link", Uri.encodeComponent(url));

                                String urlwithmail =
                                    mailLink.replaceAll("#mail", "");
                                String urlwithsubject = urlwithmail.replaceAll(
                                    "#subject", "$sender Digital Card");
                                String urlwithmsg = urlwithsubject.replaceAll(
                                    "#msg", urlwithprofilelink);

                                launch(urlwithmsg.toString());
                                Navigator.pop(context);
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          MaterialButton(
                            onPressed: () async {
                              if (txtName.text != null &&
                                  txtName.text != "" &&
                                  txtMobile.text != null &&
                                  txtMobile.text != "") {
                                PermissionStatus permissionStatus =
                                    await _getContactPermission();
                                try {
                                  if (permissionStatus ==
                                      PermissionStatus.granted) {
                                    Item item = Item(
                                        label: 'office',
                                        value: txtMobile.text.toString());

                                    Contact newContact = new Contact(
                                        givenName: txtName.text,
                                        phones: [item]);

                                    await ContactsService.addContact(
                                        newContact);
                                    Fluttertoast.showToast(
                                        msg: "Contact saved to phone",
                                        backgroundColor: Colors.green,
                                        gravity: ToastGravity.TOP,
                                        toastLength: Toast.LENGTH_SHORT);
                                  } else {
                                    _handleInvalidPermissions(permissionStatus);
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
                                  padding: const EdgeInsets.only(left: 10),
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
                              if (txtName.text != null &&
                                  txtName.text != "" &&
                                  txtMobile.text != null &&
                                  txtMobile.text != "") {
                                Share.share("Share Text");
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
                                  padding: const EdgeInsets.only(left: 10),
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
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: MaterialButton(
                        onPressed: (){
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
              )
            ],
          ),
        ));
  }
}
