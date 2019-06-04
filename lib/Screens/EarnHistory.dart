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
      appBar: AppBar(
        title: Text('Earn History'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
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
      ),
    );
  }
}
