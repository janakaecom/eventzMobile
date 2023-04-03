class CountryCodesResponse {
  List<CountryCodeCountries> countryCodeCountries;

  CountryCodesResponse({this.countryCodeCountries});

  CountryCodesResponse.fromJson(Map<String, dynamic> json) {
    if (json['country'] != null) {
      countryCodeCountries = <CountryCodeCountries>[];
      json['country'].forEach((v) {
        countryCodeCountries.add(new CountryCodeCountries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countryCodeCountries != null) {
      data['country'] = this.countryCodeCountries.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CountryCodeCountries {
  String countryIdx;
  String countryName;
  String countryCode;

  CountryCodeCountries({this.countryIdx, this.countryName, this.countryCode});

  CountryCodeCountries.fromJson(Map<String, dynamic> json) {
    countryIdx = json['CountryIdx'];
    countryName = json['CountryName'];
    countryCode = json['CountryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CountryIdx'] = this.countryIdx;
    data['CountryName'] = this.countryName;
    data['CountryCode'] = this.countryCode;
    return data;
  }
}
