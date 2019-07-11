import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;

class MemberSelection extends StatefulWidget {
  final List memberList;

  const MemberSelection({Key key, this.memberList}) : super(key: key);

  @override
  _MemberSelectionState createState() => _MemberSelectionState();
}

class _MemberSelectionState extends State<MemberSelection> {
  setSelectedMember(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(cnst.Session.MemberId, widget.memberList[index].Id);
    await prefs.setString(cnst.Session.Name, widget.memberList[index].Name);
    await prefs.setString(cnst.Session.Mobile, widget.memberList[index].Mobile);
    await prefs.setString(
        cnst.Session.Company, widget.memberList[index].Company);
    await prefs.setString(
        cnst.Session.ReferCode, widget.memberList[index].MyReferralCode);
    Navigator.pushReplacementNamed(context, "/Dashboard");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Text(
                "Pick One Company",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: widget.memberList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () {
                          setSelectedMember(index);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          color: cnst.buttoncolor,
                          child: Text(
                            "${widget.memberList[index].Company}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
