class HostRegistrationResponse {
  int result;
  String error;

  HostRegistrationResponse({this.result, this.error});

  HostRegistrationResponse.fromJson(Map<String, dynamic> json) {
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

