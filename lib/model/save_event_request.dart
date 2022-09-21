class SaveEventRequest {
  int userId;
  int eventId;
  String vehicleNo;
  String mealType;
  String coupunCode;
  double amountPaid;
  int paymodeId;

  SaveEventRequest(
      {this.userId,
      this.eventId,
      this.vehicleNo,
      this.mealType,
      this.coupunCode,
      this.amountPaid,
      this.paymodeId});

  SaveEventRequest.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    eventId = json['EventId'];
    vehicleNo = json['VehicleNo'];
    mealType = json['MealType'];
    coupunCode = json['CoupunCode'];
    amountPaid = json['AmountPaid'];
    paymodeId = json['PaymodeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['EventId'] = this.eventId;
    data['VehicleNo'] = this.vehicleNo;
    data['MealType'] = this.mealType;
    data['CoupunCode'] = this.coupunCode;
    data['AmountPaid'] = this.amountPaid;
    data['PaymodeId'] = this.paymodeId;
    return data;
  }
}
