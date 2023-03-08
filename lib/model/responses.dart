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


class SuccessResponse {
  String result;

  SuccessResponse({this.result});

  SuccessResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    return data;
  }
}


class EventRegistrationResponse {
  String result;
  String error;

  EventRegistrationResponse({this.result, this.error});

  EventRegistrationResponse.fromJson(Map<String, dynamic> json) {
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

