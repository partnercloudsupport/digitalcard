import 'package:flutter/material.dart';

class APIURL {
  static const String API_URL = "http://digitalcard.co.in/DigitalcardService.asmx/";
}

const Inr_Rupee = "₹";
const Color appcolor = Color.fromRGBO(48, 131, 201, 1);
const Color buttoncolor = Color.fromRGBO(85, 96, 128, 1);
const String whatsAppLink = "https://wa.me/#mobile?text=#msg"; //mobile no with country code
const String smsLink = "sms:#mobile?body=#msg"; //mobile no with country code
const String mailLink = "mailto:#mail?subject=#subject&body=#msg"; //mobile no with country code
const String shareMessage = "hello #recever, \nmy name is #sender \nyou can see my digital visiting card from the below link. \n#link \nRegards \n#sender";
const String profileUrl = "http://digitalcard.co.in/?uid=#id";
const String playstoreUrl = "";
const String inviteFriMsg = "digitalcard.co.in, smart & simple app to manage your digital visiting card & business profile.\nDownload the app from #appurl and use my refer code “#refercode” to get 7 days free trial.";


class Session{
  static const String Session_Login = "Login_Data";
  static const String MemberId = "MemberId";
  static const String Name = "Name";
  static const String Mobile = "Mobile";
  static const String Company = "Company";
  static const String ReferCode = "ReferCode";
  static const String IsAppIntroCompleted = "IsAppIntroCompleted";
}

class MESSAGES {
  static const String INTERNET_ERROR = "No Internet Connection";
  static const String INTERNET_ERROR_RETRY =
      "No Internet Connection.\nPlease Retry";
}

class COLORS {
  // App Colors //
  static const Color DRAWER_BG_COLOR = Colors.lightGreen;
  static const Color APP_THEME_COLOR = Colors.green;
}