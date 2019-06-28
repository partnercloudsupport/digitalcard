import 'package:flutter/material.dart';
import 'package:digitalcard/Component/ShareHistoryComponent.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Component/HeaderComponent.dart';
import 'package:digitalcard/Common/ClassList.dart';
import 'package:digitalcard/Common/Services.dart';
import 'package:digitalcard/Component/LoadinComponent.dart';
import 'package:digitalcard/Component/NoDataComponent.dart';

class ShareHistory extends StatefulWidget {
  @override
  _ShareHistoryState createState() => _ShareHistoryState();
}

class _ShareHistoryState extends State<ShareHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Share History'),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 20,right: 20,top: 10),
          //margin: EdgeInsets.only(top: 100),
          child: FutureBuilder<List<ShareClass>>(
            future: Services.GetShareHistory(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? snapshot.hasData
                  ? ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ShareHistoryComponent(snapshot.data[index]);
                },
              )
                  : NoDataComponent()
                  : LoadinComponent();
            },
          ),
        )
    );
  }
}
