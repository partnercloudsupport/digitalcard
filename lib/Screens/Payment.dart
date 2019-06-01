import 'dart:convert';

import 'package:digitalcard/Common/Services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_plugin/razorpay_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Common/ClassList.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String MemberId = "";
  String Name = "";
  String Mobile = "";
  String Email = "";
  String Amount = "100";
  String PaymentStatus = "InProcess";
  String PaymentMessage = "";
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetLocalData();
  }

  GetLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String memberId = prefs.getString(cnst.Session.MemberId);
    String name = prefs.getString(cnst.Session.Name);
    String mobile = prefs.getString(cnst.Session.Mobile);
    String email = prefs.getString(cnst.Session.Email);

    if (memberId != null && memberId != "")
      setState(() {
        MemberId = memberId;
      });
    if (name != null && name != "")
      setState(() {
        Name = name;
      });
    if (mobile != null && mobile != "")
      setState(() {
        Mobile = mobile;
      });
    if (email != null && email != "")
      setState(() {
        Email = email;
      });
  }

  startPayment() async {
    Map<String, dynamic> options = new Map();
    options.putIfAbsent("name", () => 'Digital Card');
    options.putIfAbsent(
        "image", () => " https://kavitabatras.com/Resources/logo.png");
    options.putIfAbsent("description", () => "buy digitalcad online");
    options.putIfAbsent("amount", () => Amount);
    options.putIfAbsent("email", () => Email);
    options.putIfAbsent("contact", () => Mobile);
    //Must be a valid HTML color.
    options.putIfAbsent("theme", () => "#FF0000");
    options.putIfAbsent("api_key", () => "rzp_live_ud7vCnNUUZNr9F");
    await Razorpay.showPaymentForm(options).then((paymentResponse) {
      if (paymentResponse != null) {
        if (paymentResponse['code'] == "1") {
          setState(() {
            PaymentStatus = "Success";
            PaymentMessage = paymentResponse['message'];
          });
          cardPayment();
        } else
          setState(() {
            PaymentStatus = "Error";
            PaymentMessage = paymentResponse['message'];
          });
      }

      print("response $paymentResponse");
    });
  }

  cardPayment() {
    setState(() {
      isLoading = true;
    });
    var data = {
      'type': 'payment',
      'points': '0',
      'orderno': PaymentMessage,
      'memberid': MemberId,
      'paymenttype': 'Online',
      'amount': (int.parse(Amount) / 100).toString(),
    };
    print(data);
    Services.CardPayment(data).then((data) {
      if (data != null && data.ERROR_STATUS == false) {
        Fluttertoast.showToast(
            msg: "Payment Saved",
            backgroundColor: Colors.green,
            gravity: ToastGravity.TOP);
        setState(() {
          isLoading = false;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Data Not Saved " + data.MESSAGE,
            backgroundColor: Colors.red,
            gravity: ToastGravity.TOP,
            toastLength: Toast.LENGTH_LONG);
        setState(() {
          isLoading = false;
        });
      }
    }, onError: (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Data Not Saved" + e.toString(), backgroundColor: Colors.red);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Card Payment',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
              PaymentStatus == 'InProcess'
                  ? Card(
                      margin: EdgeInsets.all(20),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Buy Digital Card',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600)),
                            Divider(),
                            Row(
                              children: <Widget>[
                                Container(
                                    width: 90,
                                    child: Text('Name',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey.shade600))),
                                Text('$Name',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade600)),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      width: 90,
                                      child: Text('Mobile',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade600))),
                                  Text('$Mobile',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade600)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      width: 90,
                                      child: Text('Email',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade600))),
                                  Container(
                                      width: MediaQuery.of(context).size.width -
                                          170,
                                      child: Text('$Email',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade600))),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 20),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      width: 90,
                                      child: Text('Amount',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade600))),
                                  Text('${int.parse(Amount) / 100}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade600)),
                                ],
                              ),
                            ),
                            MaterialButton(
                              minWidth: MediaQuery.of(context).size.width - 80,
                              color: Colors.green,
                              child: Text('Pay Now',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              padding: EdgeInsets.all(10),
                              onPressed: () => startPayment(),
                            )
                          ],
                        ),
                      ),
                    )
                  : PaymentStatus == 'Success'
                      ? Card(
                          margin: EdgeInsets.all(20),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.network(
                                  'https://cdn4.iconfinder.com/data/icons/generic-interaction/143/yes-tick-success-done-complete-check-allow-512.png',
                                  height: 100,
                                  width: 100,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text('OrderID : $PaymentMessage',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade600)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 20),
                                  child: Text('Payment Done Successfully',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade600)),
                                ),
                                MaterialButton(
                                  minWidth:
                                      MediaQuery.of(context).size.width - 80,
                                  color: Colors.green,
                                  child: Text('Go Back To Home',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                  padding: EdgeInsets.all(10),
                                  onPressed: () =>
                                      Navigator.pushReplacementNamed(
                                          context, '/Dashboard'),
                                )
                              ],
                            ),
                          ),
                        )
                      : Card(
                          margin: EdgeInsets.all(20),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.network(
                                  'https://www.safetysign.com/images/source/large-images/J6520.png',
                                  height: 100,
                                  width: 100,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Text('$PaymentMessage',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade600)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 20),
                                  child: Text(
                                      'Payment Faild \nTry After Some Time',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade600)),
                                ),
                                MaterialButton(
                                  minWidth:
                                      MediaQuery.of(context).size.width - 80,
                                  color: Colors.green,
                                  child: Text('Go Back To Home',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                  padding: EdgeInsets.all(10),
                                  onPressed: () =>
                                      Navigator.pushReplacementNamed(
                                          context, '/Dashboard'),
                                )
                              ],
                            ),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
