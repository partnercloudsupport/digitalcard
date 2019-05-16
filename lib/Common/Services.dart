import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//Custom Files
import 'package:digitalcard/Common/ClassList.dart';
import 'package:digitalcard/Common/Constants.dart';
import 'package:digitalcard/Common/Constants.dart' as cnst;

class Services {
  //For Login Data
  static Future<List<MemberClass>> MemberLogin(String mobileno) async {
    String url =
        APIURL.API_URL + 'Member_login?type=mobilelogin&mobileno=$mobileno';
    print("MemberLogin URL: " + url);
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        List<MemberClass> list = [];
        print("MemberLogin Response: " + response.body);

        final jsonResponse = json.decode(response.body);
        MemberDataClass memberDataClass =
            new MemberDataClass.fromJson(jsonResponse);

        if (memberDataClass.ERROR_STATUS == false)
          list = memberDataClass.Data;
        else
          list = [];

        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("Check Login Erorr : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  //For DashboardCount Class Data
  static Future<List<DashboardCountClass>> GetDashboardCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String memberId = prefs.getString(cnst.Session.MemberId);

    List<DashboardCountClass> list = [];

    if (memberId != null && memberId != "") {
      String url = APIURL.API_URL +
          'GetDashboardCount?type=dashboardcount&Member_Id=$memberId';
      print("MemberLogin URL: " + url);
      final response = await http.get(url);
      try {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          DashboardCountDataClass dashboardCountDataClass =
              new DashboardCountDataClass.fromJson(jsonResponse);

          if (dashboardCountDataClass.ERROR_STATUS == false)
            list = dashboardCountDataClass.Data;
          else
            list = [];

          return list;
        } else {
          throw Exception(MESSAGES.INTERNET_ERROR);
        }
      } catch (e) {
        print("GetDashboardCount Erorr : " + e.toString());
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } else
      return list;
  }

  static Future<List<ServicesClass>> GetMemberServices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String memberId = prefs.getString(cnst.Session.MemberId);

    List<ServicesClass> list = [];

    if (memberId != null && memberId != "") {
      String url = APIURL.API_URL +
          'GetMemberServices?type=memberservices&memberid=$memberId';
      print("GetMemberServices URL: " + url);
      final response = await http.get(url);
      try {
        if (response.statusCode == 200) {
          //if (!response.body.contains('"Data":null')) {
          final jsonResponse = json.decode(response.body);

          ServicesDataClass servicesDataClass =
              new ServicesDataClass.fromJson(jsonResponse);

          if (servicesDataClass.ERROR_STATUS == false)
            list = servicesDataClass.Data;
          //}

          return list;
        } else {
          throw Exception(MESSAGES.INTERNET_ERROR);
        }
      } catch (e) {
        print("GetMemberServices Erorr : " + e.toString());
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } else
      return list;
  }

  static Future<List<OfferClass>> GetMemberOffers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String memberId = prefs.getString(cnst.Session.MemberId);

    List<OfferClass> list = [];

    if (memberId != null && memberId != "") {
      String url = APIURL.API_URL +
          'GetMemberOffers?type=memberoffers&memberid=$memberId';
      print("GetMemberOffers URL: " + url);
      final response = await http.get(url);
      try {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          OfferDataClass offerDataClass =
              new OfferDataClass.fromJson(jsonResponse);

          if (offerDataClass.ERROR_STATUS == false)
            list = offerDataClass.Data;
          else
            list = [];

          return list;
        } else {
          throw Exception(MESSAGES.INTERNET_ERROR);
        }
      } catch (e) {
        print("GetMemberOffers Erorr : " + e.toString());
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } else
      return list;
  }

  static Future<List<OfferInterestedClass>> GetOfferInterested(
      String offerid) async {
    List<OfferInterestedClass> list = [];
    String url = APIURL.API_URL +
        'GetOfferInterested?type=offerinterested&offerid=$offerid';
    print("GetOfferInterested URL: " + url);
    final response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        OfferInterestedDataClass offerInterestedDataClass =
            new OfferInterestedDataClass.fromJson(jsonResponse);

        if (offerInterestedDataClass.ERROR_STATUS == false)
          list = offerInterestedDataClass.Data;
        else
          list = [];

        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("GetMemberOffers Erorr : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  static Future<List<EarnHistoryClass>> GetEarnHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String referCode = prefs.getString(cnst.Session.ReferCode);
    List<EarnHistoryClass> list = [];
    if (referCode != null && referCode != "") {
      String url =
          APIURL.API_URL + 'GetEarnHistory?type=earn&referCode=$referCode';
      print("GetOfferInterested URL: " + url);
      final response = await http.get(url);
      try {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          EarnHistoryDataClass earnHistoryDataClass =
              new EarnHistoryDataClass.fromJson(jsonResponse);

          if (earnHistoryDataClass.ERROR_STATUS == false)
            list = earnHistoryDataClass.Data;
          else
            list = [];

          return list;
        } else {
          throw Exception(MESSAGES.INTERNET_ERROR);
        }
      } catch (e) {
        print("GetMemberOffers Erorr : " + e.toString());
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    }
  }

  static Future<List<RedeemHistoryClass>> GetRedemHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String memberId = prefs.getString(cnst.Session.MemberId);

    List<RedeemHistoryClass> list = [];

    if (memberId != null && memberId != "") {
      String url =
          APIURL.API_URL + 'GetRedemHistory?type=redeem&memberid=$memberId';
      print("GetOfferInterested URL: " + url);
      final response = await http.get(url);
      try {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          RedeemHistoryDataClass redeemHistoryDataClass =
              new RedeemHistoryDataClass.fromJson(jsonResponse);

          if (redeemHistoryDataClass.ERROR_STATUS == false)
            list = redeemHistoryDataClass.Data;
          else
            list = [];

          return list;
        } else {
          throw Exception(MESSAGES.INTERNET_ERROR);
        }
      } catch (e) {
        print("GetMemberOffers Erorr : " + e.toString());
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    }
  }

  static Future<List<ShareClass>> GetShareHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String memberId = prefs.getString(cnst.Session.MemberId);

    List<ShareClass> list = [];

    if (memberId != null && memberId != "") {
      String url =
          APIURL.API_URL + 'GetShareHistory?type=share&memberid=$memberId';
      print("GetShareHistory URL: " + url);
      final response = await http.get(url);
      try {
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          ShareDataClass shareDataClass =
              new ShareDataClass.fromJson(jsonResponse);

          if (shareDataClass.ERROR_STATUS == false)
            list = shareDataClass.Data;
          else
            list = [];

          return list;
        } else {
          throw Exception(MESSAGES.INTERNET_ERROR);
        }
      } catch (e) {
        print("GetShareHistory Erorr : " + e.toString());
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    }
  }

  static Future<SaveDataClass> SaveOffer(data) async {
    String url = APIURL.API_URL + 'AddOffer';
    print("AddOffer URL: " + url);
    final response = await http.post(url, body: data);
    try {
      if (response.statusCode == 200) {
        SaveDataClass data;
        final jsonResponse = json.decode(response.body);
        SaveDataClass saveDataClass = new SaveDataClass.fromJson(jsonResponse);
        return saveDataClass;
        return data;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      print("SaveTA Erorr : " + e.toString());
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }
}