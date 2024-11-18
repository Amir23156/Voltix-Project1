import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voltix/PageContent.dart';
import 'package:voltix/screens/BuildingsInterfaces/Buildings.dart';
import 'package:voltix/Services/BuildingService.dart';
import 'package:cool_alert/cool_alert.dart';

class AddBuilding extends StatefulWidget {
  var site;

  AddBuilding({super.key, required this.site});

  @override
  State<AddBuilding> createState() => _AddBuildingState();
}

class _AddBuildingState extends State<AddBuilding> {
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController buildingLocationController = TextEditingController();

  bool _areFieldsValid() {
    return buildingNameController.text.isNotEmpty &&
        buildingLocationController.text.isNotEmpty;
  }

  //create service class
  BuildingService buildingService = BuildingService();

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
                                  content: BuildingsScreen(site: widget.site)),
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
                      'Add Building',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 350, // Set the width as per your requirement
                height: 250, // Set the height as per your requirement
                decoration: BoxDecoration(
                  color: Colors
                      .transparent, // Set the background color of the container
                ),
                child: Center(
                  child: Image.asset(
                    'assets/addSiteImage.png', // Replace this with the path to your photo asset
                    width:
                        500, // Set the width of the image within the container
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
                    Container(
                      height: 55,
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                      decoration: BoxDecoration(
                        color: Color(0xffe7e7e7),
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: TextField(
                        controller: buildingNameController,
                        style: GoogleFonts.montserrat(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2175 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter building name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 55,
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                      decoration: BoxDecoration(
                        color: Color(0xffe7e7e7),
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: TextField(
                        controller: buildingLocationController,
                        style: GoogleFonts.montserrat(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2175 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter building Location',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  if (_areFieldsValid()) {
                    await buildingService.AddBuilding(
                        buildingNameController.text,
                        buildingLocationController.text,
                        widget.site);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageContent(
                                content: BuildingsScreen(site: widget.site))));
                  } else {
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.error,
                      title: 'Incomplete Fields',
                      text: 'Please fill all required fields.',
                    );
                  }
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
        ],
      ),
    );
  }
}
