import 'dart:convert';

import 'package:flutter/material.dart';
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
  String Amount = "500";
  String PaymentStatus = "InProcess";
  String PaymentMessage = "payment message";

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
    options.putIfAbsent("name", () => Name);
    options.putIfAbsent("image", () => "http://digitalcard.co.in/Resources/logo.png");
    options.putIfAbsent("description", () => "buy digitalcad online");
    options.putIfAbsent("amount", () => Amount);
    options.putIfAbsent("email", () => Email);
    options.putIfAbsent("contact", () => Mobile);
    //Must be a valid HTML color.
    options.putIfAbsent("theme", () => "#FF0000");
    options.putIfAbsent("api_key", () => "rzp_live_ud7vCnNUUZNr9F");
    //Map<dynamic,dynamic> paymentResponse = new Map();
    //paymentResponse = await Razorpay.showPaymentForm(options);
    await Razorpay.showPaymentForm(options).then((paymentResponse){
      final jsonResponse = json.decode(paymentResponse.toString());
      PaymentDataClass paymentDataClass = new PaymentDataClass.fromJson(jsonResponse);
      if(paymentDataClass != null){
        if(paymentDataClass.code == 1)
          setState(() {
            PaymentStatus = "Success";
            PaymentMessage = paymentDataClass.message;
          });
        else
          setState(() {
            PaymentStatus = "Error";
            PaymentMessage = paymentDataClass.message;
          });
      }

      print("response $paymentResponse");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Card Payment'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              PaymentStatus == 'InProcess' ?
              Card(
                margin: EdgeInsets.all(20),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Buy Digital Card',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.grey.shade600)),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Container(width: 90, child: Text('Name',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey.shade600))),
                          Text('$Name',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey.shade600)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Container(width: 90, child: Text('Mobile',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey.shade600))),
                            Text('$Mobile',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey.shade600)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Container(width: 90, child: Text('Email',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey.shade600))),
                            Text('$Email',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey.shade600)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 20),
                        child: Row(
                          children: <Widget>[
                            Container(width: 90, child: Text('Amount',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey.shade600))),
                            Text('$Amount',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey.shade600)),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width - 80,
                        color: Colors.green,
                        child: Text('Pay Now',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w600)),
                        padding: EdgeInsets.all(10),
                        onPressed: () => startPayment(),
                      )
                    ],
                  ),
                ),
              ) :
              PaymentStatus == 'Success' ?
              Card(
                margin: EdgeInsets.all(20),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.network('https://cdn4.iconfinder.com/data/icons/generic-interaction/143/yes-tick-success-done-complete-check-allow-512.png',
                      height: 100,width: 100,),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text('OrderID : $PaymentMessage',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey.shade600)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 20),
                        child: Text('Payment Done Successfully',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.grey.shade600)),
                      ),
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width - 80,
                        color: Colors.green,
                        child: Text('Go Back To Home',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w600)),
                        padding: EdgeInsets.all(10),
                        onPressed: () => startPayment(),
                      )
                    ],
                  ),
                ),
              ) :
              Card(
                margin: EdgeInsets.all(20),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.network('https://www.safetysign.com/images/source/large-images/J6520.png',
                        height: 100,width: 100,),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text('$PaymentMessage',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey.shade600)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 20),
                        child: Text('Payment Faild \nTry After Some Time',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.grey.shade600)),
                      ),
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width - 80,
                        color: Colors.green,
                        child: Text('Go Back To Home',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w600)),
                        padding: EdgeInsets.all(10),
                        onPressed: () => startPayment(),
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
