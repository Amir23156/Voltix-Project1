import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Services/CircuitBreakerService.dart';
import 'CircuitBreakers.dart';
import '../../PageContent.dart';

class AddCircuitBreaker extends StatefulWidget {
  var zone;

  AddCircuitBreaker({super.key, required this.zone});
  @override
  State<AddCircuitBreaker> createState() => _AddCircuitBreakerState();
}

class _AddCircuitBreakerState extends State<AddCircuitBreaker> {
  late TextEditingController circuitBreakerNameController =
      TextEditingController();
  late TextEditingController circuitBreakerReferenceController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    circuitBreakerNameController = TextEditingController(text: "");
    circuitBreakerReferenceController = TextEditingController(text: "");
  }

  final CircuitBreakerService apiService = CircuitBreakerService();
  void add() async {
    await apiService.addCircuitBreaker(circuitBreakerNameController.text,
        circuitBreakerReferenceController.text, widget.zone);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PageContent(content: CircuitBreakersScreen(zone: widget.zone)),
        ));
    //print("name: ${zoneNameController.text}");
    //print("surface: ${zoneSurfaceController.text}");
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
                              builder: (context) => PageContent(
                                  content:
                                      CircuitBreakersScreen(zone: widget.zone)),
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
                      'Add circuit breaker',
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
                    'assets/page-1/images/breaker-1-5.png',
                    width: 150, // Adjust the width of the image as needed
                    height: 150, // Adjust the height of the image as needed
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 14.2 * fem, 20 * fem),
                width: 310 * fem,
                //height: ,
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
                        controller: circuitBreakerNameController,
                        style: GoogleFonts.montserrat(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2175 * ffem / fem,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter circuit breaker name',
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
                        controller: circuitBreakerReferenceController,
                        style: GoogleFonts.montserrat(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2175 * ffem / fem,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter circuit breaker Reference',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  add();
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
