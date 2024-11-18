import 'package:flutter/material.dart';

import '../PageContent.dart';
import 'login.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: BottomRoundClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/page-1/images/ellipse-3933-bg-pKh.png'), // Replace with your image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Image.asset(
              'assets/page-1/images/sfm-logo.png', // Replace with your company logo
              width: 150,
              height: 150,
            ),
            SizedBox(height: 10),
            Text(
              'We survey your life quality',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
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
                'Get Started',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
