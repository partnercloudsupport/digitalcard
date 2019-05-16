import 'package:flutter/material.dart';
import 'package:digitalcard/Component/OfferComponent.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Component/HeaderComponent.dart';
import 'package:digitalcard/Common/ClassList.dart';
import 'package:digitalcard/Common/Services.dart';
import 'package:digitalcard/Component/LoadinComponent.dart';
import 'package:digitalcard/Component/NoDataComponent.dart';

class Offers extends StatefulWidget {
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: cnst.buttoncolor,
          onPressed: () => Navigator.pushNamed(context, "/AddOffer"),
          child: Icon(Icons.add),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              HeaderComponent(
                title: "Offers",
                image: "images/header/offerheader.jpg",
                boxheight: 150,
              ),
              Container(
                height: MediaQuery.of(context).size.height - 160,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(top: 100),
                child: FutureBuilder<List<OfferClass>>(
                  future: Services.GetMemberOffers(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.connectionState == ConnectionState.done
                        ? snapshot.hasData
                            ? ListView.builder(
                                padding: EdgeInsets.all(0),
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return OfferComponent(snapshot.data[index]);
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
