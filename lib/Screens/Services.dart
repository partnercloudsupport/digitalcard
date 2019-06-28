import 'package:flutter/material.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Component/HeaderComponent.dart';
import 'package:digitalcard/Component/ServiceComponent.dart';
import 'package:digitalcard/Common/ClassList.dart';
import 'package:digitalcard/Common/Services.dart';
import 'package:digitalcard/Component/LoadinComponent.dart';
import 'package:digitalcard/Component/NoDataComponent.dart';

class MemberServices extends StatefulWidget {
  @override
  _MemberServicesState createState() => _MemberServicesState();
}

class _MemberServicesState extends State<MemberServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: cnst.buttoncolor,
          onPressed: () => Navigator.pushNamed(context, "/AddService"),
          child: Icon(Icons.add),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              HeaderComponent(
                title: "Services",
                image: "images/header/servicehearde.jpg",
                boxheight: 150,
              ),
              Container(
                  height: MediaQuery.of(context).size.height - 160,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.only(top: 100),
                  child: FutureBuilder<List<ServicesClass>>(
                    future: Services.GetMemberServices(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return snapshot.connectionState == ConnectionState.done
                          ? snapshot.hasData
                              ? ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ServiceComponent(
                                        snapshot.data[index]);
                                  },
                                )
                              : NoDataComponent()
                          : LoadinComponent();
                    },
                  ))
            ],
          ),
        ));
  }
}
