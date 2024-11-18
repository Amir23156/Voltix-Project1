import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltix/PageContent.dart';
import 'package:voltix/Provider/ListeProvider.dart';
import 'package:voltix/screens/BuildingsInterfaces/Buildings.dart';
import 'package:voltix/screens/CircuitBreakerInterface/CircuitBreakers.dart';
import 'package:voltix/screens/ZonesInterfaces/edit-zone.dart';
import 'package:voltix/shared/barre_de_recherche.dart';
import '../../shared/menu_container.dart';
import 'add-zone.dart';
import '../../models/zone.dart';
import '../../Services/ZoneService.dart';
import 'package:cool_alert/cool_alert.dart';

class ZonesScreen extends StatefulWidget {
  final building;
  ZonesScreen({required this.building});

  @override
  _ZonesScreenState createState() => _ZonesScreenState();
}

class _ZonesScreenState extends State<ZonesScreen> {
  void filterList(String searchText) {
    final listeProvider = Provider.of<ListeProvider>(context, listen: false);

    List<Map<String, dynamic>> MachineListe = listeProvider.liste;

    var filtredListe = (MachineListe)
        .where((item) =>
            item["zoneName"].toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    listeProvider.EditFiltredListe(filtredListe);
  }

  final ZoneService _zoneService = ZoneService();
  List<Map<String, dynamic>> zones = [];
  var counter;
  @override
  void initState() {
    super.initState();
    counter = Provider.of<ListeProvider>(context, listen: false);
    counter.InizializeListeWithoutNotifier(zones, "site");
    _fetchZones(widget.building);
  }

  Future<void> _showDeleteConfirmation(zone, building) async {
    await CoolAlert.show(
      context: context,
      type: CoolAlertType.warning,
      // title: 'Delete Zone',
      text: 'Are you sure you want to delete ${zone['zoneName']}?',
      showCancelBtn: true,
      confirmBtnText: 'Delete',
      onConfirmBtnTap: () async {
        await _zoneService.deleteZone(zone); // Pass the entire zone object
        _fetchZones(building);
      },
    );
  }

  Future<void> _fetchZones(building) async {
    final List<Map<String, dynamic>> fetchedZones =
        await _zoneService.getZonesForBuilding(building);
    setState(() {
      zones = fetchedZones;
    });
    counter.InizializeListe(zones, "zone");

   
  }

  String formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute'; // This will display time in HH:mm format
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final hour = timeOfDay.hour.toString().padLeft(2, '0');
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> _showZoneDetailsDialog(zone) async {
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
                  'Zone Details',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
                SizedBox(height: 20),
                _buildDetailRow('Zone Name:', zone['zoneName']),
                _buildDetailRow('Main Activity:', zone['zoneMainActivity']),
                _buildDetailRow('Zone Surface:', zone['zoneSurface']),
                _buildDetailRow(
                    'Attendance days:', zone['attendanceDays'].join(', ')),
                _buildDetailRow(
                  'Hours of attendance:',
                  '${zone['workStartTime']} until ${zone['workEndTime']}',
                  //'${zone.workStartTime} until ${zone.workEndTime}',
                ),
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
    List<Map<String, dynamic>> sites = [];

    //listeProv.InizializeListeWithoutNotifier(sites, 'zone');
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
                              content: BuildingsScreen(
                                  site: widget.building["site"])),
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
                  'ZonesConfig',
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
          ((listeProv.PageName == "zone")
              ? Column(
                  children: listeProv.filtredListe.map((data) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageContent(
                              content: CircuitBreakersScreen(zone: data)),
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
                                width: 35,
                                height: 46,
                                child: Image.asset(
                                  'assets/living-room.png',
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
                                    data['zoneName'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(data['zoneMainActivity']),
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
                                          content: EditZone(
                                        selectedZone: data,
                                        building: widget.building,
                                      )),
                                    ),
                                  );
                                } else if (value == 1) {
                                  _showDeleteConfirmation(
                                      data, widget.building);
                                } else if (value == 2) {
                                  _showZoneDetailsDialog(data);
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
                  );
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
                  PageContent(content: AddZone(building: widget.building)),
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
