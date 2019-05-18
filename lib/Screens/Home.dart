import 'package:flutter/material.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Component/CardShareComponent.dart';
import 'package:digitalcard/Common/ClassList.dart';
import 'package:digitalcard/Common/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DashboardCountClass _dashboardCount =
      new DashboardCountClass(visitors: '0', calls: '0', share: '0');

  bool isLoading = false;
  String MemberId = "";
  String Name = "";
  String Company = "";

  @override
  void initState() {
    super.initState();
    GetLocalData();
    GetDashboardCount();
  }

  GetLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String memberId = prefs.getString(cnst.Session.MemberId);
    String name = prefs.getString(cnst.Session.Name);
    String company = prefs.getString(cnst.Session.Company);

    if (memberId != null && memberId != "")
      setState(() {
        MemberId = memberId;
      });
    if (name != null && name != "")
      setState(() {
        Name = name;
      });
    if (company != null && company != "")
      setState(() {
        Company = company;
      });
  }

  showMsg(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Digital Card"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  GetDashboardCount() async {
    setState(() {
      isLoading = true;
    });
    List<DashboardCountClass> _dashboardCountList =
        await Services.GetDashboardCount();
    if (_dashboardCountList != null && _dashboardCountList.length > 0) {
      setState(() {
        _dashboardCount = _dashboardCountList[0];
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            ClipPath(
              child: Image.asset(
                "images/profilebg.jpg",
                height: 300,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              clipper: MyClipper(),
            ),
            Container(
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 210),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Image.asset("images/users.png",
                        height: 100, width: 100),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 10, right: 20),
                          child: Text(Name,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w600))),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, "/ProfileDetail"),
                        child: Icon(Icons.edit),
                      )
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 20),
                      child: Text(Company,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(
                                width: 0.5, color: Colors.grey[900])),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              !isLoading
                                  ? Text(_dashboardCount.visitors,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: cnst.appcolor,
                                          fontWeight: FontWeight.w600))
                                  : CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text("Visitors",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: cnst.buttoncolor,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                          height: 100,
                          width: 100,
                        ),
                      ),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(
                                width: 0.5, color: Colors.grey[900])),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              !isLoading
                                  ? Text(_dashboardCount.share,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: cnst.appcolor,
                                          fontWeight: FontWeight.w600))
                                  : CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text("Share",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: cnst.buttoncolor,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                          height: 100,
                          width: 100,
                        ),
                      ),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(
                                width: 0.5, color: Colors.grey[900])),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              !isLoading
                                  ? Text(_dashboardCount.calls,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: cnst.appcolor,
                                          fontWeight: FontWeight.w600))
                                  : CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.blue),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text("Calls",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: cnst.buttoncolor,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  SizedBox(
                    width: 180,
                    child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        elevation: 5,
                        textColor: Colors.white,
                        color: cnst.buttoncolor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text("Share Now",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15)),
                            )
                          ],
                        ),
                        onPressed: () {
                          /*showMsg(
                              'Your trial is expired please contact to digital card team for renewal.\n\nThank you,\nRegards\nDigital Card');*/
                          Navigator.of(context).push(PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, _, __) =>
                                  CardShareComponent(
                                      memberId: MemberId, memberName: Name)));
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
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

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.7);
    path.lineTo(size.width * 0.6, size.height);
    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
