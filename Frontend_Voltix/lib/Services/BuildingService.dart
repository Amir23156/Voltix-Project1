import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:voltix/config.dart';
import '../models/building.dart';

class BuildingService {
  Future<http.Response> AddBuilding(
      String buildingName, String buildingLocation, site) async {
    //uri
    var uri = Uri.parse("${AppConfig.apiKey}/building/AddBuilding");
    //header
    Map<String, String> headers = {"Content-Type": "application/json"};
    //body
    Map data = {
      'buildingName': '$buildingName',
      'buildingLocation': '$buildingLocation',
      'site': site
    };

    var body = json.encode(data);
    var response = await http.post(uri, headers: headers, body: body);

    return response;
  }

  Future<List<Map<String, dynamic>>> findAllBuildings(site) async {
    // URI
    var uri =
        Uri.parse("${AppConfig.apiKey}/building/getBuildingsForSite/${site['id']}");

    try {
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> BuildingsDataList =
            List<Map<String, dynamic>>.from(
          json.decode(response.body) as List<dynamic>,
        );
        /* List<Building> buildings =
            jsonResponse.map((json) => Building.fromJson(json)).toList();*/
        return BuildingsDataList;
      } else {
        throw Exception("Failed to load buildings");
      }
    } catch (e) {
      print("Error fetching buildings: $e");
      return [];
    }
  }

  Future<http.Response> deleteBuilding(String id) async {
    var uri = Uri.parse(
        "${AppConfig.apiKey}/building/DeleteBuilding/$id"); // Replace with your API endpoint
    var headers = {"Content-Type": "application/json"};
    var response = await http.delete(uri, headers: headers);


    return response;
  }

  Future<http.Response> updateBuilding(
    String id,
    String buildingName,
    String buildingLocation,
  ) async {
    var uri = Uri.parse(
        "${AppConfig.apiKey}/building/UpdateBuilding/$id"); // Replace with your API endpoint
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map data = {
      'buildingName': buildingName,
      'buildingLocation': buildingLocation,
    };
    var body = json.encode(data);
    var response = await http.put(uri, headers: headers, body: body);

    print("Update response: ${response.body}");

    return response;
  }
}
