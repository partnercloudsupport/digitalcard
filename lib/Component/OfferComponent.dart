import 'package:flutter/material.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Common/ClassList.dart';
import 'package:digitalcard/Screens/OfferDetail.dart';

class OfferComponent extends StatelessWidget {

  final OfferClass offerClass;
  const OfferComponent(this.offerClass);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width - 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                //Navigator.pushNamed(context, "/OfferDetail");
                Navigator.push(context, MaterialPageRoute(builder: (context) => OfferDetail(offerClass: offerClass)));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(offerClass.Title,style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.w600,color: cnst.appcolor)),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text('${offerClass.Descri.length > 65 ? offerClass.Descri.substring(0,65) : offerClass.Descri}...',
                        style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.grey[600])),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: <Widget>[
                      Text("Available till :",
                          style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: Colors.grey[600])),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(offerClass.ValidTill,
                            style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: cnst.appcolor)),
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
    );
  }
}
