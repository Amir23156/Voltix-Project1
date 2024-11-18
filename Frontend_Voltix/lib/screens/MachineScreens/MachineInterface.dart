import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltix/PageContent.dart';
import 'package:voltix/Provider/ListeProvider.dart';
import 'package:voltix/screens/CircuitBreakerInterface/CircuitBreakers.dart';
import 'package:voltix/screens/MachineScreens/add-Machine.dart';
import 'package:voltix/screens/ZonesInterfaces/Zones.dart';
import '../../shared/Home_Shared/Logo.dart';
import '../../shared/barre_de_recherche.dart';
import '../../shared/menu_container.dart';
import '../CircuitBreakerInterface/add-circuit-breaker.dart';
import 'MachinesListe.dart';

class MachineInterface extends StatefulWidget {
  var circuitBreaker;

  MachineInterface({super.key, required this.circuitBreaker});

  @override
  State<MachineInterface> createState() => _MachineInterfaceState();
}

class _MachineInterfaceState extends State<MachineInterface> {
  void filterList(String searchText) {
    final listeProvider = Provider.of<ListeProvider>(context, listen: false);

    
    List<Map<String, dynamic>> MachineListe = listeProvider.liste;

    var filtredListe = (MachineListe)
        .where((item) =>
            item["name"].toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    listeProvider.EditFiltredListe(filtredListe);
  }

  @override
  Widget build(BuildContext context) {
    final listeProv = Provider.of<ListeProvider>(context);
    List<Map<String, dynamic>> sites = [];

    // listeProv.InizializeListeWithoutNotifier(sites, "machine");
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFF2F2F2),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: Logo()),
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              Container(
                height: 50,
                color: Color(0xFFF2F2F2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PageContent(
                                    content: CircuitBreakersScreen(
                                        zone: widget.circuitBreaker['zone']))),
                          );
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
                      'Machines of ' +
                          widget.circuitBreaker["circuitBreakerName"],
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
              MachineListe(circuitBreaker: widget.circuitBreaker),
              SizedBox(height: 16),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PageContent(
                    content: AddMachine(element: widget.circuitBreaker))),
          );
          // Navigate to the "Add Site" page when the add icon is pressed
        },
        child: Image.asset('assets/Vectoradd.png'),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
