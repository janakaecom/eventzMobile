class CountriesResponse {
  List<Country> country;

  CountriesResponse({this.country});

  CountriesResponse.fromJson(Map<String, dynamic> json) {
    if (json['country'] != null) {
      country = <Country>[];
      json['country'].forEach((v) {
        country.add(new Country.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.country != null) {
      data['country'] = this.country.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Country {
  String countryIdx;
  String countryName;
  String countryCode;

  Country({this.countryIdx, this.countryName, this.countryCode});

  Country.fromJson(Map<String, dynamic> json) {
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

