import 'package:flutter/material.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;
import 'package:digitalcard/Component/CardShareComponent.dart';
import 'package:digitalcard/Common/ClassList.dart';
import 'package:digitalcard/Common/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DashboardCountClass _dashboardCount =
      new DashboardCountClass(visitors: '0', calls: '0', share: '0');

  bool isLoading = false;
  bool isLoadingProfile = false;
  bool IsActivePayment = false;
  bool IsExpired = false;

  String MemberId = "";
  String Name = "";
  String Company = "";
  String Photo = "";
  String CoverPhoto = "";
  String ReferCode = "";
  String ExpDate = "";
  String MemberType = "";
  String ShareMsg = "";

  @override
  void initState() {
    super.initState();
    GetProfileData();
    GetDashboardCount();
    GetLocalData();
  }

  bool checkValidity() {
    if (ExpDate.trim() != null && ExpDate.trim() != "") {
      final f = new DateFormat('dd MMM yyyy');
      DateTime validTillDate = f.parse(ExpDate);
      print(validTillDate);
      DateTime currentDate = new DateTime.now();
      print(currentDate);
      if (validTillDate.isAfter(currentDate)) {
        return true;
      } else {
        return false;
      }
    } else
      return false;
  }

  GetLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isActivePayment = prefs.getBool(cnst.Session.IsActivePayment);

    if (isActivePayment != null)
      setState(() {
        IsActivePayment = isActivePayment;
        print(isActivePayment);
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

  GetProfileData() {
    setState(() {
      isLoadingProfile = true;
    });
    Services.GetMemberDetail().then((data) {
      setState(() {
        MemberId = data[0].Id;
        Name = data[0].Name;
        Company = data[0].Company;
        Photo = data[0].Image != null ? data[0].Image : "";
        CoverPhoto = data[0].CoverImage != null ? data[0].CoverImage : "";
        ReferCode = data[0].MyReferralCode;
        ExpDate = data[0].ExpDate;
        MemberType = data[0].MemberType;
        ShareMsg = data[0].ShareMsg;
        isLoadingProfile = false;
      });
      print("MemberType : $MemberType");
    }, onError: (e) {
      setState(() {
        isLoadingProfile = false;
      });
    });
  }

  GetDashboardCount() async {
    setState(() {
      isLoading = true;
    });
    Services.GetDashboardCount().then((val) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (val != null && val.length > 0) {
        await prefs.setString(
            cnst.Session.CardPaymentAmount, val[0].cardAmount);
        print(val[0].cardAmount);
        setState(() {
          _dashboardCount = val[0];
        });
      }
      setState(() {
        isLoading = false;
      });
    }, onError: (e) {
      setState(() {
        isLoading = false;
      });
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
              child: FadeInImage.assetNetwork(
                  placeholder: "images/profilebg.jpg",
                  image: CoverPhoto,
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover),
              clipper: MyClipper(),
            ),
            Container(
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height * 0.35) - 80),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                          placeholder: "images/users.png",
                          image: Photo,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover),
                    ),
                  ),
                  !isLoadingProfile
                      ? Column(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(Name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w600))),
                            Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 0),
                                child: Text(Company,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w600))),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, "/ProfileDetail"),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Edit Profile",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w600)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child:
                                          Icon(Icons.edit, color: Colors.blue),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                              strokeWidth: 3,
                            ),
                          ),
                        ),
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
                                  : SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.blue),
                                        strokeWidth: 3,
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
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
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/ShareHistory'),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                                    : SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.blue),
                                          strokeWidth: 3,
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
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
                                  : SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.blue),
                                        strokeWidth: 3,
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: 130,
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
                                  child: Text("Share",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15)),
                                )
                              ],
                            ),
                            onPressed: () {
                              bool val = checkValidity();
                              /*if(val != null && val == true)*/
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) =>
                                      CardShareComponent(
                                        memberId: MemberId,
                                        memberName: Name,
                                        isRegular: val,
                                        memberType: MemberType,
                                        shareMsg: ShareMsg,
                                        IsActivePayment: IsActivePayment,
                                      ),
                                ),
                              );
                              /*else
                                showMsg(
                                    'Your trial is expired please contact to digital card team for renewal.\n\nThank you,\nRegards\nDigital Card');*/
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0))),
                      ),
                      SizedBox(
                        width: 130,
                        child: RaisedButton(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            elevation: 5,
                            textColor: Colors.white,
                            color: cnst.buttoncolor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("images/logo.png",
                                    height: 24, width: 24),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("Refer",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15)),
                                )
                              ],
                            ),
                            onPressed: () {
                              String withrefercode = cnst.inviteFriMsg
                                  .replaceAll("#refercode", ReferCode);
                              String withappurl = withrefercode.replaceAll(
                                  "#appurl", cnst.playstoreUrl);
                              String withmemberid =
                                  withappurl.replaceAll("#id", MemberId);
                              Share.share(withmemberid);
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0))),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          elevation: 5,
                          textColor: Colors.white,
                          color: cnst.buttoncolor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("View Card",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15)),
                              )
                            ],
                          ),
                          onPressed: () async {
                            String profileUrl =
                                cnst.profileUrl.replaceAll("#id", MemberId);
                            if (await canLaunch(profileUrl)) {
                              await launch(profileUrl);
                            } else {
                              throw 'Could not launch $profileUrl';
                            }
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                      (IsActivePayment == true) &&
                              (MemberType.toLowerCase() == "trial" ||
                                  checkValidity() == false)
                          ? Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: RaisedButton(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                elevation: 5,
                                textColor: Colors.white,
                                color: cnst.buttoncolor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "${cnst.Inr_Rupee}  Pay Now",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/Payment');
                                },
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ],
              ),
            ),
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
