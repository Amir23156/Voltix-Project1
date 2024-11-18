import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voltix/config.dart';
import 'MachineElement.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import '../../Provider/ListeProvider.dart';

class MachineListe extends StatefulWidget {
  var circuitBreaker;

  MachineListe({super.key, required this.circuitBreaker});

  @override
  State<MachineListe> createState() => _MachineListeState();
}

class _MachineListeState extends State<MachineListe> {
  List<Map<String, dynamic>> machineDataList = [];
  bool isLoading = true;
  var counter;
  @override
  void initState() {
    super.initState();
    counter = Provider.of<ListeProvider>(context, listen: false);
    counter.InizializeListeWithoutNotifier(machineDataList, "machine");
    fetchDataFromAPI();
  }

  fetchDataFromAPI() async {
    try {
      setState(() {
        isLoading = true;
      });
      // circuitBreaker;
      final url =
          '${AppConfig.apiKey}/machine/getMachinesForCircuitBreaker/${widget.circuitBreaker['id']}';
      final response = await http.get(Uri.parse(url));
     
      if (response.statusCode == 200) {
        // Traitement des données de la réponse ici
      
        setState(() {
          machineDataList = List<Map<String, dynamic>>.from(
            json.decode(response.body) as List<dynamic>,
          );

          counter.InizializeListe(machineDataList, "machine");
        });

        isLoading = false;
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
    final listeProv = Provider.of<ListeProvider>(context);
    //listeProv.InizializeListeWithoutNotifier(machineDataList, "machine");
    return (isLoading || (listeProv.PageName != "machine"))
        ? CircularProgressIndicator()
        : Column(
            children: listeProv.filtredListe.map((data) {
              return Padding(
                padding: EdgeInsets.only(top: 16),
                child: MachineElement(
                  callback: fetchDataFromAPI,
                  element: data,
                ),
              );
            }).toList(),
          );
  }
}
