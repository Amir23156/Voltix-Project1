import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voltix/screens/SitesInterface/sites.dart';
import '../../Services/CircuitBreakerService.dart';
import '../../Services/SiteService.dart';
import '../../PageContent.dart';
import './HomeComponent/HomePage.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});
  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  void initState() {
    super.initState();
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PageContent(content: HomeScreen()),
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
                      'Contact us',
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
                    'assets/page-1/images/sfm map.png',
                    //width: 350, // Adjust the width of the image as needed
                    //height: 350, // Adjust the height of the image as needed
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
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                      decoration: BoxDecoration(
                        color: Color(0xffe7e7e7),
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'SFM TECHNOLOGIES',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  10), // Adding some spacing between the text and icon
                          Row(
                            children: [
                              Icon(
                                Icons.phone, // Replace with your desired icon
                                color: Color(
                                    0xFF25368A), // Customize the icon color
                              ),
                              SizedBox(
                                  width:
                                      5), // Adding spacing between the icon and text
                              Text(
                                '(00 216) 71 845 248', // Replace with your desired text
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons
                                    .facebook, // Replace with your desired icon
                                color: Color(
                                    0xFF25368A), // Customize the icon color
                              ),
                              SizedBox(
                                  width:
                                      5), // Adding spacing between the icon and text
                              Text(
                                'sfm technologies', // Replace with your desired text
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.mail, // Replace with your desired icon
                                color: Color(
                                    0xFF25368A), // Customize the icon color
                              ),
                              SizedBox(
                                  width:
                                      5), // Adding spacing between the icon and text
                              Text(
                                'info@sfmtechnologies.com', // Replace with your desired text
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                      decoration: BoxDecoration(
                        color: Color(0xffe7e7e7),
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'SFM CAMEROUN',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  10), // Adding some spacing between the text and icon
                          Row(
                            children: [
                              Icon(
                                Icons.phone, // Replace with your desired icon
                                color: Color(
                                    0xFF25368A), // Customize the icon color
                              ),
                              SizedBox(
                                  width:
                                      5), // Adding spacing between the icon and text
                              Text(
                                '(00 216) 71 845 248', // Replace with your desired text
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons
                                    .facebook, // Replace with your desired icon
                                color: Color(
                                    0xFF25368A), // Customize the icon color
                              ),
                              SizedBox(
                                  width:
                                      5), // Adding spacing between the icon and text
                              Text(
                                'sfm technologies', // Replace with your desired text
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.mail, // Replace with your desired icon
                                color: Color(
                                    0xFF25368A), // Customize the icon color
                              ),
                              SizedBox(
                                  width:
                                      5), // Adding spacing between the icon and text
                              Text(
                                'info@sfmtechnologies.com', // Replace with your desired text
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                      decoration: BoxDecoration(
                        color: Color(0xffe7e7e7),
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'SFM EUROPE',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  10), // Adding some spacing between the text and icon
                          Row(
                            children: [
                              Icon(
                                Icons.phone, // Replace with your desired icon
                                color: Color(
                                    0xFF25368A), // Customize the icon color
                              ),
                              SizedBox(
                                  width:
                                      5), // Adding spacing between the icon and text
                              Text(
                                '(00 216) 71 845 248', // Replace with your desired text
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons
                                    .facebook, // Replace with your desired icon
                                color: Color(
                                    0xFF25368A), // Customize the icon color
                              ),
                              SizedBox(
                                  width:
                                      5), // Adding spacing between the icon and text
                              Text(
                                'sfm technologies', // Replace with your desired text
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.mail, // Replace with your desired icon
                                color: Color(
                                    0xFF25368A), // Customize the icon color
                              ),
                              SizedBox(
                                  width:
                                      5), // Adding spacing between the icon and text
                              Text(
                                'info@sfmtechnologies.com', // Replace with your desired text
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                      decoration: BoxDecoration(
                        color: Color(0xffe7e7e7),
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'SFM BURKINA',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  10), // Adding some spacing between the text and icon
                          Row(
                            children: [
                              Icon(
                                Icons.phone, // Replace with your desired icon
                                color: Color(
                                    0xFF25368A), // Customize the icon color
                              ),
                              SizedBox(
                                  width:
                                      5), // Adding spacing between the icon and text
                              Text(
                                '(00 216) 71 845 248', // Replace with your desired text
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons
                                    .facebook, // Replace with your desired icon
                                color: Color(
                                    0xFF25368A), // Customize the icon color
                              ),
                              SizedBox(
                                  width:
                                      5), // Adding spacing between the icon and text
                              Text(
                                'sfm technologies', // Replace with your desired text
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.mail, // Replace with your desired icon
                                color: Color(
                                    0xFF25368A), // Customize the icon color
                              ),
                              SizedBox(
                                  width:
                                      5), // Adding spacing between the icon and text
                              Text(
                                'info@sfmtechnologies.com', // Replace with your desired text
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                      decoration: BoxDecoration(
                        color: Color(0xffe7e7e7),
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'SFM GUINEE',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  10), // Adding some spacing between the text and icon
                          Row(
                            children: [
                              Icon(
                                Icons.phone, // Replace with your desired icon
                                color: Color(
                                    0xFF25368A), // Customize the icon color
                              ),
                              SizedBox(
                                  width:
                                      5), // Adding spacing between the icon and text
                              Text(
                                '(00 216) 71 845 248', // Replace with your desired text
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons
                                    .facebook, // Replace with your desired icon
                                color: Color(
                                    0xFF25368A), // Customize the icon color
                              ),
                              SizedBox(
                                  width:
                                      5), // Adding spacing between the icon and text
                              Text(
                                'sfm technologies', // Replace with your desired text
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.mail, // Replace with your desired icon
                                color: Color(
                                    0xFF25368A), // Customize the icon color
                              ),
                              SizedBox(
                                  width:
                                      5), // Adding spacing between the icon and text
                              Text(
                                'info@sfmtechnologies.com', // Replace with your desired text
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
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
