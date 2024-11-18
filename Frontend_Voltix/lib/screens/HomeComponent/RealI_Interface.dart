import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../Provider/ListeProvider.dart';
import '../../utils.dart';

class Scene extends StatefulWidget {
  double AVGConsomation = 0;
  double mostConsumedZoneConsumption = 0;
  var zone;
  var isLoading = true;

  Scene({Key? key}) : super(key: key);

  @override
  State<Scene> createState() => _SceneState();
}

class _SceneState extends State<Scene> {
  // counter = Provider.of<ListeProvider>(context, listen: false);
  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  fetchDataFromAPI() async {
    try {
      // circuitBreaker;
      final url = 'http://localhost:8080/api/homePage/findData';
      final response = await http.get(Uri.parse(url));
    
      if (response.statusCode == 200) {
        // Traitement des données de la réponse ici

        Map<String, dynamic> result = json.decode(response.body);

        setState(() {
          widget.AVGConsomation = result['averageConsumption'];
          widget.zone = result['mostConsumedZone'];
          widget.mostConsumedZoneConsumption =
              result['mostConsumedZoneConsumption'];
          widget.isLoading = false;
        });

        //counter.InizializeAVGConsomation(double.parse((response.body)));
        
      } else {
        print('Erreur lors de l\'appel API : ${response.statusCode}');
      }
      return (response.body);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    

    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final listeProv = Provider.of<ListeProvider>(context);

    return (widget.isLoading)
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Center(child: CircularProgressIndicator()),
          )
        : Container(
            width: double.infinity,
            child: Container(
              // homepageAoy (124:5)
              padding:
                  EdgeInsets.fromLTRB(20 * fem, 12 * fem, 5 * fem, 19 * fem),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xfff2f2f2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // autogroupn3mhikF (Euoo7DoRTdfncfdM7Xn3Mh)
                    margin: EdgeInsets.fromLTRB(
                        5 * fem, 0 * fem, 20 * fem, 15 * fem),
                    padding: EdgeInsets.fromLTRB(
                        8 * fem, 4 * fem, 131 * fem, 6 * fem),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffdae0ec),
                      borderRadius: BorderRadius.circular(10 * fem),
                    ),
                    child: Row(
                      children: [
                        Container(
                          // autogroupfy3zpHV (EuooH8gaEEt2Do7fyHFY3Z)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 1 * fem, 3 * fem, 0 * fem),
                          width: 47 * fem,
                          height: 43 * fem,
                          child: Image.asset(
                            'assets/page-1/images/auto-group-fy3z.png',
                            width: 47 * fem,
                            height: 43 * fem,
                          ),
                        ),
                        Container(
                          // autogroupghsfwN7 (EuooLiQwRyLNjYmCfgGhSF)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 6 * fem),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // avgusage5DR (124:32)
                                margin: EdgeInsets.fromLTRB(
                                    1 * fem, 0 * fem, 0 * fem, 6 * fem),
                                child: Text(
                                  'Avg usage',
                                  style: SafeGoogleFont(
                                    'Lato',
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.w300,
                                    height: 1.3333333333 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                              Text(
                                // kwhmrw (124:31)
                                widget.AVGConsomation.toString(),
                                style: SafeGoogleFont(
                                  'Lato',
                                  fontSize: 22 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 0.7272727273 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // autogroupdppsXLK (EuooWTdhdfKF9rMsgLdPps)
                    margin: EdgeInsets.fromLTRB(
                        5 * fem, 0 * fem, 20 * fem, 26 * fem),
                    padding: EdgeInsets.fromLTRB(
                        8 * fem, 4 * fem, 170 * fem, 6 * fem),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffdae0ec),
                      borderRadius: BorderRadius.circular(10 * fem),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogroupaw8oQuu (Euoof3DjrvgZGNiymPAW8o)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 1 * fem, 3 * fem, 0 * fem),
                          width: 47 * fem,
                          height: 43 * fem,
                          child: Image.asset(
                            'assets/page-1/images/auto-group-aw8o.png',
                            width: 47 * fem,
                            height: 43 * fem,
                          ),
                        ),
                        Container(
                          // autogroup4sefXzX (EuooiTHiVjuYbJUrch4sEF)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 6 * fem),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // avgcostsoV (124:35)
                                margin: EdgeInsets.fromLTRB(
                                    2 * fem, 0 * fem, 0 * fem, 6 * fem),
                                child: Text(
                                  'Avg Cost',
                                  style: SafeGoogleFont(
                                    'Lato',
                                    fontSize: 12 * ffem,
                                    fontWeight: FontWeight.w300,
                                    height: 1.3333333333 * ffem / fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                              Text(
                                // oBM (124:34)
                                '€ ${(widget.AVGConsomation * 0.500).toString()} ',
                                style: SafeGoogleFont(
                                  'Lato',
                                  fontSize: 22 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 0.7272727273 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // autogroup31zfoqZ (Euop7rnPEgnNKK732b31zf)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 17 * fem, 0 * fem),
                    padding: EdgeInsets.fromLTRB(
                        9 * fem, 11 * fem, 2 * fem, 2 * fem),

                    //height: 146 * fem,
                    //width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffdae0ec),
                      borderRadius: BorderRadius.circular(8 * fem),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // mostconsumedhR9 (124:29)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 19 * fem, 7 * fem),
                          child: Text(
                            'Most consumed',
                            style: SafeGoogleFont(
                              'Montserrat',
                              fontSize: 11 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.2175 * ffem / fem,
                              letterSpacing: 1.1 * fem,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        Container(
                          // autogrouprjfmQKZ (EuopFXEHLuPAuJ53xeRjfm)
                          margin: EdgeInsets.fromLTRB(
                              0, 0 * fem, 10 * fem, 0 * fem),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                // livingroom4LDD (124:64)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 17 * fem, 7 * fem),
                                width: 49 * fem,
                                height: 48 * fem,
                                child: Image.asset(
                                  'assets/living-room.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                // autogroupjgl7EpP (EuopLwEvnjNYU8Wky1jgL7)
                                width: 59 * fem,
                                height: 45 * fem,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      // livingroomLsR (124:65)
                                      left: 7 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 100 * fem,
                                          height: 13 * fem,
                                          child: Text(
                                            widget.zone["zoneName"],
                                            style: SafeGoogleFont(
                                              'Montserrat',
                                              fontSize: 10 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.2175 * ffem / fem,
                                              color: Color(0xff1b1b23),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // flash1Cud (124:66)
                                      left: 0 * fem,
                                      top: 16 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 16 * fem,
                                          height: 23 * fem,
                                          child: Image.asset(
                                            'assets/page-1/images/flash-1.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // devices7Wo (124:68)
                                      left: 23 * fem,
                                      top: 11 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 26 * fem,
                                          height: 34 * fem,
                                          child: Text(
                                            '${widget.mostConsumedZoneConsumption.toString()}KH',
                                            style: SafeGoogleFont(
                                              'Mulish',
                                              fontSize: 10 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 3.4 * ffem / fem,
                                              color: Color(0xff838588),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ), /*
                        Container(
                          // autogroupm9dhQF1 (EuopZmCtVQ7fqi618om9Dh)
                          padding: EdgeInsets.fromLTRB(
                              8 * fem, 11 * fem, 8 * fem, 3 * fem),
                          width: 146 * fem,
                          decoration: BoxDecoration(
                            color: Color(0xffe4b6b0),
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // autogroupfvom7v7 (Euope1aoxoVV6mJ9DZFVoM)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 44 * fem, 0 * fem),
                                width: 86 * fem,
                                height: 53 * fem,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      // alertsr71 (124:28)
                                      left: 0 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 40 * fem,
                                          height: 14 * fem,
                                          child: Text(
                                            'Alerts',
                                            style: SafeGoogleFont(
                                              'Montserrat',
                                              fontSize: 11 * ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.2175 * ffem / fem,
                                              letterSpacing: 1.1 * fem,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      // warning228aK (124:67)
                                      left: 38 * fem,
                                      top: 11 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 48 * fem,
                                          height: 42 * fem,
                                          child: Image.asset(
                                            'assets/page-1/images/warning-2-2.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // alarmsENT (124:69)
                                margin: EdgeInsets.fromLTRB(
                                    3 * fem, 0 * fem, 0 * fem, 0 * fem),
                                child: Text(
                                  '${listeProv.NotifictionNumber} Alerts',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Roboto',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.1725 * ffem / fem,
                                    color: Color(0xff2c406e),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),*/
                ],
              ),
            ),
          );
  }
}
