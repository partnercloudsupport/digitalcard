import 'dart:io';

import 'package:flutter/material.dart';
import 'package:digitalcard/Component/OfferComponent.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Component/HeaderComponent.dart';
import 'package:digitalcard/Component/ImagePickerHandlerComponent.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class AddOffer extends StatefulWidget {
  @override
  _AddOfferState createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer>
    with TickerProviderStateMixin, ImagePickerListener {
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  TextEditingController txtTitle = new TextEditingController();
  TextEditingController txtDate = new TextEditingController();
  TextEditingController txtDesc = new TextEditingController();

  DateTime date = new DateTime.now();

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
            title: "Add Offers",
            image: "images/header/offerheader.jpg",
            boxheight: 100,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 100,
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.only(top: 110),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        border: new Border.all(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: TextFormField(
                      controller: txtTitle,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.title), hintText: "Title"),
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                    ),
                    //height: 40,
                    width: MediaQuery.of(context).size.width - 40,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            DatePicker.showDatePicker(
                              context,
                              showTitleActions: true,
                              locale: 'en',
                              minYear: 1970,
                              maxYear: 2020,
                              initialYear: DateTime.now().year,
                              initialMonth: DateTime.now().month,
                              initialDate: DateTime.now().day,
                              cancel: Text('cancel'),
                              confirm: Text('confirm'),
                              dateFormat: 'dd-mmm-yyyy',
                              onChanged: (year, month, date) {},
                              onConfirm: (year, month, date) {
                                txtDate.text = year.toString() +
                                    '-' +
                                    month.toString() +
                                    '-' +
                                    date.toString();
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 0.5),
                                border: new Border.all(width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(5))),
                            child: TextFormField(
                              controller: txtDate,
                              enabled: false,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_today), hintText: "Date"),
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.black),
                            ),
                            //height: 40,
                            width: MediaQuery.of(context).size.width - 80,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                        ),
                        GestureDetector(
                            onTap: () {
                              txtDate.text = "";
                            },
                            child: Icon(Icons.close)),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.5),
                        border: new Border.all(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: TextFormField(
                      maxLines: 5,
                      controller: txtDesc,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.description),
                          hintText: "Description"),
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black),
                    ),
                    //height: 40,
                    width: MediaQuery.of(context).size.width - 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () => imagePicker.showDialog(context),
                      child: new Center(
                        child: _image == null
                            ? Image.asset(
                                "images/logo.png",
                                height: MediaQuery.of(context).size.width - 100,
                                width: MediaQuery.of(context).size.width - 100,
                              )
                            : new Container(
                                height: MediaQuery.of(context).size.width - 100,
                                width: MediaQuery.of(context).size.width - 100,
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
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    margin: EdgeInsets.only(top: 10),
                    child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        elevation: 5,
                        textColor: Colors.white,
                        color: cnst.buttoncolor,
                        child: Text("Add Offer",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15)),
                        onPressed: () {
                          Navigator.pushNamed(context, "/Dashboard");
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
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
