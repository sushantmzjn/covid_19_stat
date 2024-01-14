class Covid {
  int updated;
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

  int affectedCountries;
  Covid({
    required this.updated,
    required this.tests,
    required this.cases,
    required this.todayCases,
    required this.deaths,
    required this.todayDeaths,
    required this.recovered,
    required this.todayRecovered,
    required this.active,
    required this.critical,
    required this.population,
    required this.affectedCountries,
  });

  factory Covid.fromJson(Map<String, dynamic> json) {
    return Covid(
      updated: json['updated'] ?? 0,
      cases: json['cases'] ?? 0,
      todayCases: json['todayCases'] ?? 0,
      tests: json['tests'] ?? 0,
      deaths: json['deaths'] ?? 0,
      todayDeaths: json['todayDeaths'] ?? 0,
      recovered: json['recovered'] ?? 0,
      todayRecovered: json['todayRecovered'] ?? 0,
      active: json['active'] ?? 0,
      critical: json['critical'] ?? 0,
      population: json['population'] ?? 0,
      affectedCountries: json['affectedCountries'] ?? 0,
    );
  }
}
