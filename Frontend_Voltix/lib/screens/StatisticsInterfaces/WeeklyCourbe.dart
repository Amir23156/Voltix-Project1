import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:voltix/Services/WeeklyService.dart';
import 'package:voltix/models/zone.dart';
import '../../models/Weekly.dart';
import 'package:cool_alert/cool_alert.dart';

class WeeklyCourbe extends StatefulWidget {
  Zone newZone;
  var fromStatistique;
  var fromCost;

  WeeklyCourbe.withAttributes({
    required this.fromStatistique,
    required this.fromCost,
    required this.newZone,
  });

  // Constructor for sending only attribute1
  WeeklyCourbe.withAttribute1({
    required this.fromStatistique,
    required this.fromCost,
  }) : newZone = Zone();
  // Pass the WeeklyModel instance to the widget
  var isLoading = true;
  @override
  State<WeeklyCourbe> createState() => _WeeklyCourbeState();
}

class _WeeklyCourbeState extends State<WeeklyCourbe> {
  final WeeklyService _weeklyService = WeeklyService();
  List<Map<String, dynamic>> weekly = [];
  List<double> doubleList = [];
  List<dynamic> consumationValue = [];
  List<double> consumationValues = [];
  Future<void> _fetchWeekly() async {
    List<Map<String, dynamic>> fetchedWeekly = [];
    if (widget.fromStatistique == true) {
      fetchedWeekly = await _weeklyService.FindAllWeeklys();
    } else {
      fetchedWeekly =
          await _weeklyService.FindAllWeeklysforZone(widget.newZone);
    }

    setState(() {
      weekly = fetchedWeekly;
    });
    consumationValue = weekly.map((item) => item["consomation"]).toList();
    
    if (weekly.length != 0) {
      DateTime firstDate = DateTime.parse(weekly[0]['date']);
      int firstDay = firstDate.weekday;
    

      // Fill the consumption list with zeros until the first hour
      for (int i = 1; i < firstDay - 1; i++) {
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
    consumationValues = doubleList;

    setState(() {
      widget.isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchWeekly();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(child: CircularProgressIndicator()),
          )
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
                    child: Center(
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
                          isCost: widget.fromCost,
                          weekly: weekly,
                          consumationValue: consumationValues)),
                ],
              ),
            ),
          );
  }
}

class LineChartSample2 extends StatefulWidget {
  final weekly;
  List<double> consumationValue;

  var isCost;
  LineChartSample2(
      {required this.isCost,
      required this.weekly,
      required this.consumationValue});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

void _showInvalidRangeDialog(BuildContext context, textShow) {
  CoolAlert.show(
    context: context,
    type: CoolAlertType.warning,
    text: textShow,
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
  List<String> timeArray = ["lun", "mar", "mer", "jeu", "ven", "sam", "dim"];

  String selectedStartTime = "lun";
  String selectedEndTime = "dim";

  @override
  Widget build(BuildContext context) {
   
    return Column(
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
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        value: selectedStartTime,
                        onChanged: (String? newValue) {
                          
                          if (timeArray.indexOf(newValue!) >
                              timeArray.indexOf(selectedEndTime)) {
                            _showInvalidRangeDialog(context, 'Invalid Range');
                            setState(() {
                              selectedStartTime = timeArray.first;
                            });
                          } else if (timeArray.indexOf(newValue!) >
                              widget.consumationValue.length) {
                            _showInvalidRangeDialog(
                                context, "No Data at this time");
                            setState(() {
                              selectedStartTime = timeArray.first;
                            });
                          } else {
                            setState(() {
                              selectedStartTime = newValue!;
                            });
                          }
                          ;
                        },
                        items: timeArray
                            .map<DropdownMenuItem<String>>((String value) {
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
                           
                            if (timeArray.indexOf(selectedStartTime) >
                                timeArray.indexOf(selectedEndTime)) {
                              _showInvalidRangeDialog(context, 'Invalid Range');
                              selectedEndTime = timeArray.last;
                            }
                          });
                        },
                        items: timeArray
                            .map<DropdownMenuItem<String>>((String value) {
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
      fontSize: 10,
    );

    int hourIndex = value.toInt();
    

    if (hourIndex >= 0 && hourIndex < timeArray.length) {
      String hour = timeArray[hourIndex];
       // Assuming hours is a list of strings in your weekly model
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
      if (widget.isCost)
        text = '${(value.toInt() * 0.5).toString()} DT';
      else
        text = '${(value.toInt()).toString()}kwh';
      return Text(text, style: style, textAlign: TextAlign.left);
    } else {
      return Container(); // Return an empty container for intervals without titles
    }
  }

  LineChartData mainData() {
    
    List<double> values = widget.consumationValue;
    List<String> hours = timeArray;
    
    // Get the indices of the selected start and end times
    int startIndex = hours.indexOf(selectedStartTime);
    int endIndex = hours.indexOf(selectedEndTime);
    

    if (endIndex >= values.length) endIndex = values.length;

    // Filter the values based on the selected range
    List<double> filteredValues = values.sublist(startIndex, endIndex);
   
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        verticalInterval: 1, // Set the interval for vertical lines
        horizontalInterval: 10,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white,
            strokeWidth: 2,
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
            interval: 1,
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
      //  minX: 0,
      //  maxX: 11,
      minY: 0,
      maxY: 100,
      minX: startIndex
          .toDouble(), // Set the minimum x-coordinate to the start index
      maxX: endIndex.toDouble() +
          (hours.indexOf(selectedEndTime) -
              1), // Set the maximum x-coordinate to the end index

      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
            filteredValues.length,
            (index) => FlSpot((index.toDouble() + startIndex.toDouble()),
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
        verticalInterval: 1,
        horizontalInterval: 1,
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
            reservedSize: 30,
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
      maxX: 13,
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
