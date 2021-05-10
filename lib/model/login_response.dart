class LoginResponse {
  Result result;

  LoginResponse({this.result});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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
  String token;

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
      this.token});

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
    return data;
  }
}
