import 'package:flutter/material.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Component/HeaderComponent.dart';
import 'package:digitalcard/Common/ClassList.dart';
import 'package:digitalcard/Screens/OfferInterestedMembers.dart';

class OfferDetail extends StatefulWidget {
  final OfferClass offerClass;

  const OfferDetail({Key key, this.offerClass}) : super(key: key);

  @override
  _OfferDetailState createState() => _OfferDetailState();
}

class _OfferDetailState extends State<OfferDetail> {
  @override
  Widget build(BuildContext context) {
    final CardTheme cardTheme = CardTheme.of(context);
    return Scaffold(
      body: Container(
        //color: Colors.white,
        child: Stack(
          children: <Widget>[
            HeaderComponent(
              title: "Offer Detail",
              image: "images/header/offerheader.jpg",
              boxheight: 150,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 160,
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(top: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  (widget.offerClass.Image != null && widget.offerClass.Image != "")
                      ? Image.network(widget.offerClass.Image,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill)
                      : Image.asset("images/nooffer.jpg",
                      height: 200,
                      width: MediaQuery.of(context).size.width-40,
                      fit: BoxFit.fill),
                  Card(
                    elevation: 3,
                    margin: EdgeInsets.all(0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width - 170,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(widget.offerClass.Title,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: cnst.appcolor)),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text("Available till :",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[600])),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(widget.offerClass.ValidTill,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: cnst.appcolor)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          /*MaterialButton(
                            onPressed: () {
                              //Navigator.pushNamed(context, "/OfferInterestedMembers");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OfferInterestedMembers(
                                          OfferId: widget.offerClass.Id)));
                            },
                            padding: EdgeInsets.all(5),
                            color: cnst.buttoncolor,
                            child: Column(
                              children: <Widget>[
                                Text("500",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                                Text("Interested",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          )*/
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 3,
                    margin: EdgeInsets.only(top: 10),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width - 40,
                      child: Text(widget.offerClass.Descri,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600])),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
