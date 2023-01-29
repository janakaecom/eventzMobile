// //
// //
// // class EventRegisterRequest {
// //   int hostIdx;
// //   String artworkPath;
// //   String eventName;
// //   String eventDescription;
// //   String eventDate;
// //   String eventTime;
// //   String eventVenue;
// //   String venueMapReference;
// //   int eventCatIdx;
// //   int eventModeIdx;
// //   String artWorkName;
// //   String onlineLink;
// //   String closingDate;
// //   bool isEarlyBird = false;
// //   String earlyBirdEndDate;
// //   int eBDiscountRate;
// //   bool isPaidEvent = false;
// //   bool isSpeakerAvailable = false;
// //   String termsCondition;
// //   int eventStatusIdx;
// //   int createdUserIdx;
// //   int eventIdx;
// //   bool chequePayment  = false;
// //   bool cashOnPayment  = false;
// //   bool onlinePayment  = false;
// //   bool bankTransferPayment = false;
// //   List<EventResourceObjectList> eventResourceObjectList;
// //   List<EventFeeObjectList> eventFeeObjectList;
// //
// //   EventRegisterRequest(
// //       {this.hostIdx,
// //         this.artworkPath,
// //         this.eventName,
// //         this.eventDescription,
// //         this.eventDate,
// //         this.eventTime,
// //         this.eventVenue,
// //         this.venueMapReference,
// //         this.eventCatIdx,
// //         this.eventModeIdx,
// //         this.artWorkName,
// //         this.onlineLink,
// //         this.closingDate,
// //         this.isEarlyBird,
// //         this.earlyBirdEndDate,
// //         this.eBDiscountRate,
// //         this.isPaidEvent,
// //         this.isSpeakerAvailable,
// //         this.termsCondition,
// //         this.eventStatusIdx,
// //         this.createdUserIdx,
// //         this.eventIdx,
// //         this.chequePayment,
// //         this.cashOnPayment,
// //         this.onlinePayment,
// //         this.bankTransferPayment,
// //         this.eventResourceObjectList,
// //         this.eventFeeObjectList});
// //
// //   EventRegisterRequest.fromJson(Map<String, dynamic> json) {
// //     hostIdx = json['HostIdx'];
// //     artworkPath = json['ArtworkPath'];
// //     eventName = json['EventName'];
// //     eventDescription = json['EventDescription'];
// //     eventDate = json['EventDate'];
// //     eventTime = json['EventTime'];
// //     eventVenue = json['EventVenue'];
// //     venueMapReference = json['VenueMapReference'];
// //     eventCatIdx = json['EventCatIdx'];
// //     eventModeIdx = json['EventModeIdx'];
// //     artWorkName = json['ArtWorkName'];
// //     onlineLink = json['OnlineLink'];
// //     closingDate = json['ClosingDate'];
// //     isEarlyBird = json['IsEarlyBird'];
// //     earlyBirdEndDate = json['EarlyBirdEndDate'];
// //     eBDiscountRate = json['EBDiscountRate'];
// //     isPaidEvent = json['IsPaidEvent'];
// //     isSpeakerAvailable = json['IsSpeakerAvailable'];
// //     termsCondition = json['TermsCondition'];
// //     eventStatusIdx = json['EventStatusIdx'];
// //     createdUserIdx = json['CreatedUserIdx'];
// //     eventIdx = json['EventIdx'];
// //     chequePayment = json['ChequePayment'];
// //     cashOnPayment = json['CashOnPayment'];
// //     onlinePayment = json['OnlinePayment'];
// //     bankTransferPayment = json['BankTransferPayment'];
// //     if (json['EventResourceObjectList'] = null) {
// //       eventResourceObjectList = <EventResourceObjectList>[];
// //       json['EventResourceObjectList'].forEach((v) {
// //         eventResourceObjectList.add(new EventResourceObjectList.fromJson(v));
// //       });
// //     }
// //     if (json['EventFeeObjectList'] = null) {
// //       eventFeeObjectList = <EventFeeObjectList>[];
// //       json['EventFeeObjectList'].forEach((v) {
// //         eventFeeObjectList.add(new EventFeeObjectList.fromJson(v));
// //       });
// //     }
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['HostIdx'] = this.hostIdx;
// //     data['ArtworkPath'] = this.artworkPath;
// //     data['EventName'] = this.eventName;
// //     data['EventDescription'] = this.eventDescription;
// //     data['EventDate'] = this.eventDate;
// //     data['EventTime'] = this.eventTime;
// //     data['EventVenue'] = this.eventVenue;
// //     data['VenueMapReference'] = this.venueMapReference;
// //     data['EventCatIdx'] = this.eventCatIdx;
// //     data['EventModeIdx'] = this.eventModeIdx;
// //     data['ArtWorkName'] = this.artWorkName;
// //     data['OnlineLink'] = this.onlineLink;
// //     data['ClosingDate'] = this.closingDate;
// //     data['IsEarlyBird'] = this.isEarlyBird;
// //     data['EarlyBirdEndDate'] = this.earlyBirdEndDate;
// //     data['EBDiscountRate'] = this.eBDiscountRate;
// //     data['IsPaidEvent'] = this.isPaidEvent;
// //     data['IsSpeakerAvailable'] = this.isSpeakerAvailable;
// //     data['TermsCondition'] = this.termsCondition;
// //     data['EventStatusIdx'] = this.eventStatusIdx;
// //     data['CreatedUserIdx'] = this.createdUserIdx;
// //     data['EventIdx'] = this.eventIdx;
// //     data['ChequePayment'] = this.chequePayment;
// //     data['CashOnPayment'] = this.cashOnPayment;
// //     data['OnlinePayment'] = this.onlinePayment;
// //     data['BankTransferPayment'] = this.bankTransferPayment;
// //     data['EventResourceObjectList'] = this.eventResourceObjectList.map((v) => v.toJson()).toList();
// //     data['EventFeeObjectList'] = this.eventFeeObjectList.map((v) => v.toJson()).toList();
// //     // if (this.eventResourceObjectList = null) {
// //     //   data['EventResourceObjectList'] =
// //     //       this.eventResourceObjectList.map((v) => v.toJson()).toList();
// //     // }
// //     // if (this.eventFeeObjectList = null) {
// //     //   data['EventFeeObjectList'] = this.eventFeeObjectList.map((v) => v.toJson()).toList();
// //     // }
// //     return data;
// //   }
// // }
// //
// // class EventResourceObjectList {
// //   int resourceId;
// //   int eventId;
// //   String categoryName;
// //   String resourceName;
// //   bool isActive;
// //
// //   EventResourceObjectList(
// //       {this.resourceId,
// //         this.eventId,
// //         this.categoryName,
// //         this.resourceName,
// //         this.isActive});
// //
// //   EventResourceObjectList.fromJson(Map<String, dynamic> json) {
// //     resourceId = json['EventResourceIdx'];
// //     eventId = json['EventIdx'];
// //     categoryName = json['ResCategory'];
// //     resourceName = json['ResName'];
// //     isActive = json['IsActive'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['EventResourceIdx'] = this.resourceId;
// //     data['EventIdx'] = this.eventId;
// //     data['ResCategory'] = this.categoryName;
// //     data['ResName'] = this.resourceName;
// //     data['IsActive'] = this.isActive;
// //     return data;
// //   }
// // }
// //
// // class EventFeeObjectList {
// //   int eventFeeId;
// //   int eventIdx;
// //   String category;
// //   double amount;
// //   int maxQuantity;
// //
// //   EventFeeObjectList(
// //       {this.eventFeeId,
// //         this.eventIdx,
// //         this.category,
// //         this.amount,
// //         this.maxQuantity});
// //
// //   EventFeeObjectList.fromJson(Map<String, dynamic> json) {
// //     eventFeeId = json['EventFeeIdx'];
// //     eventIdx = json['EventIdx'];
// //     category = json['CatName'];
// //     amount = json['Amount'];
// //     maxQuantity = json['MaxQuantity'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['EventResourceIdx'] = this.eventFeeId;
// //     data['EventIdx'] = this.eventIdx;
// //     data['CatName'] = this.category;
// //     data['Amount'] = this.amount;
// //     data['MaxQuantity'] = this.maxQuantity;
// //     return data;
// //   }
// // }
// //
//
//
//
 import 'all_event_response.dart';



