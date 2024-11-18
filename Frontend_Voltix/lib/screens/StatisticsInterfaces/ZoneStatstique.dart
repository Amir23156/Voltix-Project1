import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:voltix/PageContent.dart';
import 'package:voltix/models/zone.dart';
import 'package:voltix/screens/StatisticsInterfaces/zoneCoste.dart';
import 'package:voltix/screens/StatisticsInterfaces/zoneCourbe.dart';
import '../../screens/StatisticsInterfaces/Statistics.dart';
import 'package:http/http.dart' as http;

class courbe extends StatefulWidget {
  final Zone selectedZone;
  var isLoading = true;
  courbe({required this.selectedZone});

  @override
  State<courbe> createState() => _courbeState();
}

class _courbeState extends State<courbe> {
  List<Map<String, dynamic>> DataListe = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                            content: StatisticsScreen(),
                          ),
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
                  widget.selectedZone.zoneName ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(10, 16, 10, 0), // Add padding horizontally
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffe7e7e7), // Background color
                borderRadius: BorderRadius.circular(11.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 16.0,
                    ),
                    child: Center(
                      child: Text(
                        'Energy consumption chart', // Your title here
                        style: TextStyle(
                          color: Color(0xFF25368A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  LineChartSample2(selectedZone: widget.selectedZone),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.fromLTRB(10, 16, 10, 0), // Add padding horizontally
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffe7e7e7), // Background color
                borderRadius: BorderRadius.circular(11.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 16.0,
                    ),
                    child: Center(
                      child: Text(
                        'Energy Cost chart', // Your title here
                        style: TextStyle(
                          color: Color(0xFF25368A),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ZoneCost(selectedZone: widget.selectedZone),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
