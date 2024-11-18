import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voltix/config.dart';
import 'package:voltix/models/zone.dart';
import 'package:voltix/models/Daily.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:intl/date_symbol_data_local.dart';

class WeeklyService {
  Future<List<Map<String, dynamic>>> FindAllWeeklys() async {
    // URI
    var uri = Uri.parse(
        "${AppConfig.apiKey}/zoneConsomation/getZoneConsomationBetwenDateForAll");
    var endDate = DateTime.now();
    String endDateString = DateFormat('yyyy-MM-ddTHH:mm:ss').format(endDate);
    DateTime startDate = endDate.subtract(Duration(days: 7));

    String StartDateString =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(startDate);

    DateTime currentDate = DateTime.now();

    // Calculate the difference between the current day (Wednesday = 3) and Monday (1)
    int daysUntilMonday = (currentDate.weekday + 7 - 1) % 7;

    // Calculate the first day of the week (Monday)
    DateTime firstDayOfWeek =
        currentDate.subtract(Duration(days: daysUntilMonday));

    // Calculate the last day of the week (Sunday)
    DateTime lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));

    // Format the dates as strings
    String formattedFirstDay = DateFormat('yyyy-MM-dd').format(firstDayOfWeek);
    String formattedLastDay = DateFormat('yyyy-MM-dd').format(lastDayOfWeek);
   
    Map data = {
      'dateFin': formattedLastDay,
      'dateDebut': formattedFirstDay,
      'type': "weekly",
      //'endDate':endDate',
    };

    var body = json.encode(data);
    final response = await http.post(uri,
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
      throw Exception("Failed to load weekly");
    }
  }

  Future<List<Map<String, dynamic>>> FindAllWeeklysforZone(Zone zone) async {
    // URI
    var uri = Uri.parse(
        "${AppConfig.apiKey}/zoneConsomation/getZoneConsomationBetwenDate");
    var endDate = DateTime.now();
    String endDateString = DateFormat('yyyy-MM-ddTHH:mm:ss').format(endDate);
    DateTime startDate = endDate.subtract(Duration(days: 7));

    String StartDateString =
        DateFormat('yyyy-MM-ddTHH:mm:ss').format(startDate);

    DateTime currentDate = DateTime.now();

    // Calculate the difference between the current day (Wednesday = 3) and Monday (1)
    int daysUntilMonday = (currentDate.weekday + 7 - 1) % 7;

    // Calculate the first day of the week (Monday)
    DateTime firstDayOfWeek =
        currentDate.subtract(Duration(days: daysUntilMonday));

    // Calculate the last day of the week (Sunday)
    DateTime lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));

    // Format the dates as strings
    String formattedFirstDay = DateFormat('yyyy-MM-dd').format(firstDayOfWeek);
    String formattedLastDay = DateFormat('yyyy-MM-dd').format(lastDayOfWeek);
    
    Map data = {
      'dateFin': formattedLastDay,
      'dateDebut': formattedFirstDay,
      "zone": zone.toJson(),
      'type': "weekly",
      //'endDate':endDate',
    };

    var body = json.encode(data);
    final response = await http.post(uri,
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
      throw Exception("Failed to load weekly");
    }
  }
}
