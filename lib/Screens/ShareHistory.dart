import 'dart:io';

import 'package:flutter/material.dart';
import 'package:digitalcard/Component/ShareHistoryComponent.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Component/HeaderComponent.dart';
import 'package:digitalcard/Common/ClassList.dart';
import 'package:digitalcard/Common/Services.dart';
import 'package:digitalcard/Component/LoadinComponent.dart';
import 'package:digitalcard/Component/NoDataComponent.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShareHistory extends StatefulWidget {
  @override
  _ShareHistoryState createState() => _ShareHistoryState();
}

class _ShareHistoryState extends State<ShareHistory> {
  List<ShareClass> shareClass = new List();
  List<ShareClass> searchShareClass = new List();
  bool _isSearching = false,isfirst=false;
  bool isLoading = true;

  TextEditingController _controller = TextEditingController();

  final globalKey = new GlobalKey<ScaffoldState>();
  Widget appBarTitle = new Text('Share History');
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  @override
  void initState() {
    _getSharedHistory();
  }

  _getSharedHistory() async {
    Future res = Services.GetShareHistory();
    res.then((data) async {
      if (data != null && data.length > 0) {
        setState(() {
          isLoading = false;
          shareClass = data;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }, onError: (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          textColor: Colors.white,
          msg: "Something went Wrong",
          backgroundColor: Colors.red,
          gravity: ToastGravity.TOP);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        appBar: buildAppBar(context),
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          //margin: EdgeInsets.only(top: 100),
          child:
              /*FutureBuilder<List<ShareClass>>(
            future: Services.GetShareHistory(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              shareClass = snapshot.data;
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
          )*/
              isLoading
                  ? LoadinComponent()
                  : shareClass.length > 0 && shareClass != null
                      ? searchShareClass.length != 0
                          ? ListView.builder(
                              padding: EdgeInsets.all(0),
                              itemCount: searchShareClass.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ShareHistoryComponent(
                                    searchShareClass[index]);
                              },
                            )
                          : _isSearching && isfirst
                              ? ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  itemCount: searchShareClass.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ShareHistoryComponent(
                                        searchShareClass[index]);
                                  },
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  itemCount: shareClass.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ShareHistoryComponent(
                                        shareClass[index]);
                                  },
                                )
                      : NoDataComponent(),
        ));
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(centerTitle: false, title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: icon,
        onPressed: () {
          if (this.icon.icon == Icons.search) {
            this.icon = new Icon(
              Icons.close,
              color: Colors.white,
            );
            this.appBarTitle = new TextField(
              controller: _controller,
              style: new TextStyle(
                color: Colors.white,
              ),
              decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search, color: Colors.white),
                  hintText: "Search...",
                  hintStyle: new TextStyle(color: Colors.white)),
              onChanged: searchOperation,
//onSubmitted: searchOperation,
            );
            _handleSearchStart();
          } else {
            _handleSearchEnd();
          }
        },
      ),
    ]);
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Share History",
      );
      _isSearching = false;
      isfirst=false;
      searchShareClass.clear();
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchShareClass.clear();
    if (_isSearching != null) {
      isfirst=true;
      for (int i = 0; i < shareClass.length; i++) {
        String data = shareClass[i].Name;
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchShareClass.add(shareClass[i]);
        }
      }
    }
    setState(() {});
  }
}
