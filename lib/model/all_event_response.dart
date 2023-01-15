// class AllEventResponse {
//   List<EventResult> result;
//
//   AllEventResponse({this.result});
//
//   AllEventResponse.fromJson(Map<String, dynamic> json) {
//     if (json['result'] = null) {
//       result = new List<EventResult>();
//       json['result'].forEach((v) {
//         result.add(new EventResult.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.result = null) {
//       data['result'] = this.result.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class EventResult {
//   String eventIdx;
//   String hostIdx;
//   String hostName;
//   String eventCatIdx;
//   String eventCatName;
//   String eventName;
//   String eventDate;
//   String eventTime;
//   String eventVenue;
//   String eventDescription;
//   String speakers;
//   String artworkPath;
//   String closingDate;
//   String isPaidEvent;
//   String eventStatusIdx;
//   String eventStatusName;
//   String currencyName;
//   String amount;
//
//   EventResult(
//       {this.eventIdx,
//       this.hostIdx,
//       this.hostName,
//       this.eventCatIdx,
//       this.eventCatName,
//       this.eventName,
//       this.eventDate,
//       this.eventTime,
//       this.eventVenue,
//       this.eventDescription,
//       this.speakers,
//       this.artworkPath,
//       this.closingDate,
//       this.isPaidEvent,
//       this.eventStatusIdx,
//       this.eventStatusName,
//       this.currencyName,
//       this.amount});
//
//   EventResult.fromJson(Map<String, dynamic> json) {
//     eventIdx = json['EventIdx'];
//     hostIdx = json['HostIdx'];
//     hostName = json['HostName'];
//     eventCatIdx = json['EventCatIdx'];
//     eventCatName = json['EventCatName'];
//     eventName = json['EventName'];
//     eventDate = json['EventDate'];
//     eventTime = json['EventTime'];
//     eventVenue = json['EventVenue'];
//     eventDescription = json['EventDescription'];
//     speakers = json['Speakers'];
//     artworkPath = json['ArtworkPath'];
//     closingDate = json['ClosingDate'];
//     isPaidEvent = json['IsPaidEvent'];
//     eventStatusIdx = json['EventStatusIdx'];
//     eventStatusName = json['EventStatusName'];
//     currencyName = json['CurrencyName'];
//     amount = json['Amount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['EventIdx'] = this.eventIdx;
//     data['HostIdx'] = this.hostIdx;
//     data['HostName'] = this.hostName;
//     data['EventCatIdx'] = this.eventCatIdx;
//     data['EventCatName'] = this.eventCatName;
//     data['EventName'] = this.eventName;
//     data['EventDate'] = this.eventDate;
//     data['EventTime'] = this.eventTime;
//     data['EventVenue'] = this.eventVenue;
//     data['EventDescription'] = this.eventDescription;
//     data['Speakers'] = this.speakers;
//     data['ArtworkPath'] = this.artworkPath;
//     data['ClosingDate'] = this.closingDate;
//     data['IsPaidEvent'] = this.isPaidEvent;
//     data['EventStatusIdx'] = this.eventStatusIdx;
//     data['EventStatusName'] = this.eventStatusName;
//     data['CurrencyName'] = this.currencyName;
//     data['Amount'] = this.amount;
//     return data;
//   }
// }



class AllEventResponse {
  List<EventsResult> result;

  AllEventResponse({this.result});

