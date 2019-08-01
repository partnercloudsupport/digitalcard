import 'package:flutter/material.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Common/ClassList.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareHistoryComponent extends StatelessWidget {
  final ShareClass shareClass;

  const ShareHistoryComponent(this.shareClass);

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
    return Card(
      elevation: 2,
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  //width: MediaQuery.of(context).size.width - 220,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(10)),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(shareClass.Name,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: cnst.appcolor)),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(shareClass.MobileNo,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[600])),
                      )
                    ],
                  ),
                ),
                Container(
                    width: 92,
                    height: 60,
                    decoration: BoxDecoration(
                      color: cnst.buttoncolor,
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(shareClass.Date.substring(0, 2),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15)),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                              shareClass.Date.substring(
                                  3, shareClass.Date.length),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                        ),
                      ],
                    ))
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: MaterialButton(
                    onPressed: () async {
                      PermissionStatus permissionStatus =
                          await _getContactPermission();
                      try {
                        if (permissionStatus == PermissionStatus.granted) {
                          Item item =
                              Item(label: 'office', value: shareClass.MobileNo);

                          Contact newContact = new Contact(
                              givenName: shareClass.Name, phones: [item]);

                          await ContactsService.addContact(newContact);
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
                          Fluttertoast.showToast(
                              msg:
                                  "Access permission is denied by user. \nplease go to setting -> app -> digitalcard -> permission, and allow permission",
                              backgroundColor: Colors.yellow,
                              gravity: ToastGravity.TOP,
                              toastLength: Toast.LENGTH_LONG);
                        }
                      }
                    },
                    color: cnst.appcolor,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Icon(
                            Icons.contact_phone,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text("Save",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                      ],
                    ),

                    minWidth: MediaQuery.of(context).size.width/2.28,
                    height: 35,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: MaterialButton(
                    onPressed: () {
                      launch("tel:"+shareClass.MobileNo);
                    },
                    color: Colors.green,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text("Call",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                    minWidth: MediaQuery.of(context).size.width/2.28,
                    height: 35,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
