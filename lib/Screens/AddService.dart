import 'dart:io';

import 'package:flutter/material.dart';
import 'package:digitalcard/Component/OfferComponent.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Component/HeaderComponent.dart';
import 'package:digitalcard/Component/ImagePickerHandlerComponent.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService>
    with TickerProviderStateMixin, ImagePickerListener {
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  TextEditingController txtDate = new TextEditingController();
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
                title: "Add Service",
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
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.title), hintText: "Title"),
                          keyboardType: TextInputType.number,
                          style: TextStyle(color: Colors.black),
                        ),
                        //height: 40,
                        width: MediaQuery.of(context).size.width - 40,
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
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.description),
                              hintText: "Description"),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                        ),
                        //height: 40,
                        width: MediaQuery.of(context).size.width - 40,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        margin: EdgeInsets.only(top: 10),
                        child: RaisedButton(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            elevation: 5,
                            textColor: Colors.white,
                            color: cnst.buttoncolor,
                            child: Text("Add Service",
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
