import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:voltix/Provider/ListeProvider.dart';
import 'package:voltix/config.dart';

class CustomDialog extends StatefulWidget {
  var Circuitbreaker;

  CustomDialog({super.key, required this.Circuitbreaker});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  late TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(
        text: widget.Circuitbreaker['limitConsomation'].toString());
  }

  Future<void> updateCircuitBreaker(listeProv) async {
    var uri = Uri.parse(
        '${AppConfig.apiKey}/cuircuitBreaker/Updatelimit/${widget.Circuitbreaker["id"]}');
    setState(() {
      widget.Circuitbreaker["limitConsomation"] = _textEditingController.text;
    });

    final headers = {'Content-Type': 'application/json'};
    final body = widget.Circuitbreaker;

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      listeProv.EditElement(widget.Circuitbreaker);
    } else if (response.statusCode == 404) {
      throw Exception('Circuit breaker not found');
    } else {
      throw Exception('Failed to update circuit breaker');
    }
  }

  @override
  Widget build(BuildContext context) {
    final listeProv = Provider.of<ListeProvider>(context);

    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Edit limit of ${widget.Circuitbreaker["circuitBreakerName"]}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 8.0),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: "Saisissez une valeur",
              ),
            ),
            SizedBox(height: 16.0),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              buttonMinWidth: 190, // Ajustez la largeur minimale des boutons
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text("Fermer"),
                ),
                ElevatedButton(
                  onPressed: () {
                    updateCircuitBreaker(listeProv);
                    // Vous pouvez faire quelque chose avec enteredValue ici
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: Text("OK"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
