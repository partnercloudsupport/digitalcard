import 'package:digitalcard/Common/Services.dart';
import 'package:flutter/material.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Common/ClassList.dart';
import 'package:digitalcard/Screens/OfferDetail.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:digitalcard/Screens/EditOffer.dart';

class OfferComponent extends StatefulWidget {
  final OfferClass offerClass;

  const OfferComponent(this.offerClass);

  @override
  _OfferComponentState createState() => _OfferComponentState();
}

class _OfferComponentState extends State<OfferComponent> {
  bool isLoading = false;
  bool showComponent = true;

  DeleteOffer() async {
    setState(() {
      isLoading = true;
    });
    var data = {'type': 'offer', 'id': widget.offerClass.Id};
    Future res = Services.DeleteOffer(data);
    res.then((data) {
      setState(() {
        isLoading = false;
      });
      if (data != null && data.ERROR_STATUS == false) {
        Fluttertoast.showToast(
            msg: "Data Deleted",
            backgroundColor: Colors.green,
            gravity: ToastGravity.TOP);
        //Navigator.pushReplacementNamed(context, '/Dashboard');
        setState(() {
          showComponent = false;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Data Not Deleted" + data.MESSAGE,
            backgroundColor: Colors.red,
            gravity: ToastGravity.TOP,
            toastLength: Toast.LENGTH_LONG);
      }
    }, onError: (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Data Not Saved" + e.toString(), backgroundColor: Colors.red);
    });
  }

  @override
  Widget build(BuildContext context) {
    return showComponent ? Stack(
      children: <Widget>[
        Card(
          elevation: 2,
          child: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width - 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    //Navigator.pushNamed(context, "/OfferDetail");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OfferDetail(offerClass: widget.offerClass)));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.offerClass.Title,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: cnst.appcolor)),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                  '${widget.offerClass.Descri.length > 65 ? widget.offerClass.Descri.substring(0, 65) : widget.offerClass.Descri}...',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[600])),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
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
                            ),
                            /*ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: MaterialButton(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            color: cnst.buttoncolor,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            child: Text("Interested",
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)),
                          ),
                        )*/
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditOffer(offerClass: widget.offerClass))),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Icon(Icons.edit),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => DeleteOffer(),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Icon(Icons.delete),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Center(
          child: isLoading ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)) : Container(),
        )
      ],
    ) : Container();
  }
}
