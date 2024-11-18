import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voltix/config.dart';
import 'package:voltix/models/Daily.dart';
import 'package:voltix/models/zone.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:intl/date_symbol_data_local.dart';

class MonthlyService {
  Future<List<Map<String, dynamic>>> FindAllMonthlys() async {
    // URI
    var uri =
        "${AppConfig.apiKey}/zoneConsomation/getZoneConsomationBetwenDateForAll";
    DateTime currentDate = DateTime.now();

    // Calculate the first day of the current month
    DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);

    // Calculate the last day of the current month
    DateTime lastDayOfMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0);

    String StartDateString =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(firstDayOfMonth);
    String lastDayOfMonthString =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(lastDayOfMonth);

    Map data = {
      'dateFin': lastDayOfMonthString,
      'dateDebut': StartDateString,
      'type': "monthly",
      //'endDate':endDate',
    };
    try {
      var body = json.encode(data);
      final response = await http.post(Uri.parse(uri),
          headers: {
            'Content-Type': 'application/json',
          },
          body: body);

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
        throw Exception("Failed to load monthly");
      }
    } catch (e) {
      print("Error fetching Daily: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> FindAllMonthlysByZone(Zone zone) async {
    // URI
    var uri =
        "${AppConfig.apiKey}/zoneConsomation/getZoneConsomationBetwenDate";
    DateTime currentDate = DateTime.now();

    // Calculate the first day of the current month
    DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);

    // Calculate the last day of the current month
    DateTime lastDayOfMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0);

    String StartDateString =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(firstDayOfMonth);
    String lastDayOfMonthString =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(lastDayOfMonth);

    Map data = {
      'dateFin': lastDayOfMonthString,
      'dateDebut': StartDateString,
      "zone": zone.toJson(),

      'type': "monthly",
      //'endDate':endDate',
    };
    try {
      var body = json.encode(data);
      final response = await http.post(Uri.parse(uri),
          headers: {
            'Content-Type': 'application/json',
          },
          body: body);

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
        throw Exception("Failed to load monthly");
      }
    } catch (e) {
      print("Error fetching Daily: $e");
      return [];
    }
  }
}
