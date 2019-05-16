class SaveDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;

  SaveDataClass(
      {this.MESSAGE, this.ORIGINAL_ERROR, this.ERROR_STATUS, this.RECORDS});

  factory SaveDataClass.fromJson(Map<String, dynamic> json) {
    return SaveDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool);
  }
}

class LoginDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<LoginClass> Data;

  LoginDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory LoginDataClass.fromJson(Map<String, dynamic> json) {
    return LoginDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<LoginClass>((json) => LoginClass.fromJson(json))
            .toList());
  }
}

class LoginClass {
  String Id;
  String Name;

  LoginClass({this.Id, this.Name});

  factory LoginClass.fromJson(Map<String, dynamic> json) {
    return LoginClass(Id: json['Id'] as String, Name: json['Name'] as String);
  }
}

class DashboardCountDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<DashboardCountClass> Data;

  DashboardCountDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory DashboardCountDataClass.fromJson(Map<String, dynamic> json) {
    return DashboardCountDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<DashboardCountClass>(
                (json) => DashboardCountClass.fromJson(json))
            .toList());
  }
}

class DashboardCountClass {
  String visitors;
  String share;
  String calls;

  DashboardCountClass({this.visitors, this.share, this.calls});

  factory DashboardCountClass.fromJson(Map<String, dynamic> json) {
    return DashboardCountClass(
        visitors: json['visitors'] as String,
        share: json['share'] as String,
        calls: json['calls'] as String);
  }
}

class ShareDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<ShareClass> Data;

  ShareDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory ShareDataClass.fromJson(Map<String, dynamic> json) {
    return ShareDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<ShareClass>((json) => ShareClass.fromJson(json))
            .toList());
  }
}

class ShareClass {
  String Id;
  String Name;
  String MobileNo;
  String Date;

  ShareClass({this.Id, this.Name, this.MobileNo, this.Date});

  factory ShareClass.fromJson(Map<String, dynamic> json) {
    return ShareClass(
        Id: json['Id'] as String,
        Name: json['Name'] as String,
        MobileNo: json['MobileNo'] as String,
        Date: json['Date'] as String);
  }
}

class OfferDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<OfferClass> Data;

  OfferDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory OfferDataClass.fromJson(Map<String, dynamic> json) {
    return OfferDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<OfferClass>((json) => OfferClass.fromJson(json))
            .toList());
  }
}

class OfferClass {
  String Id;
  String Title;
  String Descri;
  String Image;
  String Date;
  String ValidTill;

  OfferClass(
      {this.Id,
      this.Title,
      this.Descri,
      this.Image,
      this.Date,
      this.ValidTill});

  factory OfferClass.fromJson(Map<String, dynamic> json) {
    return OfferClass(
        Id: json['Id'] as String,
        Title: json['Title'] as String,
        Descri: json['Descri'] as String,
        Image: json['Image'] as String,
        Date: json['Date'] as String,
        ValidTill: json['ValidTill'] as String);
  }
}

class ServicesDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<ServicesClass> Data;

  ServicesDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory ServicesDataClass.fromJson(Map<String, dynamic> json) {
    return ServicesDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<ServicesClass>((json) => ServicesClass.fromJson(json))
            .toList());
  }
}

class ServicesClass {
  String Id;
  String Title;
  String Description;

  ServicesClass({this.Id, this.Title, this.Description});

  factory ServicesClass.fromJson(Map<String, dynamic> json) {
    return ServicesClass(
        Id: json['Id'] as String,
        Title: json['Title'] as String,
        Description: json['Description'] as String);
  }
}

class MemberDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<MemberClass> Data;

  MemberDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory MemberDataClass.fromJson(Map<String, dynamic> json) {
    return MemberDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<MemberClass>((json) => MemberClass.fromJson(json))
            .toList());
  }
}

class MemberClass {
  String Id;
  String Name;
  String Company;
  String Role;
  String website;
  String About;
  String Image;
  String Mobile;
  String Email;
  String Whatsappno;
  String Facebooklink;
  String CompanyAddress;
  String CompanyPhone;
  String CompanyUrl;
  String CompanyEmail;
  String GMap;
  String Twitter;
  String Google;
  String Linkedin;
  String Youtube;
  String Instagram;
  String CoverImage;
  String MyReferralCode;
  String RegistrationRefCode;
  String JoinDate;
  String ExpDate;
  String MemberType;
  String RegistrationPoints;

  MemberClass(
      {this.Id,
      this.Name,
      this.Company,
      this.Role,
      this.website,
      this.About,
      this.Image,
      this.Mobile,
      this.Email,
      this.Whatsappno,
      this.Facebooklink,
      this.CompanyAddress,
      this.CompanyPhone,
      this.CompanyUrl,
      this.CompanyEmail,
      this.GMap,
      this.Twitter,
      this.Google,
      this.Linkedin,
      this.Youtube,
      this.Instagram,
      this.CoverImage,
      this.MyReferralCode,
      this.RegistrationRefCode,
      this.JoinDate,
      this.ExpDate,
      this.MemberType,
      this.RegistrationPoints});