  AllEventResponse.fromJson(Map<String, dynamic> json) {
      result = <EventsResult>[];
      json['result'].forEach((v) {
        result.add(new EventsResult.fromJson(v));
      });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result = null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventsResult {
  int eventIdx;
  int hostIdx;
  int eventCatIdx;
  String eventName;
  String eventDate;
  String eventTime;
  String eventVenue;
  String eventDescription;
  int eventModeIdx;
  String onlineLink;
  String artworkPath;
  String closingDate;
  bool isEarlyBird;
  String earlyBirdEndDate;
  bool isPaidEvent;
  double ebDiscountRate;
  bool isSpeakerAvailable;
  String venueMapReference;
  int eventStatusIdx;
  int createdUserIdx;
  String termsCondition;
  String hostName;
  String categoryName;
  String eventStatusName;
  String currencyName;
  bool onlinePayment;
  bool chequePayment;
  bool cashOnPayment;
  bool bankTransferPayment;
  List<EventResourceObjectList> eventResourceObjectList;
  List<EventFeeObjectList> eventFeeObjectList;

  EventsResult(
      {this.eventIdx,
        this.hostIdx,
        this.eventCatIdx,
        this.eventName,
        this.eventDate,
        this.eventTime,
        this.eventVenue,
        this.eventDescription,
        this.eventModeIdx,
        this.onlineLink,
        this.artworkPath,
        this.closingDate,
        this.isEarlyBird,
        this.earlyBirdEndDate,
        this.isPaidEvent,
        this.ebDiscountRate,
        this.isSpeakerAvailable,
        this.venueMapReference,
        this.eventStatusIdx,
        this.createdUserIdx,
        this.termsCondition,
        this.hostName,
        this.categoryName,
        this.eventStatusName,
        this.currencyName,
        this.onlinePayment,
        this.chequePayment,
        this.cashOnPayment,
        this.bankTransferPayment,
        this.eventResourceObjectList,
        this.eventFeeObjectList});

  EventsResult.fromJson(Map<String, dynamic> json) {
    eventIdx = json['eventIdx'];
    hostIdx = json['hostIdx'];
    eventCatIdx = json['eventCatIdx'];
    eventName = json['eventName'];
    eventDate = json['eventDate'];
    eventTime = json['eventTime'];
    eventVenue = json['eventVenue'];
    eventDescription = json['eventDescription'];
    eventModeIdx = json['eventModeIdx'];
    onlineLink = json['onlineLink'];
    artworkPath = json['artworkPath'];
    closingDate = json['closingDate'];
    isEarlyBird = json['isEarlyBird'];
    earlyBirdEndDate = json['earlyBirdEndDate'];
    isPaidEvent = json['isPaidEvent'];
    ebDiscountRate = json['ebDiscountRate'];
    isSpeakerAvailable = json['isSpeakerAvailable'];
    venueMapReference = json['venueMapReference'];
    eventStatusIdx = json['eventStatusIdx'];
    createdUserIdx = json['createdUserIdx'];
    termsCondition = json['termsCondition'];
    hostName = json['hostName'];
    categoryName = json['categoryName'];
    eventStatusName = json['eventStatusName'];
    currencyName = json['currencyName'];
    onlinePayment = json['onlinePayment'];
    chequePayment = json['chequePayment'];
    cashOnPayment = json['cashOnPayment'];
    bankTransferPayment = json['bankTransferPayment'];
    // if (json['eventResourceObjectList'] = null) {
      eventResourceObjectList = <EventResourceObjectList>[];
      json['eventResourceObjectList'].forEach((v) {
        eventResourceObjectList.add(new EventResourceObjectList.fromJson(v));
      });
    // }
    // if (json['eventFeeObjectList'] = null) {
      eventFeeObjectList = <EventFeeObjectList>[];
      json['eventFeeObjectList'].forEach((v) {
        eventFeeObjectList.add(new EventFeeObjectList.fromJson(v));
      });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventIdx'] = this.eventIdx;
    data['hostIdx'] = this.hostIdx;
    data['eventCatIdx'] = this.eventCatIdx;
    data['eventName'] = this.eventName;
    data['eventDate'] = this.eventDate;
    data['eventTime'] = this.eventTime;
    data['eventVenue'] = this.eventVenue;
    data['eventDescription'] = this.eventDescription;
    data['eventModeIdx'] = this.eventModeIdx;
    data['onlineLink'] = this.onlineLink;
    data['artworkPath'] = this.artworkPath;
    data['closingDate'] = this.closingDate;
    data['isEarlyBird'] = this.isEarlyBird;
    data['earlyBirdEndDate'] = this.earlyBirdEndDate;
    data['isPaidEvent'] = this.isPaidEvent;
    data['ebDiscountRate'] = this.ebDiscountRate;
    data['isSpeakerAvailable'] = this.isSpeakerAvailable;
    data['venueMapReference'] = this.venueMapReference;
    data['eventStatusIdx'] = this.eventStatusIdx;
    data['createdUserIdx'] = this.createdUserIdx;
    data['termsCondition'] = this.termsCondition;
    data['hostName'] = this.hostName;
    data['categoryName'] = this.categoryName;
    data['eventStatusName'] = this.eventStatusName;
    data['currencyName'] = this.currencyName;
    data['onlinePayment'] = this.onlinePayment;
    data['chequePayment'] = this.chequePayment;
    data['cashOnPayment'] = this.cashOnPayment;
    data['bankTransferPayment'] = this.bankTransferPayment;
    if (this.eventResourceObjectList = null) {
      data['eventResourceObjectList'] =
          this.eventResourceObjectList.map((v) => v.toJson()).toList();
    }
    if (this.eventFeeObjectList = null) {
      data['eventFeeObjectList'] =
          this.eventFeeObjectList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventResourceObjectList {
  int eventResourceIdx;
  int eventIdx;
  String resCategory;
  String resName;
  bool isActive;

  EventResourceObjectList(
      {this.eventResourceIdx,
        this.eventIdx,
        this.resCategory,
        this.resName,
        this.isActive});

  EventResourceObjectList.fromJson(Map<String, dynamic> json) {
    eventResourceIdx = json['eventResourceIdx'];
    eventIdx = json['eventIdx'];
    resCategory = json['resCategory'];
    resName = json['resName'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventResourceIdx'] = this.eventResourceIdx;
    data['eventIdx'] = this.eventIdx;
    data['resCategory'] = this.resCategory;
    data['resName'] = this.resName;
    data['isActive'] = this.isActive;
    return data;
  }
}

class EventFeeObjectList {
  int eventFeeIdx;
  int eventIdx;
  bool isPresentage;
  bool isFixed;
  String catName;
  int currencyIdx;
  double amount;
  int exchangeRate;
  int presantageRate;
  int maxQuantity;

  EventFeeObjectList(
      {this.eventFeeIdx,
        this.eventIdx,
        this.isPresentage,
        this.isFixed,
        this.catName,
        this.currencyIdx,
        this.amount,
        this.exchangeRate,
        this.presantageRate,
        this.maxQuantity});

  EventFeeObjectList.fromJson(Map<String, dynamic> json) {
    eventFeeIdx = json['eventFeeIdx'];
    eventIdx = json['eventIdx'];
    isPresentage = json['isPresentage'];
    isFixed = json['isFixed'];
    catName = json['catName'];
    currencyIdx = json['currencyIdx'];
    amount = json['amount'];
    exchangeRate = json['exchangeRate'];
    presantageRate = json['presantageRate'];
    maxQuantity = json['maxQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventFeeIdx'] = this.eventFeeIdx;
    data['eventIdx'] = this.eventIdx;
    data['isPresentage'] = this.isPresentage;
    data['isFixed'] = this.isFixed;
    data['catName'] = this.catName;
    data['currencyIdx'] = this.currencyIdx;
    data['amount'] = this.amount;
    data['exchangeRate'] = this.exchangeRate;
    data['presantageRate'] = this.presantageRate;
    data['maxQuantity'] = this.maxQuantity;
    return data;
  }
}
