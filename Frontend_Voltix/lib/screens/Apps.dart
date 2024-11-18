import 'package:flutter/material.dart';

import '../PageContent.dart';
import 'HomeComponent/HomePage.dart';
import 'login.dart';

class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
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
            GestureDetector(
              onTap: () {
                // Add your onTap logic here
                // For example, you can navigate to another screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Image.asset(
                'assets/page-1/images/androidlarge-1autox2-removebg-preview1-1-FPD.png', // Replace with your company logo
                width: 150,
                height: 150,
              ),
            ),
            Image.asset(
              'assets/page-1/images/androidlarge-1autox2-removebg-preview2-1.png', // Replace with your company logo
              width: 150,
              height: 150,
            ),
            SizedBox(height: 5),
            Image.asset(
              'assets/page-1/images/androidlarge-1autox2-removebg-preview-3-1-7HR.png', // Replace with your company logo
              width: 150,
              height: 150,
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
