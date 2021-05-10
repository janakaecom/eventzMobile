class RegisterRequest {
  String userName;
  String firstName;
  String lastName;
  int userTypeIdx;
  String password;
  // bool isActive;
  String mobileNo;
  int countryId;

  RegisterRequest(
      {this.userName,
      this.firstName,
      this.lastName,
      this.userTypeIdx,
      this.password,
      // this.isActive,
      this.mobileNo,
      this.countryId});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    userName = json['UserName'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    userTypeIdx = json['UserTypeIdx'];
    password = json['Password'];
    // isActive = json['IsActive'];
    mobileNo = json['MobileNo'];
    countryId = json['CountryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserName'] = this.userName;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['UserTypeIdx'] = this.userTypeIdx;
    data['Password'] = this.password;
    // data['IsActive'] = this.isActive;
    data['MobileNo'] = this.mobileNo;
    data['CountryId'] = this.countryId;
    return data;
  }
}
