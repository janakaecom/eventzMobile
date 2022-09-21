class MyEventResponse {
  List<ResultMyEvent> result;

  MyEventResponse({this.result});

  MyEventResponse.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<ResultMyEvent>();
      json['result'].forEach((v) {
        result.add(new ResultMyEvent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultMyEvent {
  String eventEnrollId;
  String userId;
  String eventId;
  String entrollmentDate;
  String isPaid;
  String paymodeId;
  String amountPaid;
  String vehicleNo;
  String mealType;
  String couponCode;
  String isCheckIn;
  String isActive;
  String bankName;
  String paymodeName;
  String enrollPaymentId;
  String bankId;
  String transferedDate;
  String transferedAmount;
  String payRefURL;
  String isVerified;
  String paymemtIsActive;
  String hostIdx;
  String hostName;
  String eventName;
  String eventCatIdx;
  String eventDate;
  String eventTime;
  String eventVenue;
  String eventDescription;
  String speakers;
  String artworkPath;
  String closingDate;
  String isPaidEvent;

  ResultMyEvent(
      {this.eventEnrollId,
      this.userId,
      this.eventId,
      this.entrollmentDate,
      this.isPaid,
      this.paymodeId,
      this.amountPaid,
      this.vehicleNo,
      this.mealType,
      this.couponCode,
      this.isCheckIn,
      this.isActive,
      this.bankName,
      this.paymodeName,
      this.enrollPaymentId,
      this.bankId,
      this.transferedDate,
      this.transferedAmount,
      this.payRefURL,
      this.isVerified,
      this.paymemtIsActive,
      this.hostIdx,
      this.hostName,
      this.eventName,
      this.eventCatIdx,
      this.eventDate,
      this.eventTime,
      this.eventVenue,
      this.eventDescription,
      this.speakers,
      this.artworkPath,
      this.closingDate,
      this.isPaidEvent});

  ResultMyEvent.fromJson(Map<String, dynamic> json) {
    eventEnrollId = json['EventEnrollId'];
    userId = json['UserId'];
    eventId = json['EventId'];
    entrollmentDate = json['EntrollmentDate'];
    isPaid = json['IsPaid'];
    paymodeId = json['PaymodeId'];
    amountPaid = json['AmountPaid'];
    vehicleNo = json['VehicleNo'];
    mealType = json['MealType'];
    couponCode = json['CouponCode'];
    isCheckIn = json['IsCheckIn'];
    isActive = json['IsActive'];
    bankName = json['BankName'];
    paymodeName = json['PaymodeName'];
    enrollPaymentId = json['EnrollPaymentId'];
    bankId = json['BankId'];
    transferedDate = json['TransferedDate'];
    transferedAmount = json['TransferedAmount'];
    payRefURL = json['PayRefURL'];
    isVerified = json['IsVerified'];
    paymemtIsActive = json['paymemtIsActive'];
    hostIdx = json['HostIdx'];
    hostName = json['HostName'];
    eventName = json['EventName'];
    eventCatIdx = json['EventCatIdx'];
    eventDate = json['EventDate'];
    eventTime = json['EventTime'];
    eventVenue = json['EventVenue'];
    eventDescription = json['EventDescription'];
    speakers = json['Speakers'];
    artworkPath = json['ArtworkPath'];
    closingDate = json['ClosingDate'];
    isPaidEvent = json['IsPaidEvent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EventEnrollId'] = this.eventEnrollId;
    data['UserId'] = this.userId;
    data['EventId'] = this.eventId;
    data['EntrollmentDate'] = this.entrollmentDate;
    data['IsPaid'] = this.isPaid;
    data['PaymodeId'] = this.paymodeId;
    data['AmountPaid'] = this.amountPaid;
    data['VehicleNo'] = this.vehicleNo;
    data['MealType'] = this.mealType;
    data['CouponCode'] = this.couponCode;
    data['IsCheckIn'] = this.isCheckIn;
    data['IsActive'] = this.isActive;
    data['BankName'] = this.bankName;
    data['PaymodeName'] = this.paymodeName;
    data['EnrollPaymentId'] = this.enrollPaymentId;
    data['BankId'] = this.bankId;
    data['TransferedDate'] = this.transferedDate;
    data['TransferedAmount'] = this.transferedAmount;
    data['PayRefURL'] = this.payRefURL;
    data['IsVerified'] = this.isVerified;
    data['paymemtIsActive'] = this.paymemtIsActive;
    data['HostIdx'] = this.hostIdx;
    data['HostName'] = this.hostName;
    data['EventName'] = this.eventName;
    data['EventCatIdx'] = this.eventCatIdx;
    data['EventDate'] = this.eventDate;
    data['EventTime'] = this.eventTime;
    data['EventVenue'] = this.eventVenue;
    data['EventDescription'] = this.eventDescription;
    data['Speakers'] = this.speakers;
    data['ArtworkPath'] = this.artworkPath;
    data['ClosingDate'] = this.closingDate;
    data['IsPaidEvent'] = this.isPaidEvent;
    return data;
  }
}
