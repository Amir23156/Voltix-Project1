import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart'; // Import this package

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:voltix/PageContent.dart';
import 'package:voltix/models/zone.dart';
import 'package:voltix/screens/StatisticsInterfaces/AnnuallyCourbe.dart';
import 'package:voltix/screens/StatisticsInterfaces/DailyCourbe.dart';
import 'package:voltix/screens/StatisticsInterfaces/MonthlyCourbe.dart';
import 'package:voltix/screens/StatisticsInterfaces/WeeklyCourbe.dart';
import '../../screens/StatisticsInterfaces/Statistics.dart';
import 'package:http/http.dart' as http;

class LineChartSample2 extends StatefulWidget {
  LineChartSample2({super.key, required this.selectedZone});
  final Zone selectedZone;
  var isLoading = true;
  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Map<String, dynamic>> DataListe = [];
  List<FlSpot> pointsListe = [];
  List<Map<String, dynamic>> labelX = [];
  List<Map<String, dynamic>> labelY = [];

  List<Color> gradientColors = [
    Color(0xFF25368A),
    Color.fromARGB(255, 121, 136, 211)
  ];
  Map<String, dynamic> maxConsomationElement = {};

  StatisticType selectedStatistic = StatisticType.Daily;

  @override
  void initState() {
    super.initState();
  }

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 16, 16, 1),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xffe7e7e7),
          borderRadius: BorderRadius.circular(11.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectionButton(
                  buttonText: 'Daily',
                  isSelected: selectedStatistic == StatisticType.Daily,
                  onTap: () {
                    setState(() {
                      selectedStatistic = StatisticType.Daily;
                    });
                  },
                ),
                SelectionButton(
                  buttonText: 'Weekly',
                  isSelected: selectedStatistic == StatisticType.Weekly,
                  onTap: () {
                    setState(() {
                      selectedStatistic = StatisticType.Weekly;
                    });
                  },
                ),
                SizedBox(width: 2),
                SelectionButton(
                  buttonText: 'Monthly',
                  isSelected: selectedStatistic == StatisticType.Monthly,
                  onTap: () {
                    setState(() {
                      selectedStatistic = StatisticType.Monthly;
                    });
                  },
                ),
                SizedBox(width: 2),
                SelectionButton(
                  buttonText: 'Annually',
                  isSelected: selectedStatistic == StatisticType.Annually,
                  onTap: () {
                    setState(() {
                      selectedStatistic = StatisticType.Annually;
                    });
                  },
                ),
              ],
            ),
            if (selectedStatistic == StatisticType.Daily)
              DailyCourbe.withAttributes(
                fromStatistique: false,
                fromCost: false,
                newZone: widget.selectedZone,
              ),
            if (selectedStatistic == StatisticType.Weekly)
              WeeklyCourbe.withAttributes(
                fromStatistique: false,
                fromCost: false,
                newZone: widget.selectedZone,
              ),
            if (selectedStatistic == StatisticType.Annually)
              AnnuallyCourbe.withAttributes(
                fromStatistique: false,
                fromCost: false,
                newZone: widget.selectedZone,
              ),
            if (selectedStatistic == StatisticType.Monthly)
              MonthlyCourbe.withAttributes(
                fromStatistique: false,
                fromCost: false,
                newZone: widget.selectedZone,
              ),
          ],
        ),
      ),
    );
  }
}