class EventRegisterRequest {
  int eventIdx;
  int hostIdx;
  String artworkPath;
  String eventName;
  String eventDescription;
  String eventDate;
  String eventTime;
  String eventVenue;
  String venueMapReference;
  int eventCatIdx;
  int eventModeIdx;
  String artWorkName;
  String onlineLink;
  String closingDate;
  bool isEarlyBird;
  String earlyBirdEndDate;
  int eBDiscountRate;
  bool isPaidEvent;
  bool isSpeakerAvailable;
  String termsCondition;
  int eventStatusIdx;
  int createdUserIdx;
  bool chequePayment;
  bool cashOnPayment;
  bool onlinePayment;
  bool bankTransferPayment;
  List<EventResourceObjectList> eventResourceObjectList;
  List<EventFeeObjectList> eventFeeObjectList;

  EventRegisterRequest(
      {this.eventIdx,
        this.hostIdx,
        this.artworkPath,
        this.eventName,
        this.eventDescription,
        this.eventDate,
        this.eventTime,
        this.eventVenue,
        this.venueMapReference,
        this.eventCatIdx,
        this.eventModeIdx,
        this.artWorkName,
        this.onlineLink,
        this.closingDate,
        this.isEarlyBird,
        this.earlyBirdEndDate,
        this.eBDiscountRate,
        this.isPaidEvent,
        this.isSpeakerAvailable,
        this.termsCondition,
        this.eventStatusIdx,
        this.createdUserIdx,
        this.chequePayment,
        this.cashOnPayment,
        this.onlinePayment,
        this.bankTransferPayment,
        this.eventResourceObjectList,
        this.eventFeeObjectList});

