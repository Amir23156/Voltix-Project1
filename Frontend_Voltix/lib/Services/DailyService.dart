import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voltix/config.dart';
import 'package:voltix/models/zone.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class DailyService {
  Future<List<Map<String, dynamic>>> findAllDailysByZone(
      Zone zoneReceived) async {
    DateTime now = DateTime.now(); // Get the current date and time
    DateTime dateOnly = DateTime(
        now.year, now.month, now.day); // Set the time to midnight (00:00:00)

    // URI
    var uri = Uri.parse(
        "${AppConfig.apiKey}/zoneConsomation/getZoneConsomationBetwenDate");
    var endDate = DateTime.now();
    String endDateString = DateFormat('yyyy-MM-ddTHH:mm:ss').format(endDate);

    var startDate = endDate.subtract(Duration(hours: 24));

    String StartDateString = DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateOnly);
    
    Map data = {
      'dateFin': endDateString,
      'dateDebut': StartDateString,
      "zone": zoneReceived.toJson(),
      'type': "daily",
      //'endDate':endDate',
    };

    var body = json.encode(data);
    final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body);
   
    //var response = await http.get(uri);
    if ((response.statusCode == 200) || (response.statusCode == 202)) {
      List<Map<String, dynamic>> DataListe = [];
      DataListe = List<Map<String, dynamic>>.from(
        json.decode(response.body) as List<dynamic>,
      );

      return DataListe;
    } else {
      throw Exception("Failed to load Daily");
    }
  }

  Future<List<Map<String, dynamic>>> findAllDailys() async {
    DateTime now = DateTime.now(); // Get the current date and time
    DateTime dateOnly = DateTime(
        now.year, now.month, now.day); // Set the time to midnight (00:00:00)

    // URI
    var uri = Uri.parse(
        "${AppConfig.apiKey}/zoneConsomation/getZoneConsomationBetwenDateForAll");
    var endDate = DateTime.now();
    DateTime firstHour = DateTime(now.year, now.month, now.day);

    // Set the time to the last hour of the day (23:59:59)
    DateTime lastHour = DateTime(now.year, now.month, now.day, 23, 59, 59);
    String endDateString = DateFormat('yyyy-MM-ddTHH:mm:ss').format(endDate);

    var startDate = endDate.subtract(Duration(hours: 24));

    String StartDateString = DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateOnly);

    Map data = {
      'dateFin': endDateString,
      'dateDebut': StartDateString,
      'type': "daily",
      //'endDate':endDate',
    };

    var body = json.encode(data);
    final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body);
   
    //var response = await http.get(uri);
    if ((response.statusCode == 200) || (response.statusCode == 202)) {
      List<Map<String, dynamic>> DataListe = [];
      DataListe = List<Map<String, dynamic>>.from(
        json.decode(response.body) as List<dynamic>,
      );

      return DataListe;
    } else {
      throw Exception("Failed to load Daily");
    }
  }
}
