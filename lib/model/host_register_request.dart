import 'dart:math';

class HostRegisterRequest {
  String businessName;
  String logoName;
  String logoPath;
  String address1;
  String address2;
  int countryIdx;
  String telephone;
  String emailAddress;
  String contactPerson;
  int hostIdx;

  HostRegisterRequest(
      {
        this.businessName,
        this.logoName,
        this.logoPath,
        this.address1,
        this.address2,
        this.countryIdx,
        this.telephone,
        this.emailAddress,
        this.contactPerson,
        this.hostIdx
      });

  HostRegisterRequest.fromJson(Map<String, dynamic> json) {
    businessName = json['BusinessName'];
    logoName = json['LogoName'];
    logoPath = json['LogoPath'];
    address1 = json['Address1'];
    address2 = json['Address2'];
    emailAddress = json['EmailAddress'];
    countryIdx = json['CountryIdx'];
    telephone = json['Telephone'];
    contactPerson = json['ContactPerson'];
    hostIdx = json['HostIdx'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BusinessName'] = this.businessName;
    data['LogoName'] = this.logoName;
    data['LogoPath'] = this.logoPath;
    data['Address1'] = this.address1;
    data['Address2'] = this.address2;
    data['EmailAddress'] = this.emailAddress;
    data['CountryIdx'] = this.countryIdx;
    data['Telephone'] = this.telephone;
    data['ContactPerson'] = this.contactPerson;
    data['HostIdx'] = this.hostIdx;
    return data;
  }
}
