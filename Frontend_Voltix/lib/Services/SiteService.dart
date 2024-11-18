import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:voltix/config.dart';
import '../models/circuitbreaker.dart';
import '../models/site.dart';

class SiteService {
  Future<http.Response> addSite(String siteName, String siteLocation) async {
    var response;
    try {
      var uri = Uri.parse('${AppConfig.apiKey}/site/AddSite');
      Map<String, String> headers = {"Content-Type": "application/json"};

      Map data = {
        'siteName': '$siteName',
        'siteLocation': '$siteLocation',
      };
      var body = json.encode(data);
      response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode != 202) {
        throw Exception('Failed to ADD site');
      }
    } catch (e) {
      print("Error adding sites: $e");
      print(e);
    }
    return response;
  }

 

  Future<CircuitBreaker> getSiteByName(String siteName) async {
    final response = await http
        .get(Uri.parse('${AppConfig.apiKey}/site/FindSiteByName/$siteName'));

    if (response.statusCode == 202) {
      var jsonData = json.decode(response.body);
      return CircuitBreaker.fromJson(jsonData);
    } else if (response.statusCode == 404) {
      throw Exception('Circuit breaker not found');
    } else {
      throw Exception('Failed to fetch circuit breaker');
    }
  }

  Future<void> deleteSite(String id) async {
    final response =
        await http.delete(Uri.parse('${AppConfig.apiKey}/site/DeleteSite/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete site');
    }
  }

  Future<void> updateSite(String id, Site updatedSite) async {
    var uri = Uri.parse('${AppConfig.apiKey}/site/UpdateSite/$id');
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode(updatedSite.toJson());

    var response = await http.put(uri, headers: headers, body: body);
    if (response.statusCode == 200) {
      print('site updated successfully');
      return;
    } else if (response.statusCode == 404) {
      throw Exception('site not found');
    } else {
      throw Exception('Failed to update site');
    }
  }
}
