import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voltix/config.dart';
import 'package:voltix/screens/MachineScreens/DropBoxElement.dart';
import '../../PageContent.dart';
import '../../shared/Home_Shared/Logo.dart';
import 'MachineInterface.dart';

class AddMachine extends StatefulWidget {
  var element;

  AddMachine({super.key, required this.element});

  @override
  State<AddMachine> createState() => _AddMachineState();
}

class _AddMachineState extends State<AddMachine> {
  String selectedValue = 'fridge';
  late TextEditingController _nameControlleur;
  late TextEditingController _MarqueController;
  @override
  void initState() {
    super.initState();
    _nameControlleur = TextEditingController(text: "");
    _MarqueController = TextEditingController(text: "");
  }

  List<Map<String, dynamic>> jsonArray = [
    {
      "name": "fridge",
      "imageLink": 'assets/page-1/images/fridge-4.png',
    },
    {
      "name": "air condioner",
      "imageLink": 'assets/page-1/images/AirConditioner.png',
    },
    {
      "name": "washing machine",
      "imageLink": 'assets/page-1/images/washing-machine-1.png',
    },
    {
      "name": "television",
      "imageLink": 'assets/page-1/images/television-4.png',
    },
    {
      "name": "other",
      "imageLink": 'assets/page-1/images/other.png',
    },
  ];

  void add(context) async {
    Map<String, dynamic> washingMachineElement = jsonArray.firstWhere(
      (element) => element["name"] == selectedValue,
      orElse: () => jsonArray[0],
    );

    var circuitBreaker = widget.element;

    try {
      final uri = Uri.parse('${AppConfig.apiKey}/machine');
      Map<String, String> headers = {"Content-Type": "application/json"};

      Map data = {
        'name': _nameControlleur.text,
        'consomation': 0,
        'imageLink': washingMachineElement["imageLink"],
        'marque': _MarqueController.text,
        'type': selectedValue,
        'circuitBreaker': circuitBreaker
      };

      var body = json.encode(data);
      final response = await http.post(uri, headers: headers, body: body);

      if ((response.statusCode != 200)) {
        throw Exception('Failed to ADD circuit breaker');
      }
  
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageContent(
                content: MachineInterface(circuitBreaker: widget.element)),
          ));
    } catch (e) {
      print("Error adding circuitbreakers: $e");
      print(e);
    }
  }

  // Initial selected value
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
          Container(
            // frame4204zcP (1:872)
            margin: EdgeInsets.fromLTRB(0 * fem, 0, 14.2 * fem, 0),
            width: 310 * fem,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 50,
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
                        'Add Machine',
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
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 17),
                  child: Container(
                    width: 120, // Set the width as per your requirement
                    height: 120, // Set the height as per your requirement
                    decoration: BoxDecoration(
                      color: Colors
                          .transparent, // Set the background color of the container
                    ),
                    child: Image.asset(
                      'assets/page-1/images/other.png', // Replace this with the path to your photo asset
                      width:
                          80, // Set the width of the image within the container

                      height: 80 *
                          fem, // Set the height of the image within the container
                      fit: BoxFit
                          .contain, // Choose the appropriate fit for the image
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Container(
                    height: 59 * fem,
                    width: 320 * fem,
                    padding: const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                    decoration: BoxDecoration(
                      color: Color(0xffe7e7e7),
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: DropdownButton<String>(
                      value: selectedValue,
                      isExpanded: true,
                      hint: Text("select Device Type"),
                      onChanged: (newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: jsonArray.map((data) {
                        return DropdownMenuItem<String>(
                          value: data['name'],
                          child: CustomDropdownItem(
                              text: data['name'], imagePath: data["imageLink"]),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0.0),
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
                    height: 55,
                    padding: const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
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
                    add(context);
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
                    'Add',
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
    );
  }
}
