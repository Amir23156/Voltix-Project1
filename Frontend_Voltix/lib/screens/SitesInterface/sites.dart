import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltix/config.dart';
import 'package:voltix/screens/CircuitBreakerInterface/CircuitBreakerElement.dart';
import 'package:voltix/screens/HomeComponent/HomePage.dart';
import 'package:voltix/screens/SitesInterface/update-site.dart';
import 'package:voltix/shared/barre_de_recherche.dart';
import '../../Provider/ListeProvider.dart';
import '../../Services/CircuitBreakerService.dart';
import '../../Services/SiteService.dart';
import '../../shared/menu_container.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../PageContent.dart';
import 'SitesElement.dart';
import 'add-site.dart';

class SitesScreen extends StatefulWidget {
  const SitesScreen({Key? key});

  @override
  State<SitesScreen> createState() => _SitesScreenState();
}

class _SitesScreenState extends State<SitesScreen> {
  List<Map<String, dynamic>> sites = [];
  bool isLoading = true;
  late TextEditingController searchController;
  final SiteService apiService = SiteService();
  var counter;

  @override
  void initState() {
    super.initState();
    counter = Provider.of<ListeProvider>(context, listen: false);
    fetchSites();
    counter.InizializeListeWithoutNotifier(sites, "site");

    searchController = TextEditingController();
  }

  Future<String> fetchSites() async {
    final url = '${AppConfig.apiKey}/site/FindAllSite';
    final response = await http.get(Uri.parse(url));

    if ((response.statusCode == 200) || (response.statusCode == 202)) {
      // Traitement des données de la réponse ici
      setState(() {
        sites = List<Map<String, dynamic>>.from(
          json.decode(response.body) as List<dynamic>,
        );
        counter.InizializeListe(sites, "site");
      });
     
      isLoading = false;
    } else {
      print('Erreur lors de l\'appel API : ${response.statusCode}');
      isLoading = false;
    }
    return (response.body);
  }

  void filterList(String searchText) {
    final listeProvider = Provider.of<ListeProvider>(context, listen: false);

    List<Map<String, dynamic>> SitesListe = listeProvider.liste;
   
    var filtredListe = (SitesListe)
        .where((item) =>
            item["siteName"].toLowerCase().contains(searchText.toLowerCase()))
        .toList();
 
    listeProvider.EditFiltredListe(filtredListe);
  }

  @override
  Widget build(BuildContext context) {
    var listeProv = Provider.of<ListeProvider>(context);
    // listeProv.InizializeListeWithoutNotifier(sites);

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
                            builder: (context) =>
                                PageContent(content: HomeScreen()),
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
                  'Sites',
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
          ((listeProv.PageName == "site")
              ? Column(
                  children: listeProv.filtredListe.map(
                    (data) {
                      return SiteElement(
                        element: data,
                        fetchdata: () {
                          fetchSites();
                        },
                        onUpdatePressed: (selectedElement) {
                          _navigateToBuildingInterface(selectedElement);
                        },
                        onDeletePressed: (selectedElement) {
                          apiService.deleteSite(
                              selectedElement); // Calls the delete function
                          fetchSites();
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
                builder: (context) => PageContent(content: AddSite()),
              ));
        },
        child: Image.asset('assets/Vectoradd.png'),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  void _searchSites(String query) {
    fetchSites();
  }

  Future<void> _deleteSite(Map<String, dynamic> element) async {
    try {
      // Implement your delete functionality here
      // You can use the deleteCircuitBreaker function you provided earlier
      await apiService.deleteSite(element['id']);
      // After successful deletion, you may want to refresh the circuitBreakers list
      fetchSites();
    } catch (e) {
      print("Error deleting circuit breaker: $e");
      // Handle error
    }
  }

  void _navigateToBuildingInterface(Map<String, dynamic> selectedElement) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PageContent(
              content: UpdateSite(
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