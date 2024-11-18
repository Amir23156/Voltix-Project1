import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltix/config.dart';
import 'package:voltix/screens/CircuitBreakerInterface/CircuitBreakerElement.dart';
import 'package:voltix/screens/ZonesInterfaces/Zones.dart';
import 'package:voltix/shared/barre_de_recherche.dart';
import '../../Provider/ListeProvider.dart';
import '../../Services/CircuitBreakerService.dart';
import '../../shared/menu_container.dart';
import '../SitesInterface/sites.dart';
import 'add-circuit-breaker.dart';
import 'update-circuit-breaker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../PageContent.dart';

class CircuitBreakersScreen extends StatefulWidget {
  var zone;

  CircuitBreakersScreen({Key? key, required this.zone});

  @override
  State<CircuitBreakersScreen> createState() => _CircuitBreakersScreenState();
}

class _CircuitBreakersScreenState extends State<CircuitBreakersScreen> {
  List<Map<String, dynamic>> circuitBreakers = [];
  bool isLoading = true;
  late TextEditingController searchController;
  final CircuitBreakerService apiService = CircuitBreakerService();
  var counter;
  void filterList(String searchText) {
    final listeProvider = Provider.of<ListeProvider>(context, listen: false);

    List<Map<String, dynamic>> MachineListe = listeProvider.liste;

    var filtredListe = (MachineListe)
        .where((item) =>
            item["siteName"].toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    listeProvider.EditFiltredListe(filtredListe);
  }

  @override
  void initState() {
    super.initState();
    counter = Provider.of<ListeProvider>(context, listen: false);
    counter = Provider.of<ListeProvider>(context, listen: false);
    counter.InizializeListeWithoutNotifier(circuitBreakers, "circuitBreaker");
    fetchCircuitBreakers();
    searchController = TextEditingController();
  }

  Future<String> fetchCircuitBreakers() async {
    final url =
        '${AppConfig.apiKey}/cuircuitBreaker/getCircuitBreakerForZone/${widget.zone["id"]}';
    final response = await http.get(Uri.parse(url));

    if ((response.statusCode == 200) || (response.statusCode == 202)) {
      // Traitement des données de la réponse ici
      setState(() {
        circuitBreakers = List<Map<String, dynamic>>.from(
          json.decode(response.body) as List<dynamic>,
        );
        counter.InizializeListe(circuitBreakers, "circuitBreaker");
      });

      isLoading = false;
    } else {
      print('Erreur lors de l\'appel API : ${response.statusCode}');
      isLoading = false;
    }
    return (response.body);
  }

  @override
  Widget build(BuildContext context) {
    final listeProv = Provider.of<ListeProvider>(context);
    //listeProv.InizializeListeWithoutNotifier(circuitBreakers, "circuitBreaker");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/logo.png',
                  width: 115,
                  height: 115,
                ),
              ],
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 50,
            color: Color(0xFFF2F2F2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PageContent(
                                content: ZonesScreen(
                                    building: widget.zone['building'])),
                          ));
                    },
                    child: const Icon(
                      Icons.arrow_back_outlined,
                      size: 25.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Circuit Breakers',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          BarreDeRecherche(filterList: filterList),
          SizedBox(height: 15),
          ((listeProv.PageName == "circuitBreaker")
              ? Column(
                  children: listeProv.filtredListe.map(
                    (data) {
                      return CircuitBreakerElement(
                        element: data,
                        fetchdata: () {
                          fetchCircuitBreakers();
                        },
                        onUpdatePressed: (selectedElement) {
                          _navigateToMachineInterface(selectedElement);
                        },
                        onDeletePressed: (selectedElement) {
                          apiService.deleteCircuitBreaker(
                              selectedElement); // Calls the delete function
                          fetchCircuitBreakers();
                        },
                      );
                    },
                  ).toList(),
                )
              : Center(child: CircularProgressIndicator())),
          SizedBox(height: 105),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PageContent(content: AddCircuitBreaker(zone: widget.zone)),
              ));
        },
        child: Image.asset('assets/Vectoradd.png'),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  void _searchCircuitBreakers(String query) {
    fetchCircuitBreakers();
  }

  Future<void> _deleteCircuitBreaker(Map<String, dynamic> element) async {
    try {
      // Implement your delete functionality here
      // You can use the deleteCircuitBreaker function you provided earlier
      await apiService.deleteCircuitBreaker(element['id']);
      // After successful deletion, you may want to refresh the circuitBreakers list
      fetchCircuitBreakers();
    } catch (e) {
      print("Error deleting circuit breaker: $e");
      // Handle error
    }
  }

  void _navigateToMachineInterface(Map<String, dynamic> selectedElement) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PageContent(
              content: UpdateCircuitBreaker(
            selectedElement: selectedElement,
          )),
        ));
  }
}








/*class BarreDeRecherche extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;

  BarreDeRecherche({
    required this.searchController,
    required this.onSearch,
  });

>>>>>>> amir
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: searchController,
        onChanged: onSearch,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search circuit breakers...',
        ),
      ),
    );
  }
}*/