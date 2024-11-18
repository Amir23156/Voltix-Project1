import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltix/PageContent.dart';
import 'package:voltix/config.dart';
import 'package:voltix/screens/BuildingsInterfaces/Buildings.dart';
import 'package:voltix/screens/CircuitBreakerInterface/CircuitBreakers.dart';
import 'package:voltix/screens/StatisticsInterfaces/Statistics.dart';
import 'package:voltix/screens/ZonesInterfaces/Zones.dart';
import '../Provider/ListeProvider.dart';
import '../screens/Apps.dart';
import '../screens/Register.dart';
import '../screens/login.dart';
// Import the screen you want to navigate to

import '../main.dart';

import 'package:voltix/screens/Alert/AlertsInterface.dart';
import 'package:voltix/screens/CircuitBreakerInterface/CircuitBreakers.dart';
import 'package:voltix/shared/AlerteNavBar.dart';
import '../Provider/ListeProvider.dart';
import 'package:http/http.dart' as http;

import 'package:voltix/screens/HomeComponent/HomePage.dart';

import '../screens/MachineScreens/DropDown.dart';
import '../screens/More.dart';
import '../screens/SitesInterface/sites.dart';
import '../screens/welcome.dart';

class MenuContainer extends StatefulWidget {
  final Function(Widget) callback;
  var notificationNumber = 0;

  MenuContainer({required this.callback});

  @override
  State<MenuContainer> createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer> {
  fetchDataFromAPI() async {
    final listeProv = Provider.of<ListeProvider>(context, listen: false);

    try {
      final url = '${AppConfig.apiKey}/Alerte/unviewed-count';
      final response = await http.get(Uri.parse(url));
   
      if (response.statusCode == 200) {
        // Traitement des données de la réponse ici
        
        setState(() {
          widget.notificationNumber = int.parse(response.body);
          listeProv.InizializeNotificationNulber(int.parse(response.body));
        });

        // print(machineDataList.length);

        // EditDataFromAPI();
      } else {
        print('Erreur lors de l\'appel API : ${response.statusCode}');
      }
      return (response.body);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    fetchDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    final listeProv = Provider.of<ListeProvider>(context);
    List<Map<String, dynamic>> EmptyListe = [];

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 16, vertical: 15), // Add the desired space here
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ), // Customize the background color as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            HoverMenuItem(
              icon: Icons.home,
              label: 'Home',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageContent(content: HomeScreen()),
                  ),
                );
              },
            ),
            HoverMenuItemAlerte(
                icon: Icons.notifications,
                label: 'Alerts',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PageContent(content: AlertsScreen()),
                    ),
                  );
                
                },
                notificationCount: listeProv.NotifictionNumber),
            HoverMenuItem(
              icon: Icons.business,
              label: 'Data',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageContent(content: SitesScreen()),
                    ));

              },
            ),
            HoverMenuItem(
              icon: Icons.bar_chart,
              label: 'Statistics',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PageContent(content: StatisticsScreen()),
                    ));
              },
            ),
            HoverMenuItem(
              icon: Icons.more_horiz,
              label: 'More',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageContent(content: MoreScreen()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HoverMenuItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const HoverMenuItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  _HoverMenuItemState createState() => _HoverMenuItemState();
}

class _HoverMenuItemState extends State<HoverMenuItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              widget.icon,
              color: isHovered ? Color(0xFF25368A) : Colors.grey,
              size: 30,
            ),
            const SizedBox(height: 4),
            Text(
              widget.label,
              style: TextStyle(
                color: isHovered ? Color(0xFF25368A) : Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
