import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../Services/DailyService.dart';
import '../../models/Daily.dart';
import '../../models/zone.dart';
import 'package:cool_alert/cool_alert.dart';

class DailyCourbe extends StatefulWidget {
  var isLoading = true;

  Zone newZone;
  var fromStatistique;
  var fromCost;

  DailyCourbe.withAttributes({
    required this.fromStatistique,
    required this.fromCost,
    required this.newZone,
  });

  // Constructor for sending only attribute1
  DailyCourbe.withAttribute1({
    required this.fromStatistique,
    required this.fromCost,
  }) : newZone = Zone();

  @override
  State<DailyCourbe> createState() => _DailyCourbeState();
}

class _DailyCourbeState extends State<DailyCourbe> {
  final DailyService _dailyService = DailyService();

  List<Map<String, dynamic>> daily = [];
  List<dynamic> consumationValue = [];
  List<double> doubleList = [];
  List<double> consumationValues = [];
  List<Map<String, dynamic>> fetchedDaily = [];
  Future<void> _fetchDaily() async {
    if (widget.fromStatistique == true) {
      fetchedDaily = await _dailyService.findAllDailys();
    } else {
      fetchedDaily = await _dailyService.findAllDailysByZone(widget.newZone);
    }

    setState(() {
      daily = fetchedDaily;
    });

    
    consumationValue = daily.map((item) => item["consomation"]).toList();

    if (daily.length != 0) {
      DateTime firstDate = DateTime.parse(daily[0]['date']);
      int firstHour = firstDate.hour;
      for (int i = 0; i < firstHour - 1; i++) {
        doubleList.add(0.0);
      }
    }

    for (var element in consumationValue) {
      if (element is double) {
        doubleList.add(element);
      } else if (element is int) {
        doubleList.add(element.toDouble());
      } else if (element is String) {
        double? parsedDouble = double.tryParse(element);
        if (parsedDouble != null) {
          doubleList.add(parsedDouble);
        }
      }
    }
   
    setState(() {
      consumationValues = doubleList;

      widget.isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchDaily();
  }

  @override
  Widget build(BuildContext context) {
   

    // Fill the consumption list with zeros until the first hour

    return // false

        widget.isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding:
                    EdgeInsets.fromLTRB(0, 0, 0, 0), // Add padding horizontally
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffe7e7e7), // Background color
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Container(
                    padding: EdgeInsets.only(
                      top: 16.0,
                    ),
          /          child: Center(
                      child: Text(
                        'Energy consumption chart', // Your title here
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),*/
                      Container(
                          // height: 280,
                          //  padding: EdgeInsets.only(bottom: 50),
                          decoration: BoxDecoration(
                            color: Color(0xffe7e7e7),
                            borderRadius: BorderRadius.circular(11.0),
                          ),
                          child: LineChartSample2(
                              Loading: widget.isLoading,
                              daily: daily,
                              isCoast: widget.fromCost,
                              consumationValue: consumationValues)),
                    ],
                  ),
                ),
              );
  }
}

class LineChartSample2 extends StatefulWidget {
  final daily;
  List<double> consumationValue;

  var Loading;

  var isCoast;
  LineChartSample2(
      {required this.Loading,
      required this.daily,
      required this.isCoast,
      required this.consumationValue});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

void _showInvalidRangeDialog(BuildContext context, alerteText) {
  CoolAlert.show(
    context: context,
    type: CoolAlertType.warning,
    title: alerteText,
    text: 'Please select a valid time range.',
    confirmBtnText: 'OK',
    confirmBtnColor: Colors.blue,
  );
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    Color(0xFF25368A),
    Color(0xFF25368A),
  ];
  bool showAvg = false;
  List<String> hoursList = [];

  getHoursListe() {
    for (int i = 0; i <= 24; i += 1) {
      String hour = i.toString().padLeft(2, '0') + 'h';
      hoursList.add(hour);
    }

   
  }

  @override
  void initState() {
    super.initState();
    getHoursListe();
  }

  String hourToString(int hour) {
    if (hour < 10) {
      return '0$hour' + 'h';
    } else {
      return '$hour' + 'h';
    }
  }

