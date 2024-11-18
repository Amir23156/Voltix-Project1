import 'package:flutter/material.dart';
import '../../ComponentDispose.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Column(
      children: [
        Container(
          // roomso6F (124:38)
          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 31 * fem, 12 * fem),
          child: Text(
            'Hello .. !',
            style: SafeGoogleFont(
              'Montserrat',
              fontSize: 24 * ffem,
              fontWeight: FontWeight.w700,
              height: 1.2175 * ffem / fem,
              color: Color(0xff000000),
            ),
          ),
        ),
      ],
    );
  }
}
