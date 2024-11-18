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

class ZoneCost extends StatefulWidget {
  ZoneCost({super.key, required this.selectedZone});
  final Zone selectedZone;
  var isLoading = true;
  @override
  State<ZoneCost> createState() => _ZoneCost();
}

class _ZoneCost extends State<ZoneCost> {
  List<Map<String, dynamic>> DataListe = [];
  List<FlSpot> pointsListe = [];
  List<Map<String, dynamic>> labelX = [];
  List<Map<String, dynamic>> labelY = [];
  StatisticType selectedStatistic = StatisticType.Daily;

  List<Color> gradientColors = [
    Color(0xFF25368A),
    Color.fromARGB(255, 117, 131, 204)
  ];
  Map<String, dynamic> maxConsomationElement = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
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
                SizedBox(width: 5),
                SelectionButton(
                  buttonText: 'Monthly',
                  isSelected: selectedStatistic == StatisticType.Monthly,
                  onTap: () {
                    setState(() {
                      selectedStatistic = StatisticType.Monthly;
                    });
                  },
                ),
                SizedBox(width: 5),
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
                fromCost: true,
                newZone: widget.selectedZone,
              ),
            if (selectedStatistic == StatisticType.Weekly)
              WeeklyCourbe.withAttributes(
                fromStatistique: false,
                fromCost: true,
                newZone: widget.selectedZone,
              ),
            if (selectedStatistic == StatisticType.Annually)
              AnnuallyCourbe.withAttributes(
                fromStatistique: false,
                fromCost: true,
                newZone: widget.selectedZone,
              ),
            if (selectedStatistic == StatisticType.Monthly)
              MonthlyCourbe.withAttributes(
                fromStatistique: false,
                fromCost: true,
                newZone: widget.selectedZone,
              ),
          ],
        ),
      ),
    );
  }
}
