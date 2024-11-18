import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voltix/config.dart';
import 'package:voltix/models/EnergyStat.dart';

class EnergyStatService {
  Future<List<EnergyStats>> FindAllEnergyStats() async {
    // URI
    var uri = Uri.parse("${AppConfig.apiKey}/energyStat/FindAllEnergyStatss");

    var response = await http.get(uri);
    if (response.statusCode == 202) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<EnergyStats> energyStats =
          jsonResponse.map((json) => EnergyStats.fromJson(json)).toList();

      return energyStats;
    } else {
      throw Exception("Failed to load EnergyStats");
    }
  }
}
