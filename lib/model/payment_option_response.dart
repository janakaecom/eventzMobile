class PaymentOptionsResponse {
  List<Paymode> paymode;

  PaymentOptionsResponse({this.paymode});

  PaymentOptionsResponse.fromJson(Map<String, dynamic> json) {
    if (json['paymode'] != null) {
      paymode = new List<Paymode>();
      json['paymode'].forEach((v) {
        paymode.add(new Paymode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymode != null) {
      data['paymode'] = this.paymode.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Paymode {
  String paymodeId;
  String paymodeName;

  Paymode({this.paymodeId, this.paymodeName});

  Paymode.fromJson(Map<String, dynamic> json) {
    paymodeId = json['PaymodeId'];
    paymodeName = json['PaymodeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PaymodeId'] = this.paymodeId;
    data['PaymodeName'] = this.paymodeName;
    return data;
  }
}
