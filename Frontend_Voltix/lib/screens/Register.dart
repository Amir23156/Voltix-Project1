import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../PageContent.dart';
import 'HomeComponent/HomePage.dart';
import 'login.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/page-1/images/sfm-logo.png', // Replace with your company logo
              width: 150,
              height: 150,
            ),
            SizedBox(height: 10),
            Text(
              'Welcome to Voltix !',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.fromLTRB(20 * fem, 0, 20 * fem, 0),
              child: Container(
                height: 55,
                padding: const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                decoration: BoxDecoration(
                  color: Color(0xffe7e7e7),
                  borderRadius: BorderRadius.circular(11.0),
                ),
                child: TextField(
                  // Your login text field
                  style: GoogleFonts.montserrat(
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.2175 * ffem / fem,
                    color: Color(0xffb8b8b8),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter your username',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.fromLTRB(20 * fem, 0, 20 * fem, 0),
              child: Container(
                height: 55,
                padding: const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                decoration: BoxDecoration(
                  color: Color(0xffe7e7e7),
                  borderRadius: BorderRadius.circular(11.0),
                ),
                child: TextField(
                  // Your password text field
                  style: GoogleFonts.montserrat(
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.2175 * ffem / fem,
                    color: Color(0xffb8b8b8),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.fromLTRB(20 * fem, 0, 20 * fem, 0),
              child: Container(
                height: 55,
                padding: const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                decoration: BoxDecoration(
                  color: Color(0xffe7e7e7),
                  borderRadius: BorderRadius.circular(11.0),
                ),
                child: TextField(
                  // Your password text field
                  style: GoogleFonts.montserrat(
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.2175 * ffem / fem,
                    color: Color(0xffb8b8b8),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.fromLTRB(20 * fem, 0, 20 * fem, 0),
              child: Container(
                height: 55,
                padding: const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                decoration: BoxDecoration(
                  color: Color(0xffe7e7e7),
                  borderRadius: BorderRadius.circular(11.0),
                ),
                child: TextField(
                  // Your password text field
                  style: GoogleFonts.montserrat(
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w400,
                    height: 1.2175 * ffem / fem,
                    color: Color(0xffb8b8b8),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Confirm password',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
                // Add your onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF25368A), // Set the background color
                foregroundColor: Colors.white, // Set the text color
                padding: EdgeInsets.symmetric(
                    horizontal: 70, vertical: 20), // Adjust the padding
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15), // Adjust the radius as needed
                ),
              ),
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black, // Set the color you want
                    ),
                  ),
                  TextSpan(
                    text: "Login",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF25368A), // Set the color you want
                      decoration: TextDecoration.underline,
                    ),
                    // Add your navigation or registration logic here
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PageContent(content: LoginScreen()),
                          ),
                        );
                        // Navigate to the RegisterScreen or perform registration logic
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomRoundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 100); // Create a straight line to the bottom
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 100);
    path.lineTo(
        size.width, 0); // Complete the path by adding the remaining side
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
