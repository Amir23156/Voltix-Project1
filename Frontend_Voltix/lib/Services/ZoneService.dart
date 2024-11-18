import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voltix/config.dart';
import '../models/zone.dart';

class ZoneService {
  Future<http.Response> AddZone(
      building,
      String zoneName,
      String zoneSurface,
      String zoneMainActivity,
      List<String> attendanceDays,
      String? workStartTime,
      String? workEndTime) async {
    //uri
    var uri = Uri.parse("${AppConfig.apiKey}/zone/zoneAddZone");
    //header
    Map<String, String> headers = {"Content-Type": "application/json"};
    //body
    Map data = {
      'zoneName': '$zoneName',
      'zoneSurface': '$zoneSurface',
      'zoneMainActivity': '$zoneMainActivity',
      'attendanceDays': attendanceDays,
      'workStartTime': workStartTime.toString(),
      'workEndTime': workEndTime.toString(),
      'building': building,
    };
    var body = json.encode(data);
    var response = await http.post(uri, headers: headers, body: body);

    return response;
  }

  Future<List<Zone>> findAllZones() async {
    // URI
    var uri = Uri.parse("${AppConfig.apiKey}/zone/FindAllZones");

    try {
      var response = await http.get(uri);
      if (response.statusCode == 202) {
        List<dynamic> jsonResponse = json.decode(response.body);
        List<Zone> zones =
            jsonResponse.map((json) => Zone.fromJson(json)).toList();
        return zones;
      } else {
        throw Exception("Failed to load zones");
      }
    } catch (e) {
      print("Error fetching zones: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getZonesForBuilding(building) async {
    var uri = Uri.parse(
        "${AppConfig.apiKey}/zone/getZonesForBuilding/${building['id']}");

    try {
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> zones = List<Map<String, dynamic>>.from(
          json.decode(response.body) as List<dynamic>,
        );
        /* List<Building> buildings =
            jsonResponse.map((json) => Building.fromJson(json)).toList();*/
        return zones;
      } else {
        throw Exception("Failed to load zones for building");
      }
    } catch (e) {
      print("Error fetching zones for building: $e");
      return [];
    }
  }

  Future<http.Response> deleteZone(zone) async {
    var uri = Uri.parse(
        "${AppConfig.apiKey}/zone/DeleteZone/${zone['id']}"); // Replace with your API endpoint
    var headers = {"Content-Type": "application/json"};
    var response = await http.delete(uri, headers: headers);

    return response;
  }

  Future<http.Response> updateZone(
    String id,
    String zoneName,
    String zoneSurface,
    String zoneMainActivity,
    List<String> attendanceDays,
    String? workStartTime,
    String? workEndTime,
  ) async {
    var uri = Uri.parse(
        "${AppConfig.apiKey}/zone/UpdateZone/$id"); // Replace with your API endpoint
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map data = {
      'zoneName': zoneName,
      'zoneSurface': zoneSurface,
      'zoneMainActivity': zoneMainActivity,
      'attendanceDays': attendanceDays,
      'workStartTime': workStartTime.toString(),
      'workEndTime': workEndTime.toString(),
    };
    var body = json.encode(data);
    var response = await http.put(uri, headers: headers, body: body);

    return response;
  }
}
