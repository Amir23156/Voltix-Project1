import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:voltix/Services/AnnuallyService.dart';
import 'package:voltix/models/zone.dart';
import '../../models/Annually.dart';
import 'package:cool_alert/cool_alert.dart';

class AnnuallyCourbe extends StatefulWidget {
  var isLoading = true;
  Zone newZone;
  var fromStatistique;
  var fromCost;

  AnnuallyCourbe.withAttributes({
    required this.fromStatistique,
    required this.fromCost,
    required this.newZone,
  });

  // Constructor for sending only attribute1
  AnnuallyCourbe.withAttribute1({
    required this.fromStatistique,
    required this.fromCost,
  }) : newZone = Zone();
  @override
  State<AnnuallyCourbe> createState() => _AnnuallyCourbeState();
}

class _AnnuallyCourbeState extends State<AnnuallyCourbe> {
  final AnnuallyService _annuallyService = AnnuallyService();
  List<Map<String, dynamic>> annually = [];
  List<double> consumationValues = [];
  List<double> doubleList = [];
  List<dynamic> consumationValue = [];
  Future<void> _fetchAnnually() async {
    List<Map<String, dynamic>> fetchedAnnually = [];
    if (widget.fromStatistique == true)
      fetchedAnnually = await _annuallyService.FindAllAnnuallys();
    else
      fetchedAnnually =
          await _annuallyService.FindAllAnnuallysByzone(widget.newZone);

    setState(() {
      annually = fetchedAnnually;
    });
   
    consumationValue = annually.map((item) => item["consomation"]).toList();
    DateTime startDate = DateTime.parse(annually[0]["date"]);
    int startDay = startDate.month;
    for (int i = 1; i < startDay; i++) {
      doubleList.add(0.0);
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
    _fetchAnnually();
  }

  @override
  Widget build(BuildContext context) {
    return  widget.isLoading
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
                          annually: annually,
                          isCost: widget.fromCost,
                          consumationValue: consumationValues)),
                ],
              ),
            ),
          );
  }
}

class LineChartSample2 extends StatefulWidget {
  final annually;
  List<double> consumationValue;

  var isCost;

  LineChartSample2(
      {required this.annually,
      required this.isCost,
      required this.consumationValue});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

void _showInvalidRangeDialog(BuildContext context, textSend) {
  CoolAlert.show(
    context: context,
    type: CoolAlertType.warning,
    text: textSend,
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
  List<String> moisAbreviations = [
    "jan",
    "fev",
    "mar",
    "avr",
    "mai",
    "jun",
    "jul",
    "aot",
    "sep",
    "oct",
    "nov",
    "dec",
  ];
  String selectedStartTime = "jan";
  String selectedEndTime = "dec";

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
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<String>(
                        value: selectedStartTime,
                        onChanged: (String? newValue) {
                          
                          if (moisAbreviations.indexOf(newValue!) >
                              moisAbreviations.indexOf(selectedEndTime)) {
                            _showInvalidRangeDialog(context, 'Invalid Range');
                            setState(() {
                              selectedStartTime = moisAbreviations.first;
                            });
                          } else if (moisAbreviations.indexOf(newValue!) >
                              widget.consumationValue.length) {
                            _showInvalidRangeDialog(
                                context, "No Data at this time");
                            setState(() {
                              selectedStartTime = moisAbreviations.first;
                            });
                          } else {
                            setState(() {
                              selectedStartTime = newValue!;
                            });
                          }
                          ;
                        },
                        items: moisAbreviations
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
                            if (moisAbreviations.indexOf(selectedStartTime) >
                                moisAbreviations.indexOf(selectedEndTime)) {
                              _showInvalidRangeDialog(context, 'Invalid Range');
                              selectedEndTime = moisAbreviations.last;
                            }
                          });
                         
                        },
                        items: moisAbreviations
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
      fontSize: 8,
    );

    int hourIndex = value.toInt();

    if (hourIndex >= 0 && hourIndex < 12) {
      String hour = moisAbreviations[
          hourIndex]; // Assuming hours is a list of strings in your annually model
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
      String text = '';
      if (widget.isCost)
        text = '${(value.toInt() * 0.5).toString()} DT';
      else
        text = '${value.toInt()}kwh';
      return Text(text, style: style, textAlign: TextAlign.left);
    } else {
      return Container(); // Return an empty container for intervals without titles
    }
  }

  LineChartData mainData() {
   
    List<double> values = widget.consumationValue;
    List<String> hours = moisAbreviations;

    // Get the indices of the selected start and end times
    int startIndex = hours.indexOf(selectedStartTime);
    int endIndex = hours.indexOf(selectedEndTime);
    if (endIndex >= values.length) {
      endIndex = values.length; // Filter the values based on the selected range
     
    }
    // Filter the values based on the selected range
    List<double> filteredValues = values.sublist(startIndex, endIndex);
    
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,

        verticalInterval: 1, // Set the interval for vertical lines
        horizontalInterval: 5,
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
            reservedSize: 43,
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
      maxX: 0 +
          moisAbreviations
              .indexOf(selectedEndTime)
              .toDouble(), // Set the maximum x-coordinate to the end index

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
          isStrokeCapRound: true,
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
            interval: 2,
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
      maxX: 11,
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
