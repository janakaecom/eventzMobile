class VenueResponse {
  List<EventVenue> eventVenue;

  VenueResponse({this.eventVenue});

  VenueResponse.fromJson(Map<String, dynamic> json) {
    if (json['EventVenue'] != null) {
      eventVenue = <EventVenue>[];
      json['EventVenue'].forEach((v) {
        eventVenue.add(new EventVenue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eventVenue != null) {
      data['EventVenue'] = this.eventVenue.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventVenue {
  String venueIdx;
  String eventVenue;

  EventVenue({this.venueIdx, this.eventVenue});

  EventVenue.fromJson(Map<String, dynamic> json) {
    venueIdx = json['VenueIdx'];
    eventVenue = json['EventVenue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VenueIdx'] = this.venueIdx;
    data['EventVenue'] = this.eventVenue;
    return data;
  }
}
