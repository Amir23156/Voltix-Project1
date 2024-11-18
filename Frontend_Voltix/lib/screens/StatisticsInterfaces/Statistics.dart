import 'dart:async';
import 'package:flutter/material.dart';
import 'package:voltix/Services/EnergyStatService.dart';
import 'package:voltix/main.dart';
import 'package:voltix/models/Monthly.dart';
import 'package:voltix/models/Weekly.dart';
import 'package:voltix/screens/StatisticsInterfaces/DailyCourbe.dart';
import 'package:voltix/screens/StatisticsInterfaces/MonthlyCourbe.dart';
import 'package:voltix/screens/StatisticsInterfaces/ZoneStatstique.dart';
import '../../Services/AnnuallyService.dart';
import '../../Services/DailyService.dart';
import '../../Services/MonthlyService.dart';
import '../../Services/WeeklyService.dart';
import '../../models/Annually.dart';
import '../../models/Daily.dart';
import '../../models/zone.dart';
import '../../models/EnergyStat.dart';
import '../../Services/ZoneService.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:voltix/PageContent.dart';

import 'AnnuallyCourbe.dart';
import 'WeeklyCourbe.dart';

class StatisticsScreen extends StatefulWidget {
  var isLoading = true;

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

enum StatisticType {
  Daily,
  Weekly,
  Monthly,
  Annually,
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final ZoneService _zoneService = ZoneService();

  final EnergyStatService _energyStatService = EnergyStatService();
  List<Zone> zones = [];
  List<Map<String, dynamic>> dailyList = [];
  List<Map<String, dynamic>> monthlyList = [];
  List<EnergyStats> stats = [];
  EnergyStats? selectedStats; // Initialize as null
  double averageDailyConsumption = 0.0;
  double averageMonthlyConsumption = 0.0;
  double averageAnnualConsumption = 0.0;
  StatisticType selectedStatistic = StatisticType.Daily;

  @override
  void initState() {
    super.initState();
    initFunction();
  }

  initFunction() async {
    await _fetchStatsForZone();
    await fetchZones();
    setState(() {
      widget.isLoading = false;
    });
  }

  fetchZones() async {
    final List<Zone> fetchedZones = await _zoneService.findAllZones();

    setState(() {
      zones = fetchedZones;
    });
  }

  double calculateAverage(
      List<EnergyStats> stats, double Function(EnergyStats) valueExtractor) {
    if (stats.isEmpty) return 0.0;
    double sum = 0.0;
    for (final stat in stats) {
      sum += valueExtractor(stat);
    }
    return sum / stats.length;
  }

  Future<void> _fetchStatsForZone() async {
    final List<EnergyStats> fetchedStats =
        await _energyStatService.FindAllEnergyStats();

   
   
    setState(() {
      stats = fetchedStats;
      selectedStats = fetchedStats.isNotEmpty ? fetchedStats[0] : null;
      // Calculate the averages
      averageDailyConsumption =
          calculateAverage(fetchedStats, (stat) => stat.dailyConsumption);
      averageMonthlyConsumption =
          calculateAverage(fetchedStats, (stat) => stat.monthlyConsumption);
      averageAnnualConsumption =
          calculateAverage(fetchedStats, (stat) => stat.annualConsumption);
    });
  
  }

  Future<void> _showZoneDetailsDialog(Zone zone) async {
    EnergyStats? zoneStats = stats.firstWhere(
      (stat) => stat.zoneId == zone.id,
      // orElse: () => null,
    );

    if (zoneStats == null) {
      print("error");
      return;
    }

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
                  '${zoneStats.zoneName} consumption',
                  style: TextStyle(fontSize: 20, color: Color(0xFF25368A)),
                ),
                SizedBox(height: 20),
                _buildDetailRow('Daily consumption:',
                    zoneStats.dailyConsumption.toString()),
                _buildDetailRow('Monthly consumption:',
                    zoneStats.monthlyConsumption.toString()),
                _buildDetailRow('Annual consumption:',
                    zoneStats.annualConsumption.toString()),
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
    

    return widget.isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
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
                                builder: (context) => MyApp(),
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
                        'Statistics',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                /*  EnergyStatsChart(
            dailyConsumption: stats[0].dailyConsumption,
            monthlyConsumption: stats[0].monthlyConsumption,
            annualConsumption: stats[0].annualConsumption,
          ),*/
                //  SizedBox(height: 150),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
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
                              isSelected:
                                  selectedStatistic == StatisticType.Daily,
                              onTap: () {
                                setState(() {
                                  selectedStatistic = StatisticType.Daily;
                                });
                              },
                            ),
                            SelectionButton(
                              buttonText: 'Weekly',
                              isSelected:
                                  selectedStatistic == StatisticType.Weekly,
                              onTap: () {
                                setState(() {
                                  selectedStatistic = StatisticType.Weekly;
                                });
                              },
                            ),
                            SizedBox(width: 2),
                            SelectionButton(
                              buttonText: 'Monthly',
                              isSelected:
                                  selectedStatistic == StatisticType.Monthly,
                              onTap: () {
                                setState(() {
                                  selectedStatistic = StatisticType.Monthly;
                                });
                              },
                            ),
                            SizedBox(width: 2),
                            SelectionButton(
                              buttonText: 'Annually',
                              isSelected:
                                  selectedStatistic == StatisticType.Annually,
                              onTap: () {
                                setState(() {
                                  selectedStatistic = StatisticType.Annually;
                                });
                              },
                            ),
                          ],
                        ),
                        if (selectedStatistic == StatisticType.Daily)
                          DailyCourbe.withAttribute1(
                            fromStatistique: true,
                            fromCost: false,
                          ),
                        if (selectedStatistic == StatisticType.Weekly)
                          WeeklyCourbe.withAttribute1(
                            fromStatistique: true,
                            fromCost: false,
                          ),
                        if (selectedStatistic == StatisticType.Annually)
                          AnnuallyCourbe.withAttribute1(
                            fromStatistique: true,
                            fromCost: false,
                          ),
                        if (selectedStatistic == StatisticType.Monthly)
                          MonthlyCourbe.withAttribute1(
                            fromStatistique: true,
                            fromCost: false,
                          ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(
                      8, 10, 8, 16), // Add padding horizontally
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                    decoration: BoxDecoration(
                      color: Color(0xffe7e7e7),
                      borderRadius: BorderRadius.circular(11.0),
                    ), // Add padding to the whole container
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'My zones ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        for (int i = 0; i < zones.length; i++)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PageContent(
                                    content: courbe(selectedZone: zones[i]),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: i == 0 ? 0 : 11),
                              decoration: BoxDecoration(
                                color: Color(0xffd2d2d2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                children: [
                                  // Location icon
                                  SizedBox(width: 10),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Image.asset(
                                        'assets/energyIcon.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  // Site name and location
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          zones[i].zoneName ?? "",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(zones[i].zoneMainActivity ??
                                            "null"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          10), // Add space before consumption text
                                  /*  Text(
                               '${stats[i].dailyConsumption} kWh',
                            //  '10000 kWh',// Replace 'consumption' with the actual field name
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),*/
                                  GestureDetector(
                                    onTap: () {
                                      _showZoneDetailsDialog(zones[i]);
                                    },
                                    child: Text(
                                      'Show consumption',
                                      style: TextStyle(
                                        color: Color(0xFFFF6139),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 15),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 105),
              ],
            ),
          );
  }
}

class SelectionButton extends StatefulWidget {
  final String buttonText;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectionButton({
    required this.buttonText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: widget.isSelected ? Color(0xFF25368A) : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          widget.buttonText,
          style: TextStyle(
            color: widget.isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
