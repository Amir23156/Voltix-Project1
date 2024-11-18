import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voltix/PageContent.dart';
import 'package:voltix/config.dart';
import 'package:voltix/screens/MachineScreens/MachineInterface.dart';
import 'package:voltix/screens/MachineScreens/MachinesListe.dart';
import '../../shared/Home_Shared/Logo.dart';
import '../../ComponentDispose.dart';
import 'package:http/http.dart' as http;

import '../SitesInterface/sites.dart';

class EditMachine extends StatefulWidget {
  final element;

  const EditMachine({super.key, required this.element});

  @override
  State<EditMachine> createState() => _EditMachineState();
}

class _EditMachineState extends State<EditMachine> {
  late TextEditingController _nameControlleur;
  late TextEditingController _MarqueController;

  @override
  void initState() {
    super.initState();
    _nameControlleur = TextEditingController(text: widget.element['name']);
    _MarqueController = TextEditingController(text: widget.element['marque']);
  }

  void Edit(context) async {
    final url = '${AppConfig.apiKey}/machine/ ${widget.element["id"]}';
    widget.element["name"] = _nameControlleur.text;
    widget.element["marque"] = _MarqueController.text;
    final headers = {'Content-Type': 'application/json'};
    final body = widget.element;
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageContent(
                content: MachineInterface(
                    circuitBreaker: widget.element["circuitBreaker"])),
          ));
    } else {
      print('Error creating student: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
   
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
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
                                builder: (context) => PageContent(
                                    content: MachineInterface(
                                        circuitBreaker: widget.element)),
                              ));
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
                      'Edit',
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
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.element["name"],
                  style: SafeGoogleFont(
                    'Montserrat',
                    fontSize: 24 * ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.2175 * ffem / fem,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              Container(
                width: 250, // Set the width as per your requirement
                height: 200, // Set the height as per your requirement
                decoration: BoxDecoration(
                  color: Colors
                      .transparent, // Set the background color of the container
                ),
                child: Center(
                  child: Image.asset(
                    widget.element[
                        "imageLink"], // Replace this with the path to your photo asset
                    width:
                        300, // Set the width of the image within the container
                    height:
                        300, // Set the height of the image within the container
                    fit: BoxFit
                        .contain, // Choose the appropriate fit for the image
                  ),
                ),
              ),
              Container(
                // frame4204zcP (1:872)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 14.2 * fem, 20 * fem),
                width: 310 * fem,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Container(
                        height: 59,
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                        decoration: BoxDecoration(
                          color: Color(0xffe7e7e7),
                          borderRadius: BorderRadius.circular(11.0),
                        ),
                        child: TextField(
                          controller: _nameControlleur,
                          onChanged: (value) {
                            print('Text changed: $value');
                          },
                          style: GoogleFonts.montserrat(
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.2175 * ffem / fem,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Enter machine name',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 7, 14.0, 14),
                      child: Container(
                        height: 59,
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                        decoration: BoxDecoration(
                          color: Color(0xffe7e7e7),
                          borderRadius: BorderRadius.circular(11.0),
                        ),
                        child: TextField(
                          controller: _MarqueController,
                          onChanged: (value) {
                            print('Text changed: $value');
                          },
                          style: GoogleFonts.montserrat(
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.2175 * ffem / fem,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Enter une marque',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        Edit(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFF25368A), // Set the background color
                        foregroundColor: Colors.white, // Set the text color
                        padding: EdgeInsets.symmetric(
                            horizontal: 70, vertical: 20), // Adjust the padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15), // Adjust the radius as needed
                        ),
                      ),
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
             
            ],
          ),
        ],
      ),
    );
  }
}
