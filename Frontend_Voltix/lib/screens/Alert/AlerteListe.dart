import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voltix/config.dart';
import 'package:voltix/screens/Alert/AlerteElement.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import '../../Provider/ListeProvider.dart';

class AlerteListe extends StatefulWidget {
  AlerteListe({super.key});

  @override
  State<AlerteListe> createState() => _AlerteListe();
}

class _AlerteListe extends State<AlerteListe> {
  List<Map<String, dynamic>> alerteListe = [];
  bool isLoading = true;
  var counter;
  @override
  void initState() {
    super.initState();
    counter = Provider.of<ListeProvider>(context, listen: false);
    counter.InizializeListeWithoutNotifier(alerteListe, "alerte");
    fetchDataFromAPI();
  }

  EditDataFromAPI() async {
    try {
      setState(() {
        isLoading = true;
      });
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode(alerteListe);
      final url = '${AppConfig.apiKey}/Alerte/UpdateListe';
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
    } catch (e) {
      print(e);
    }
  }

  fetchDataFromAPI() async {
    final provider = Provider.of<ListeProvider>(context, listen: false);

    try {
      setState(() {
        isLoading = true;
      });

      final url = '${AppConfig.apiKey}/Alerte/allWithTotal';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Traitement des données de la réponse ici

        setState(() {
          alerteListe = List<Map<String, dynamic>>.from(
            json.decode(response.body) as List<dynamic>,
          );

          //provider.InizializeListe(machineDataList, "alerte");
        });

        await EditDataFromAPI();
        setState(() {
          isLoading = false;
        });
      } else {
        print('Erreur lors de l\'appel API : ${response.statusCode}');
        isLoading = false;
      }
      return (response.body);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final listeProv = Provider.of<ListeProvider>(context);
    // listeProv.InizializeListeWithoutNotifier(machineDataList, "alerte");
    //print(listeProv.filtredListe.length);

    return (isLoading == true)
        ? CircularProgressIndicator()
        : Column(
            children: alerteListe.map((data) {
              return Column(children: [
                SizedBox(height: 16),
                AlertContainer(color: Color(0xFF434198), element: data),
              ]);
            }).toList(),
          );
  }
}
