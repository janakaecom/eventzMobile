import 'package:eventz/configs/images.dart';

class ProfileUpdateRequest {
  int userIdx;
  String title;
  String dOB;
  int genderId;
  String nIC;
  String passport;
  String address;
  String occupation;
  String workPlace;
  String emgContactName;
  String emgContactNo;
  String mobileNo;
  String profilePicURL;
  String firstName;
  String lastName;
  int countryId;

  ProfileUpdateRequest(
      {this.userIdx,
        this.title,
        this.dOB,
        this.genderId,
        this.nIC,
        this.mobileNo,
        this.passport,
        this.address,
        this.occupation,
        this.workPlace,
        this.emgContactName,
        this.emgContactNo,
        this.profilePicURL,
        this.firstName,
        this.lastName,
        this.countryId});

  ProfileUpdateRequest.fromJson(Map<String, dynamic> json) {
    userIdx = json['UserIdx'];
    title = json['Title'];
    dOB = json['DOB'];
    genderId = json['GenderId'];
    nIC = json['NIC'];
    mobileNo = json['MobileNo'];
    passport = json['Passport'];
    address = json['Address'];
    occupation = json['Occupation'];
    workPlace = json['WorkPlace'];
    emgContactName = json['EmgContactName'];
    emgContactNo = json['EmgContactNo'];
    profilePicURL = json['ProfilePicURL'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    countryId = json['CountryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserIdx'] = this.userIdx;
    data['Title'] = this.title;
    data['DOB'] = this.dOB;
    data['MobileNo'] = this.mobileNo;
    data['GenderId'] = this.genderId;
    data['NIC'] = this.nIC;
    data['Passport'] = this.passport;
    data['Address'] = this.address;
    data['Occupation'] = this.occupation;
    data['WorkPlace'] = this.workPlace;
    data['EmgContactName'] = this.emgContactName;
    data['EmgContactNo'] = this.emgContactNo;
    data['ProfilePicURL'] = this.profilePicURL;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['CountryId'] = this.countryId;
    return data;
  }
}
