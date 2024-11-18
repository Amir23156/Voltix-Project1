import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:voltix/config.dart';
import '../models/circuitbreaker.dart';

class CircuitBreakerService {
  Future<http.Response> addCircuitBreaker(
      String circuitBreakerName, String circuitBreakerReference, zone) async {
    var response;
    try {
      var uri = Uri.parse('${AppConfig.apiKey}/cuircuitBreaker/AddCircuitBreaker');
      Map<String, String> headers = {"Content-Type": "application/json"};

      Map data = {
        'LimitConsomation': 0,
        'circuitBreakerName': '$circuitBreakerName',
        'circuitBreakerRefrence': '$circuitBreakerReference',
        'zone': zone
      };
      var body = json.encode(data);
      response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode != 202) {
        throw Exception('Failed to ADD circuit breaker');
      }
    } catch (e) {
      print("Error adding circuitbreakers: $e");
      print(e);
    }
    return response;
  }

  Future<CircuitBreaker> getCircuitBreakerByName(
      String circuitBreakerName) async {
    final response = await http.get(Uri.parse(
        '${AppConfig.apiKey}/cuircuitBreaker/FindCircuitBreakerByName/$circuitBreakerName'));

    if (response.statusCode == 202) {
      var jsonData = json.decode(response.body);
      return CircuitBreaker.fromJson(jsonData);
    } else if (response.statusCode == 404) {
      throw Exception('Circuit breaker not found');
    } else {
      throw Exception('Failed to fetch circuit breaker');
    }
  }

  Future<void> deleteCircuitBreaker(String id) async {
    final response = await http
        .delete(Uri.parse('${AppConfig.apiKey}/cuircuitBreaker/DeleteCircuitBreaker/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete circuit breaker');
    }
  }

  Future<void> updateCircuitBreaker(
      String id, CircuitBreaker updatedCircuitBreaker) async {
    var uri = Uri.parse('${AppConfig.apiKey}/cuircuitBreaker/UpdateCircuitBreaker/$id');
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode(updatedCircuitBreaker.toJson());

    var response = await http.put(uri, headers: headers, body: body);
   
    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 404) {
      throw Exception('Circuit breaker not found');
    } else {
      throw Exception('Failed to update circuit breaker');
    }
  }
}
