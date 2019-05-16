import 'package:flutter/material.dart';
import 'package:digitalcard/Component/EarnComponent.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Component/HeaderComponent.dart';
import 'package:digitalcard/Common/ClassList.dart';
import 'package:digitalcard/Common/Services.dart';
import 'package:digitalcard/Component/LoadinComponent.dart';
import 'package:digitalcard/Component/NoDataComponent.dart';

class EarnHistory extends StatefulWidget {
  @override
  _EarnHistoryState createState() => _EarnHistoryState();
}

class _EarnHistoryState extends State<EarnHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        children: <Widget>[
          HeaderComponent(
            title: "Earn History",
            image: "images/header/offerheader.jpg",
            boxheight: 150,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 100,
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.only(top: 100),
            child: FutureBuilder<List<EarnHistoryClass>>(
              future: Services.GetEarnHistory(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.connectionState == ConnectionState.done
                    ? snapshot.hasData
                        ? ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return EarnComponent(snapshot.data[index]);
                            },
                          )
                        : NoDataComponent()
                    : LoadinComponent();
              },
            ),
          )
        ],
      ),
    ));
  }
}
