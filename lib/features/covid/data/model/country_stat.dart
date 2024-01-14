// ignore_for_file: public_member_api_docs, sort_constructors_first
class CountryStat {
  CountryInfo countryInfo;
  String country;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int todayRecovered;
  int active;
  int critical;
  int tests;
  int population;
  String continent;

  CountryStat({
    required this.country,
    required this.cases,
    required this.countryInfo,
    required this.active,
    required this.critical,
    required this.tests,
    required this.population,
    required this.continent,
    required this.todayCases,
    required this.deaths,
    required this.recovered,
    required this.todayDeaths,
    required this.todayRecovered,
  });

  factory CountryStat.fromJson(Map<String, dynamic> json) {
    return CountryStat(
      country: json['country'],
      cases: json['cases'],
      countryInfo: CountryInfo.fromJson(json['countryInfo'] ?? {}),
      active: json['active'] ?? 0,
      critical: json['critical'] ?? 0,
      tests: json['tests'] ?? 0,
      population: json['population'] ?? 0,
      continent: json['continent'] ?? '',
      todayCases: json['todayCases'] ?? 0,
      deaths: json['deaths'] ?? 0,
      recovered: json['recovered'] ?? 0,
      todayDeaths: json['todayDeaths'] ?? 0,
      todayRecovered: json['todayRecovered'] ?? 0,
    );
  }
}

class CountryInfo {
  int id;
  double lat;
  double lon;
  String iso2;
  String flag;
  CountryInfo({
    required this.id,
    this.lat = 0.0,
    this.lon = 0.0,
    required this.iso2,
    required this.flag,
  });

  factory CountryInfo.fromJson(Map<String, dynamic> json) {
    return CountryInfo(
      id: json['_id'] ?? 0,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['long'] as num).toDouble(),
      iso2: json['iso2'] ?? '',
      flag: json['flag'] ?? '',
    );
  }
}
