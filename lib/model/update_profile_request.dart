import 'dart:math';

class ProfileUpdateRequest {

  String title;
  String dob;
  int genderId;
  String NIC;
  String passportNo;
  String address;
  String occupation;
  String workPlace;
  String emgContactName;
  String emgContactNo;
  String profilePicURL;
  String firstName;
  String lastName;
  String mobileNo;
  int userTypeIdx;
  int countryID;
  String password;

  ProfileUpdateRequest(
      {
        this.title,
        this.dob,
        this.genderId,
        this.NIC,
        this.passportNo,
        this.address,
        this.occupation,
        this.workPlace,
        this.emgContactName,
        this.emgContactNo,
        this.profilePicURL,
        this.firstName,
        this.lastName,
        this.mobileNo,
        this.countryID,
        this.userTypeIdx,
      });

  ProfileUpdateRequest.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    dob = json['DOB'];
    genderId = json['GenderId'];
    NIC = json['NIC'];
    passportNo = json['PassportNo'];
    address = json['Address'];
    occupation = json['Occupation'];
    workPlace = json['WorkPlace'];
    userTypeIdx = json['UserTypeIdx'];
    emgContactName = json['EmgContactName'];
    emgContactNo = json['EmgContactNo'];
    profilePicURL = json['ProfilePicURL'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    mobileNo = json['MobileNo'];
    countryID = json['CountryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['DOB'] = this.dob;
    data['GenderId'] = this.genderId;
    data['NIC'] = this.NIC;
    data['PassportNo'] = this.passportNo;
    data['Address'] = this.address;
    data['Occupation'] = this.occupation;
    data['WorkPlace'] = this.workPlace;
    data['EmgContactName'] = this.emgContactName;
    data['EmgContactNo'] = this.emgContactNo;
    data['ProfilePicURL'] = this.profilePicURL;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['UserTypeIdx'] = this.userTypeIdx;
    data['MobileNo'] = this.mobileNo;
    data['CountryId'] = this.countryID;
    return data;
  }
}