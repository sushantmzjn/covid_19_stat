import 'package:covid_stat/features/covid/data/model/country_stat.dart';
import 'package:covid_stat/features/covid/data/model/covid.dart';
import 'package:covid_stat/network/api.dart';
import 'package:covid_stat/network/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allCovidStatProvider =
    FutureProvider((ref) => CovidProvider.getAllCovidStat());

class CovidProvider {
  static Future<Covid> getAllCovidStat() async {
    try {
      final res = await API().get(EndPoint.getAll);
      final data = Covid.fromJson(res.data);
      return data;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            'Error in getting data ${e.response!.statusCode} : ${e.response!.statusMessage}');
        throw ('Error in getting data ${e.response!.statusCode} : ${e.response!.statusMessage}');
      } else {
        debugPrint('Error in getting data: ${e.message}');
        throw ('Error in getting data: ${e.message}');
      }
    }
  }
}

// get specific country covid stat

final countryStatProvider =
    FutureProvider((ref) => CountryStatProvider.getCountryStat());

class CountryStatProvider {
  static Future<List<CountryStat>> getCountryStat() async {
    try {
      final res = await API().get(EndPoint.getAllCountries);
      final data =
          (res.data as List).map((e) => CountryStat.fromJson(e)).toList();
      return data;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            'Error in getting data ${e.response!.statusCode} : ${e.response!.statusMessage}');
        throw ('Error in getting data ${e.response!.statusCode} : ${e.response!.statusMessage}');
      } else {
        debugPrint('Error in getting data: ${e.message}');
        throw ('Error in getting data: ${e.message}');
      }
    }
  }
}

// search  covid stat by country

final searchCountryStatProvider = FutureProvider.family(
    (ref, String searchText) =>
        SearchCountryStatPorvider.getSearchCountryStat(searchText: searchText));

class SearchCountryStatPorvider {
  static Future<CountryStat> getSearchCountryStat(
      {required String searchText}) async {
    try {
      final res = await API().get('${EndPoint.getAllCountries}/$searchText');
      final data = CountryStat.fromJson(res.data);
      return data;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(
            'Error in getting data ${e.response!.statusCode} : ${e.response!.statusMessage}');
        throw ('Error in getting data ${e.response!.statusCode} : ${e.response!.statusMessage}');
      } else {
        debugPrint('Error in getting data: ${e.message}');
        throw ('Error in getting data: ${e.message}');
      }
    }
  }
}
