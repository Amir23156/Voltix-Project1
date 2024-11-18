import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltix/PageContent.dart';
import 'package:voltix/screens/MachineScreens/MachineInterface.dart';
import '../../Provider/ListeProvider.dart';
import '../../shared/Home_Shared/Logo.dart';
import '../../shared/menu_container.dart';
import '../../main.dart';
import 'dart:convert';

class AlertContainer extends StatefulWidget {
  final Color color;

  var element; // Color parameter for the container

  AlertContainer({Key? key, required this.color, required this.element})
      : super(key: key);

  @override
  State<AlertContainer> createState() => _AlertContainerState();
}

class _AlertContainerState extends State<AlertContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PageContent(
                  content: MachineInterface(
                circuitBreaker: widget.element["cause"],
              )),
            ));
      },
      child: Container(
        width: 300,
        height: 150,
        decoration: BoxDecoration(
          color: widget.color, // Use the passed color
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              right: 10,
              child: Image.asset(
                'assets/page-1/images/warning-2-2.png', // Replace with your actual image asset path
                width: 30,
                height: 30,
              ),
            ),
            Positioned(
              top: 18,
              left: 20,
              child: Container(
                width: 230, // Adjust the width to prevent overflow
                child: Text(
                  widget.element['alerte']['content'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: 70, // Adjust the bottom position as needed
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
              ),
            ),
            Positioned(
                top: 88,
                left: 20,
                child: Container(
                  width: 230, // Adjust the width to prevent overflow
                  child: Text(
                    "Limites :",
                    style: TextStyle(
                      color: Color.fromARGB(255, 209, 205, 205),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            Positioned(
                top: 88,
                left: 90,
                child: Container(
                  width: 230, // Adjust the width to prevent overflow
                  child: Text(
                    widget.element["cause"]['limitConsomation'].toString() +
                        " kwh",
                    style: TextStyle(
                      color: Color.fromARGB(255, 209, 205, 205),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            Positioned(
                top: 108,
                left: 20,
                child: Container(
                  width: 230, // Adjust the width to prevent overflow
                  child: Text(
                    "Real time consomation :",
                    style: TextStyle(
                      color: Color.fromARGB(255, 209, 205, 205),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            Positioned(
                top: 108,
                left: 200,
                child: Container(
                  width: 230, // Adjust the width to prevent overflow
                  child: Text(
                    widget.element["totalConsumption"].toString() + " kwh",
                    style: TextStyle(
                      color: Color.fromARGB(255, 209, 205, 205),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            Visibility(
              visible: !widget.element['alerte']['viewed'], // Show if it's new

              child: Positioned(
                top: 80,
                left: 250,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blue, // Blue background color
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                  width: 38,
                  child: Text(
                    'New', // Text inside the blue box
                    style: TextStyle(
                      color: Colors.white, // White text color
                      fontWeight: FontWeight.bold,
                      fontSize: 9.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