  String selectedStartTime = "00h";
  String selectedEndTime = "24h";

  @override
  Widget build(BuildContext context) {
    return false
        //widget.Loading
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          )
        : Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.70,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                    left: 10,
                    top: 20,
                    bottom: 0,
                  ),
                  child: LineChart(
                    showAvg ? avgData() : mainData(),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                    right: 10,
                    left: 10,
                    top: 0,
                    bottom: 10,
                  ), // Add the desired top padding
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffd2d2d2),
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Center(
                      // Center the content both horizontally and vertically
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center the content horizontally
                          children: [
                            Text(
                              'Show consumption from  ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DropdownButton<String>(
                              value: selectedStartTime,
                              onChanged: (String? newValue) {
                           
                                if (hoursList.indexOf(newValue!) >
                                    hoursList.indexOf(selectedEndTime)) {
                                  _showInvalidRangeDialog(
                                      context, 'Invalid Range');
                                  setState(() {
                                    selectedStartTime = hoursList.first;
                                  });
                                } else if (hoursList.indexOf(newValue!) >
                                    widget.consumationValue.length) {
                                  _showInvalidRangeDialog(
                                      context, "No Data at this time");
                                  setState(() {
                                    selectedStartTime = hoursList.first;
                                  });
                                } else {
                                  setState(() {
                                    selectedStartTime = newValue!;
                                  });
                                }
                                ;
                              },
                              items: hoursList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            Text(
                              '  to  ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DropdownButton<String>(
                              value: selectedEndTime,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedEndTime = newValue!;
                                  
                                  if (hoursList.indexOf(selectedStartTime) >
                                      hoursList.indexOf(selectedEndTime)) {
                                    _showInvalidRangeDialog(
                                        context, 'Invalid Range');
                                    selectedEndTime = hoursList.last;
                                  }
                                });
                              },
                              items: hoursList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 8,
    );

    int hourIndex = value.toInt();
    if (hourIndex >= 0 && hourIndex < hoursList.length) {
      String hour = hoursList[
          hourIndex]; // Assuming hours is a list of strings in your daily model
      return Text(hour, style: style);
    } else {
      return Container(); // Return an empty container for invalid indices
    }
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );

    // Only show titles for every 20kW interval
    if (value % 10 == 0) {
      String text = "";

      if (widget.isCoast)
        text = '${value.toInt() * 0.5} DT';
      else
        text = '${value.toInt().toString()}kwh';

      return Text(text, style: style, textAlign: TextAlign.left);
    } else {
      return Container(); // Return an empty container for intervals without titles
    }
  }

  LineChartData mainData() {
  
    List<double> values = widget.consumationValue;
    List<String> hours = hoursList;

    // Get the indices of the selected start and end times
    int startIndex = hours.indexOf(selectedStartTime);
    int endIndex = hours.indexOf(selectedEndTime);
   
    if (values.length == 0) {
      startIndex = 0;
      endIndex = 0;
    } else if (endIndex >= values.length)
      endIndex =
          values.length - 1; // Filter the values based on the selected range
    List<double> filteredValues = values.sublist(startIndex, endIndex);

    return LineChartData(
      gridData: FlGridData(
        show: true,
        verticalInterval: 1, // Set the interval for vertical lines
        horizontalInterval: 10,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          if (value % 10 == 0) {
            // Draw a stronger line for every 10 units on the y-axis
            return const FlLine(
              color: Colors.white,
              strokeWidth: 2, // Increase the stroke width for the stronger line
            );
          } else {
            return const FlLine(
              color: Colors.white,
              strokeWidth: 1,
            );
          }
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 2,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      

      minY: 0,
      maxY: 100,
      minX: startIndex
          .toDouble(), // Set the minimum x-coordinate to the start index
      maxX: endIndex.toDouble() +
          hours.indexOf(selectedEndTime) -
          2, // Set the maximum x-coordinate to the end index

      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
            filteredValues.length,
            (index) => FlSpot((index.toDouble() + startIndex.toDouble()) / 2,
                filteredValues[index]),
          ),
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 3,
          isStrokeCapRound: false,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 8,
        horizontalInterval: 8,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 220,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
