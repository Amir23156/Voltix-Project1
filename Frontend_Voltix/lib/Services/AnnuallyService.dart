import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voltix/config.dart';
import 'package:voltix/models/Daily.dart';
import 'package:voltix/models/zone.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:intl/date_symbol_data_local.dart';

class AnnuallyService {
  Future<List<Map<String, dynamic>>> FindAllAnnuallys() async {
    // URI
    var uri = Uri.parse(
        "${AppConfig.apiKey}/zoneConsomation/getZoneConsomationBetwenDateForAll");
    var endDate = DateTime.now();
    String endDateString = DateFormat('yyyy-MM-ddTHH:mm:ss').format(endDate);
    final firstDayOfYear = DateTime(endDate.year, 1, 1);

    // Get the last day of the current year
    final lastDayOfYear = DateTime(endDate.year, 12, 31);
    var startDate = endDate.subtract(Duration(days: 365));

    String StartDateString =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(firstDayOfYear);
    String FinishDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(lastDayOfYear);

    Map data = {
      'dateFin': FinishDate,
      'dateDebut': StartDateString,
      'type': "annully",
      //'endDate':endDate',
    };
    var body = json.encode(data);
    final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body);
   
    // var response = await http.get(uri);
    if ((response.statusCode == 200) || (response.statusCode == 202)) {
      List<Map<String, dynamic>> DataListe = [];
      DataListe = List<Map<String, dynamic>>.from(
        json.decode(response.body) as List<dynamic>,
      );
      // List<dynamic> jsonResponse = json.decode(response.body);
      // List<Daily> daily =
      //   jsonResponse.map((json) => Daily.fromJson(json)).toList();
      return DataListe;
    } else {
      throw Exception("Failed to load annually");
    }
  }

  Future<List<Map<String, dynamic>>> FindAllAnnuallysByzone(
      Zone zoneReceived) async {
    // URI
    var uri = Uri.parse(
        "${AppConfig.apiKey}/zoneConsomation/getZoneConsomationBetwenDate");
    var endDate = DateTime.now();
    String endDateString = DateFormat('yyyy-MM-ddTHH:mm:ss').format(endDate);
    final firstDayOfYear = DateTime(endDate.year, 1, 1);

    // Get the last day of the current year
    final lastDayOfYear = DateTime(endDate.year, 12, 31);
    var startDate = endDate.subtract(Duration(days: 365));

    String StartDateString =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(firstDayOfYear);
    String FinishDate = DateFormat('yyyy-MM-ddTHH:mm:ss').format(lastDayOfYear);
    Map data = {
      'dateFin': FinishDate,
      'dateDebut': StartDateString,
      "zone": zoneReceived.toJson(),
      'type': "annully",
      //'endDate':endDate',
    };

    var body = json.encode(data);
    final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body);
   
    // var response = await http.get(uri);
    if ((response.statusCode == 200) || (response.statusCode == 202)) {
      List<Map<String, dynamic>> DataListe = [];
      DataListe = List<Map<String, dynamic>>.from(
        json.decode(response.body) as List<dynamic>,
      );
      // List<dynamic> jsonResponse = json.decode(response.body);
      // List<Daily> daily =
      //   jsonResponse.map((json) => Daily.fromJson(json)).toList();
      return DataListe;
    } else {
      throw Exception("Failed to load annually");
    }
  }
}