  factory MemberClass.fromJson(Map<String, dynamic> json) {
    return MemberClass(
      Id: json['Id'] as String,
      Name: json['Name'] as String,
      Company: json['Description'] as String,
      Role: json['Role'] as String,
      website: json['website'] as String,
      About: json['About'] as String,
      Image: json['Image'] as String,
      Mobile: json['Mobile'] as String,
      Email: json['Email'] as String,
      Whatsappno: json['Whatsappno'] as String,
      Facebooklink: json['Facebooklink'] as String,
      CompanyAddress: json['CompanyAddress'] as String,
      CompanyPhone: json['CompanyPhone'] as String,
      CompanyUrl: json['CompanyUrl'] as String,
      CompanyEmail: json['CompanyEmail'] as String,
      GMap: json['Map'] as String,
      Twitter: json['Twitter'] as String,
      Google: json['Google'] as String,
      Linkedin: json['Linkedin'] as String,
      Youtube: json['Youtube'] as String,
      Instagram: json['Instagram'] as String,
      CoverImage: json['CoverImage'] as String,
      MyReferralCode: json['MyReferralCode'] as String,
      RegistrationRefCode: json['RegistrationRefCode'] as String,
      JoinDate: json['JoinDate'] as String,
      ExpDate: json['ExpDate'] as String,
      MemberType: json['MemberType'] as String,
      RegistrationPoints: json['RegistrationPoints'] as String,
    );
  }
}

class OfferInterestedDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<OfferInterestedClass> Data;

  OfferInterestedDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory OfferInterestedDataClass.fromJson(Map<String, dynamic> json) {
    return OfferInterestedDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<OfferInterestedClass>(
                (json) => OfferInterestedClass.fromJson(json))
            .toList());
  }
}

class OfferInterestedClass {
  String Id;
  String InterestedMemberId;
  String Name;
  String Company;
  String Image;
  String Mobileno;
  String Date;

  OfferInterestedClass(
      {this.Id,
      this.InterestedMemberId,
      this.Name,
      this.Company,
      this.Image,
      this.Mobileno,
      this.Date});

  factory OfferInterestedClass.fromJson(Map<String, dynamic> json) {
    return OfferInterestedClass(
        Id: json['Id'] as String,
        InterestedMemberId: json['MemberId'] as String,
        Name: json['Name'] as String,
        Company: json['Company'] as String,
        Image: json['Image'] as String,
        Mobileno: json['Mobile'] as String,
        Date: json['Date'] as String);
  }
}

class EarnHistoryDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<EarnHistoryClass> Data;

  EarnHistoryDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory EarnHistoryDataClass.fromJson(Map<String, dynamic> json) {
    return EarnHistoryDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<EarnHistoryClass>((json) => EarnHistoryClass.fromJson(json))
            .toList());
  }
}

class EarnHistoryClass {
  String Id;
  String Name;
  String Image;
  String RegistrationPoints;
  String JoinDate;

  EarnHistoryClass(
      {this.Id, this.Name, this.Image, this.RegistrationPoints, this.JoinDate});

  factory EarnHistoryClass.fromJson(Map<String, dynamic> json) {
    return EarnHistoryClass(
        Id: json['Id'] as String,
        Name: json['Name'] as String,
        Image: json['Image'] as String,
        RegistrationPoints: json['RegistrationPoints'] as String,
        JoinDate: json['JoinDate'] as String);
  }
}

class RedeemHistoryDataClass {
  String MESSAGE;
  String ORIGINAL_ERROR;
  bool ERROR_STATUS;
  bool RECORDS;
  List<RedeemHistoryClass> Data;

  RedeemHistoryDataClass(
      {this.MESSAGE,
      this.ORIGINAL_ERROR,
      this.ERROR_STATUS,
      this.RECORDS,
      this.Data});

  factory RedeemHistoryDataClass.fromJson(Map<String, dynamic> json) {
    return RedeemHistoryDataClass(
        MESSAGE: json['MESSAGE'] as String,
        ORIGINAL_ERROR: json['ORIGINAL_ERROR'] as String,
        ERROR_STATUS: json['ERROR_STATUS'] as bool,
        RECORDS: json['RECORDS'] as bool,
        Data: json['Data']
            .map<RedeemHistoryClass>(
                (json) => RedeemHistoryClass.fromJson(json))
            .toList());
  }
}

class RedeemHistoryClass {
  String Id;
  String Title;
  String Points;
  String Date;
  String OrderNo;

  RedeemHistoryClass(
      {this.Id, this.Title, this.Points, this.Date, this.OrderNo});

  factory RedeemHistoryClass.fromJson(Map<String, dynamic> json) {
    return RedeemHistoryClass(
        Id: json['Id'] as String,
        Title: json['Title'] as String,
        Points: json['Points'] as String,
        Date: json['Date'] as String,
        OrderNo: json['OrderNo'] as String);
  }
}
