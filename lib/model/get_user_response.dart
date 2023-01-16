class GetUserResponse {
  Result result;

  GetUserResponse({this.result});

  GetUserResponse.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  int userIdx;
  String firstName;
  String lastName;
  String userName;
  Null password;
  int userTypeIdx;
  String mobileNo;
  int countryId;
  bool isActive;
  Null token;
  String title;
  String dob;
  String nic;
  String passport;
  String occupation;
  String address;
  int genderId;
  String workPlace;
  String emgContactName;
  String emgContactNo;
  String profilePicURL;
  bool isHost;

  Result(
      {this.userIdx,
        this.firstName,
        this.lastName,
        this.userName,
        this.password,
        this.userTypeIdx,
        this.mobileNo,
        this.countryId,
        this.isActive,
        this.token,
        this.title,
        this.dob,
        this.nic,
        this.passport,
        this.occupation,
        this.address,
        this.genderId,
        this.workPlace,
        this.emgContactName,
        this.emgContactNo,
        this.profilePicURL,
        this.isHost});

  Result.fromJson(Map<String, dynamic> json) {
    userIdx = json['userIdx'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    password = json['password'];
    userTypeIdx = json['userTypeIdx'];
    mobileNo = json['mobileNo'];
    countryId = json['countryId'];
    isActive = json['isActive'];
    token = json['token'];
    title = json['title'];
    dob = json['dob'];
    nic = json['nic'];
    passport = json['passport'];
    occupation = json['occupation'];
    address = json['address'];
    genderId = json['genderId'];
    workPlace = json['workPlace'];
    emgContactName = json['emgContactName'];
    emgContactNo = json['emgContactNo'];
    profilePicURL = json['profilePicURL'];
    isHost = json['isHost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userIdx'] = this.userIdx;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['userTypeIdx'] = this.userTypeIdx;
    data['mobileNo'] = this.mobileNo;
    data['countryId'] = this.countryId;
    data['isActive'] = this.isActive;
    data['token'] = this.token;
    data['title'] = this.title;
    data['dob'] = this.dob;
    data['nic'] = this.nic;
    data['passport'] = this.passport;
    data['occupation'] = this.occupation;
    data['address'] = this.address;
    data['genderId'] = this.genderId;
    data['workPlace'] = this.workPlace;
    data['emgContactName'] = this.emgContactName;
    data['emgContactNo'] = this.emgContactNo;
    data['profilePicURL'] = this.profilePicURL;
    data['isHost'] = this.isHost;
    return data;
  }
}
