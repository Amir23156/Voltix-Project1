import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltix/PageContent.dart';
import 'package:voltix/Provider/ListeProvider.dart';
import 'package:voltix/screens/BuildingsInterfaces/edit-building.dart';
import 'package:voltix/screens/SitesInterface/sites.dart';
import 'package:voltix/screens/ZonesInterfaces/Zones.dart';
import 'package:voltix/shared/barre_de_recherche.dart';
import '../../shared/menu_container.dart';
import 'add-building.dart';
import '../../models/building.dart';
import '../../Services/BuildingService.dart';
import 'package:cool_alert/cool_alert.dart';

class BuildingsScreen extends StatefulWidget {
  var site;

  BuildingsScreen({super.key, required this.site});

  @override
  _BuildingsScreenState createState() => _BuildingsScreenState();
}

class _BuildingsScreenState extends State<BuildingsScreen> {
  void filterList(
    String searchText,
  ) {
    final listeProvider = Provider.of<ListeProvider>(context, listen: false);

  
    List<Map<String, dynamic>> MachineListe = listeProvider.liste;

    var filtredListe = (MachineListe)
        .where((item) => item["buildingName"]
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
   
    listeProvider.EditFiltredListe(filtredListe);
  }

  final BuildingService _buildingService = BuildingService();
  List<Map<String, dynamic>> buildings = [];
  var counter;

  @override
  void initState() {
    super.initState();

    counter = Provider.of<ListeProvider>(context, listen: false);
    _fetchBuildings();

    counter.InizializeListeWithoutNotifier(buildings, "building");
  }

  Future<void> _showDeleteConfirmation(building) async {
    await CoolAlert.show(
      context: context,
      type: CoolAlertType.warning,
      // title: 'Delete Building',
      text: 'Are you sure you want to delete ${building["buildingName"]}?',
      showCancelBtn: true,
      confirmBtnText: 'Delete',
      onConfirmBtnTap: () async {
        await _buildingService.deleteBuilding(building["id"]);
        _fetchBuildings();
      },
    );
  }

  Future<void> _fetchBuildings() async {
    final List<Map<String, dynamic>> fetchedBuildings =
        await _buildingService.findAllBuildings(widget.site);
    setState(() {
      buildings = fetchedBuildings;
    });
    counter.InizializeListe(buildings, "building");
  }

  Future<void> _showBuildingDetailsDialog(building) async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Building Details',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                SizedBox(height: 20),
                _buildDetailRow('Building Name:', building['buildingName']),
                _buildDetailRow('Main Location:', building['buildingLocation']),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                      },
                      child: Text('Close'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(value),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final listeProv = Provider.of<ListeProvider>(context);
    // List<Map<String, dynamic>> sites = [];

    //listeProv.InizializeListeWithoutNotifier(sites);
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
                              PageContent(content: SitesScreen()),
                        ),
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
                  'BuildingsConfig',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          BarreDeRecherche(filterList: filterList),
          SizedBox(height: 15),
          ((listeProv.PageName == "building")
              ? Column(
                  children: listeProv.filtredListe.map((data) {
                  return (GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PageContent(content: ZonesScreen(building: data)),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 11, 16, 0),
                      child: Container(
                        height: 72,
                        decoration: BoxDecoration(
                          color: Color(0xFFDAE0EC),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          children: [
                            // Location icon
                            Padding(
                              padding: EdgeInsets.only(left: 18),
                              child: SizedBox(
                                width: 45,
                                height: 55,
                                child: Image.asset(
                                  'assets/building.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 22),

                            // Site name and location
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data['buildingName'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(data['buildingLocation']),
                                ],
                              ),
                            ),

                            // Buttons
                            PopupMenuButton<int>(
                              itemBuilder: (BuildContext context) => [
                                PopupMenuItem<int>(
                                  value: 0,
                                  child: Text('Edit'),
                                ),
                                PopupMenuItem<int>(
                                  value: 1,
                                  child: Text('Delete'),
                                ),
                                PopupMenuItem<int>(
                                  value: 2,
                                  child: Text('Details'),
                                ),
                              ],
                              onSelected: (int value) {
                                if (value == 0) {
                                
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PageContent(
                                          content: EditBuilding(
                                              selectedBuilding: data),
                                        ),
                                      ));
                                } else if (value == 1) {
                                  _showDeleteConfirmation(data);
                                } else if (value == 2) {
                                  _showBuildingDetailsDialog(data);
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: 10), // Adjust the padding as needed
                                child: Icon(Icons.more_vert),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
                }).toList())
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
                  PageContent(content: AddBuilding(site: widget.site)),
            ),
          );
        },
        child: Image.asset('assets/Vectoradd.png'),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
