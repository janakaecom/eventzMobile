class UpdateProfileResponse {
  String result;
  String error;

  UpdateProfileResponse({this.result, this.error});

  UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['error'] = this.error;
    return data;
  }
}

