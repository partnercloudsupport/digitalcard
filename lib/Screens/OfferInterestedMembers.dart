import 'package:flutter/material.dart';
import 'package:digitalcard/Component/InterestedMemberComponent.dart';
import 'package:digitalcard/Component/OfferComponent.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Component/HeaderComponent.dart';
import 'package:digitalcard/Common/ClassList.dart';
import 'package:digitalcard/Common/Services.dart';
import 'package:digitalcard/Component/LoadinComponent.dart';
import 'package:digitalcard/Component/NoDataComponent.dart';

class OfferInterestedMembers extends StatefulWidget {
  final String OfferId;
  const OfferInterestedMembers({Key key, this.OfferId}) : super(key: key);

  @override
  _OfferInterestedMembersState createState() => _OfferInterestedMembersState();
}

class _OfferInterestedMembersState extends State<OfferInterestedMembers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Stack(
            children: <Widget>[
              HeaderComponent(
                title: "Interested Members",
                image: "images/header/offerheader.jpg",
                boxheight: 150,
              ),
              Container(
                height: MediaQuery.of(context).size.height - 160,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(top: 100),
                child: FutureBuilder<List<OfferInterestedClass>>(
                  future: Services.GetOfferInterested(widget.OfferId),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.connectionState == ConnectionState.done
                        ? snapshot.hasData
                        ? ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InterestedMemberComponent(snapshot.data[index]);
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
