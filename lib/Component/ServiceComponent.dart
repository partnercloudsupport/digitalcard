import 'package:flutter/material.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Common/ClassList.dart';

class ServiceComponent extends StatelessWidget {

  final ServicesClass servicesClass;
  const ServiceComponent(this.servicesClass);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        //margin: EdgeInsets.symmetric(vertical: 5),
        child: ExpansionTile(
          title: Text(servicesClass.Title,
              style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey[700])),
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
              width: MediaQuery.of(context).size.width - 40,
              child: Text(servicesClass.Description,
                  style: TextStyle(fontSize: 15,color: Colors.grey[700])),
            )
          ],
        ),
      ),
    );
  }
}
