class AllEventResponse {
  List<EventResult> result;

  AllEventResponse({this.result});

  AllEventResponse.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<EventResult>();
      json['result'].forEach((v) {
        result.add(new EventResult.fromJson(v));
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

class EventResult {
  String eventIdx;
  String hostIdx;
  String hostName;
  String eventCatIdx;
  String eventCatName;
  String eventName;
  String eventDate;
  String eventTime;
  String eventVenue;
  String eventDescription;
  String speakers;
  String artworkPath;
  String closingDate;
  String isPaidEvent;
  String eventStatusIdx;
  String eventStatusName;
  String currencyName;
  String amount;

  EventResult(
      {this.eventIdx,
      this.hostIdx,
      this.hostName,
      this.eventCatIdx,
      this.eventCatName,
      this.eventName,
      this.eventDate,
      this.eventTime,
      this.eventVenue,
      this.eventDescription,
      this.speakers,
      this.artworkPath,
      this.closingDate,
      this.isPaidEvent,
      this.eventStatusIdx,
      this.eventStatusName,
      this.currencyName,
      this.amount});

  EventResult.fromJson(Map<String, dynamic> json) {
    eventIdx = json['EventIdx'];
    hostIdx = json['HostIdx'];
    hostName = json['HostName'];
    eventCatIdx = json['EventCatIdx'];
    eventCatName = json['EventCatName'];
    eventName = json['EventName'];
    eventDate = json['EventDate'];
    eventTime = json['EventTime'];
    eventVenue = json['EventVenue'];
    eventDescription = json['EventDescription'];
    speakers = json['Speakers'];
    artworkPath = json['ArtworkPath'];
    closingDate = json['ClosingDate'];
    isPaidEvent = json['IsPaidEvent'];
    eventStatusIdx = json['EventStatusIdx'];
    eventStatusName = json['EventStatusName'];
    currencyName = json['CurrencyName'];
    amount = json['Amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EventIdx'] = this.eventIdx;
    data['HostIdx'] = this.hostIdx;
    data['HostName'] = this.hostName;
    data['EventCatIdx'] = this.eventCatIdx;
    data['EventCatName'] = this.eventCatName;
    data['EventName'] = this.eventName;
    data['EventDate'] = this.eventDate;
    data['EventTime'] = this.eventTime;
    data['EventVenue'] = this.eventVenue;
    data['EventDescription'] = this.eventDescription;
    data['Speakers'] = this.speakers;
    data['ArtworkPath'] = this.artworkPath;
    data['ClosingDate'] = this.closingDate;
    data['IsPaidEvent'] = this.isPaidEvent;
    data['EventStatusIdx'] = this.eventStatusIdx;
    data['EventStatusName'] = this.eventStatusName;
    data['CurrencyName'] = this.currencyName;
    data['Amount'] = this.amount;
    return data;
  }
}
