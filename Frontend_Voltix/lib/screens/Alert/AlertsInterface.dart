import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:voltix/PageContent.dart';
import 'package:voltix/screens/Alert/AlerteListe.dart';
import 'package:voltix/screens/Alert/alerte.dart';
import 'package:voltix/screens/HomeComponent/HomePage.dart';
import '../../Provider/ListeProvider.dart';
import './AlerteElement.dart';
import '../../shared/Home_Shared/Logo.dart';
import '../../shared/menu_container.dart';
import './AlerteListe.dart';
import '../../main.dart';
import 'dart:convert';

class AlertsScreen extends StatefulWidget {
  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  List<Map<String, dynamic>> machineDataList = [];
  bool isLoading = true;
  var counter;

  @override
  void initState() {
    super.initState();
    counter = Provider.of<ListeProvider>(context, listen: false);
    counter.InizializeListeWithoutNotifier(machineDataList, "alerte");
    //fetchDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFF2F2F2),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: Logo()),
      body: ListView(
        // Wrap the Column with ListView
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
                      'Alerts',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              AlerteListe(),

              // Add more AlertContainers as needed
            ],
          ),
        ],
      ),
    );
  }
}
