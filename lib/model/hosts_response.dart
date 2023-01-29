class HostsResponse {
  List<Host> host;

  HostsResponse({this.host});

  HostsResponse.fromJson(Map<String, dynamic> json) {
    if (json['host'] != null) {
      host = <Host>[];
      json['host'].forEach((v) {
        host.add(new Host.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.host != null) {
      data['host'] = this.host.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Host {
  String hostIdx;
  String hostName;
  String hostImageName;
  String hostImagePath;
  String address1;
  String address11;
  String countryIdx;
  String telephone;
  String emailAddress;
  String contactPerson;
  String isHost;
  String isActive;
  String countryName;

  Host(
      {this.hostIdx,
        this.hostName,
        this.hostImageName,
        this.hostImagePath,
        this.address1,
        this.address11,
        this.countryIdx,
        this.telephone,
        this.emailAddress,
        this.contactPerson,
        this.isHost,
        this.isActive,
        this.countryName});

  Host.fromJson(Map<String, dynamic> json) {
    hostIdx = json['HostIdx'];
    hostName = json['HostName'];
    hostImageName = json['HostImageName'];
    hostImagePath = json['HostImagePath'];
    address1 = json['Address1'];
    address11 = json['Address11'];
    countryIdx = json['CountryIdx'];
    telephone = json['Telephone'];
    emailAddress = json['EmailAddress'];
    contactPerson = json['ContactPerson'];
    isHost = json['IsHost'];
    isActive = json['IsActive'];
    countryName = json['CountryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HostIdx'] = this.hostIdx;
    data['HostName'] = this.hostName;
    data['HostImageName'] = this.hostImageName;
    data['HostImagePath'] = this.hostImagePath;
    data['Address1'] = this.address1;
    data['Address11'] = this.address11;
    data['CountryIdx'] = this.countryIdx;
    data['Telephone'] = this.telephone;
    data['EmailAddress'] = this.emailAddress;
    data['ContactPerson'] = this.contactPerson;
    data['IsHost'] = this.isHost;
    data['IsActive'] = this.isActive;
    data['CountryName'] = this.countryName;
    return data;
  }
}
