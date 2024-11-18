import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voltix/models/circuitbreaker.dart';
import 'package:voltix/screens/SitesInterface/sites.dart';
import '../../Services/CircuitBreakerService.dart';
import '../../Services/SiteService.dart';

import '../../PageContent.dart';
import '../../models/site.dart';

class UpdateSite extends StatefulWidget {
  final Map<String, dynamic> selectedElement;

  UpdateSite({Key? key, required this.selectedElement}) : super(key: key);

  @override
  State<UpdateSite> createState() => _UpdateSiteState();
}

class _UpdateSiteState extends State<UpdateSite> {
  late TextEditingController siteNameController;
  late TextEditingController siteLocationController;

  final SiteService apiService = SiteService();

  @override
  void initState() {
    super.initState();
    siteNameController =
        TextEditingController(text: widget.selectedElement["siteName"]);
    siteLocationController =
        TextEditingController(text: widget.selectedElement["siteLocation"]);
  }

  @override
  void dispose() {
    siteNameController.dispose();
    siteLocationController.dispose();
    super.dispose();
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
                          //Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PageContent(content: SitesScreen()),
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
                      'Update site',
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
                width: 350,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/page-1/images/location-1-1.png',
                    width: 100, // Adjust the width of the image as needed
                    height: 100, // Adjust the height of the image as needed
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
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
                        controller: siteNameController,
                        style: GoogleFonts.montserrat(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2175 * ffem / fem,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter new site name',
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
                        controller: siteLocationController,
                        style: GoogleFonts.montserrat(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2175 * ffem / fem,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter new site Location',
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
                  try {
                    Site updatedSite = Site(
                        siteName: siteNameController.text,
                        siteLocation: siteLocationController.text);
                    print(
                        'Updating circuit breaker fel update page with location: ${updatedSite.siteLocation}');
                    await apiService.updateSite(
                        widget.selectedElement['id'], updatedSite);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PageContent(content: SitesScreen()),
                        ));
                  } catch (e) {
                    print("Error updating site: $e");
                    // Handle error
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
                  'Update',
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
