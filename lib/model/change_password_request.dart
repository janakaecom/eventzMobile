import 'dart:math';

class ChangePasswordRequest {

  int userId;
  String oldPassword;
  String newPassword;

  ChangePasswordRequest(
      {
        this.userId,
        this.oldPassword,
        this.newPassword,
      });

  ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    oldPassword = json['newPassword'];
    newPassword = json['oldPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['newPassword'] = this.newPassword;
    data['oldPassword'] = this.oldPassword;
    return data;
  }
}