  EventRegisterRequest.fromJson(Map<String, dynamic> json) {
    eventIdx = json['EventIdx'];
    hostIdx = json['HostIdx'];
    artworkPath = json['ArtworkPath'];
    eventName = json['EventName'];
    eventDescription = json['EventDescription'];
    eventDate = json['EventDate'];
    eventTime = json['EventTime'];
    eventVenue = json['EventVenue'];
    venueMapReference = json['VenueMapReference'];
    eventCatIdx = json['EventCatIdx'];
    eventModeIdx = json['EventModeIdx'];
    artWorkName = json['ArtWorkName'];
    onlineLink = json['OnlineLink'];
    closingDate = json['ClosingDate'];
    isEarlyBird = json['IsEarlyBird'];
    earlyBirdEndDate = json['EarlyBirdEndDate'];
    eBDiscountRate = json['EBDiscountRate'];
    isPaidEvent = json['IsPaidEvent'];
    isSpeakerAvailable = json['IsSpeakerAvailable'];
    termsCondition = json['TermsCondition'];
    eventStatusIdx = json['EventStatusIdx'];
    createdUserIdx = json['CreatedUserIdx'];
    chequePayment = json['ChequePayment'];
    cashOnPayment = json['CashOnPayment'];
    onlinePayment = json['OnlinePayment'];
    bankTransferPayment = json['BankTransferPayment'];
    if (json['EventResourceObjectList'] != null) {
      eventResourceObjectList = <EventResourceObjectList>[];
      json['EventResourceObjectList'].forEach((v) {
        eventResourceObjectList.add(new EventResourceObjectList.fromJson(v));
      });
    }
    if (json['EventFeeObjectList'] != null) {
      eventFeeObjectList = <EventFeeObjectList>[];
      json['EventFeeObjectList'].forEach((v) {
        eventFeeObjectList.add(new EventFeeObjectList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EventIdx'] = this.eventIdx;
    data['HostIdx'] = this.hostIdx;
    data['ArtworkPath'] = this.artworkPath;
    data['EventName'] = this.eventName;
    data['EventDescription'] = this.eventDescription;
    data['EventDate'] = this.eventDate;
    data['EventTime'] = this.eventTime;
    data['EventVenue'] = this.eventVenue;
    data['VenueMapReference'] = this.venueMapReference;
    data['EventCatIdx'] = this.eventCatIdx;
    data['EventModeIdx'] = this.eventModeIdx;
    data['ArtWorkName'] = this.artWorkName;
    data['OnlineLink'] = this.onlineLink;
    data['ClosingDate'] = this.closingDate;
    data['IsEarlyBird'] = this.isEarlyBird;
    data['EarlyBirdEndDate'] = this.earlyBirdEndDate;
    data['EBDiscountRate'] = this.eBDiscountRate;
    data['IsPaidEvent'] = this.isPaidEvent;
    data['IsSpeakerAvailable'] = this.isSpeakerAvailable;
    data['TermsCondition'] = this.termsCondition;
    data['EventStatusIdx'] = this.eventStatusIdx;
    data['CreatedUserIdx'] = this.createdUserIdx;
    data['ChequePayment'] = this.chequePayment;
    data['CashOnPayment'] = this.cashOnPayment;
    data['OnlinePayment'] = this.onlinePayment;
    data['BankTransferPayment'] = this.bankTransferPayment;
    if (this.eventResourceObjectList != null) {
      data['EventResourceObjectList'] =
          this.eventResourceObjectList.map((v) => v.toJson()).toList();
    }
    if (this.eventFeeObjectList != null) {
      data['EventFeeObjectList'] =
          this.eventFeeObjectList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


//
// class EventRegisterRequest {
//   int eventIdx;
//   int hostIdx;
//   String artworkPath;
//   String eventName;
//   String eventDescription;
//   String eventDate;
//   String eventTime;
//   String eventVenue;
//   String venueMapReference;
//   int eventCatIdx;
//   int eventModeIdx;
//   String artWorkName;
//   String onlineLink;
//   String closingDate;
//   bool isEarlyBird;
//   String earlyBirdEndDate;
//   int eBDiscountRate;
//   bool isPaidEvent;
//   bool isSpeakerAvailable;
//   String termsCondition;
//   int eventStatusIdx;
//   int createdUserIdx;
//   bool chequePayment;
//   bool cashOnPayment;
//   bool onlinePayment;
//   bool bankTransferPayment;
//   List<EventResourceObjectList> eventResourceObjectList;
//   List<EventFeeObjectList> eventFeeObjectList;
//
//   EventRegisterRequest(
//       {this.eventIdx,
//         this.hostIdx,
//         this.artworkPath,
//         this.eventName,
//         this.eventDescription,
//         this.eventDate,
//         this.eventTime,
//         this.eventVenue,
//         this.venueMapReference,
//         this.eventCatIdx,
//         this.eventModeIdx,
//         this.artWorkName,
//         this.onlineLink,
//         this.closingDate,
//         this.isEarlyBird,
//         this.earlyBirdEndDate,
//         this.eBDiscountRate,
//         this.isPaidEvent,
//         this.isSpeakerAvailable,
//         this.termsCondition,
//         this.eventStatusIdx,
//         this.createdUserIdx,
//         this.chequePayment,
//         this.cashOnPayment,
//         this.onlinePayment,
//         this.bankTransferPayment,
//         this.eventResourceObjectList,
//         this.eventFeeObjectList});
//
//   EventRegisterRequest.fromJson(Map<String, dynamic> json) {
//     eventIdx = json['EventIdx'];
//     hostIdx = json['HostIdx'];
//     artworkPath = json['ArtworkPath'];
//     eventName = json['EventName'];
//     eventDescription = json['EventDescription'];
//     eventDate = json['EventDate'];
//     eventTime = json['EventTime'];
//     eventVenue = json['EventVenue'];
//     venueMapReference = json['VenueMapReference'];
//     eventCatIdx = json['EventCatIdx'];
//     eventModeIdx = json['EventModeIdx'];
//     artWorkName = json['ArtWorkName'];
//     onlineLink = json['OnlineLink'];
//     closingDate = json['ClosingDate'];
//     isEarlyBird = json['IsEarlyBird'];
//     earlyBirdEndDate = json['EarlyBirdEndDate'];
//     eBDiscountRate = json['EBDiscountRate'];
//     isPaidEvent = json['IsPaidEvent'];
//     isSpeakerAvailable = json['IsSpeakerAvailable'];
//     termsCondition = json['TermsCondition'];
//     eventStatusIdx = json['EventStatusIdx'];
//     createdUserIdx = json['CreatedUserIdx'];
//     chequePayment = json['ChequePayment'];
//     cashOnPayment = json['CashOnPayment'];
//     onlinePayment = json['OnlinePayment'];
//     bankTransferPayment = json['BankTransferPayment'];
//     if (json['EventResourceObjectList'] != null) {
//       eventResourceObjectList = <EventResourceObjectList>[];
//       json['EventResourceObjectList'].forEach((v) {
//         eventResourceObjectList.add(new EventResourceObjectList.fromJson(v));
//       });
//     }
//     if (json['EventFeeObjectList'] != null) {
//       eventFeeObjectList = <EventFeeObjectList>[];
//       json['EventFeeObjectList'].forEach((v) {
//         eventFeeObjectList.add(new EventFeeObjectList.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['EventIdx'] = this.eventIdx;
//     data['HostIdx'] = this.hostIdx;
//     data['ArtworkPath'] = this.artworkPath;
//     data['EventName'] = this.eventName;
//     data['EventDescription'] = this.eventDescription;
//     data['EventDate'] = this.eventDate;
//     data['EventTime'] = this.eventTime;
//     data['EventVenue'] = this.eventVenue;
//     data['VenueMapReference'] = this.venueMapReference;
//     data['EventCatIdx'] = this.eventCatIdx;
//     data['EventModeIdx'] = this.eventModeIdx;
//     data['ArtWorkName'] = this.artWorkName;
//     data['OnlineLink'] = this.onlineLink;
//     data['ClosingDate'] = this.closingDate;
//     data['IsEarlyBird'] = this.isEarlyBird;
//     data['EarlyBirdEndDate'] = this.earlyBirdEndDate;
//     data['EBDiscountRate'] = this.eBDiscountRate;
//     data['IsPaidEvent'] = this.isPaidEvent;
//     data['IsSpeakerAvailable'] = this.isSpeakerAvailable;
//     data['TermsCondition'] = this.termsCondition;
//     data['EventStatusIdx'] = this.eventStatusIdx;
//     data['CreatedUserIdx'] = this.createdUserIdx;
//     data['ChequePayment'] = this.chequePayment;
//     data['CashOnPayment'] = this.cashOnPayment;
//     data['OnlinePayment'] = this.onlinePayment;
//     data['BankTransferPayment'] = this.bankTransferPayment;
//     if (this.eventResourceObjectList != null) {
//       data['EventResourceObjectList'] =
//           this.eventResourceObjectList.map((v) => v.toJson()).toList();
//     }
//     if (this.eventFeeObjectList != null) {
//       data['EventFeeObjectList'] =
//           this.eventFeeObjectList.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
//
