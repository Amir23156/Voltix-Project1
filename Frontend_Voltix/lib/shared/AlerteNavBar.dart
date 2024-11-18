import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltix/PageContent.dart';
import 'package:voltix/screens/Alert/AlertsInterface.dart';
import 'package:voltix/screens/CircuitBreakerInterface/CircuitBreakers.dart';
import '../Provider/ListeProvider.dart';

import '../main.dart';

import 'package:voltix/screens/HomeComponent/HomePage.dart';

import '../screens/MachineScreens/MachineInterface.dart';
import '../screens/MachineScreens/DropDown.dart';

class HoverMenuItemAlerte extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final int notificationCount;

  const HoverMenuItemAlerte({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.notificationCount,
  }) : super(key: key);

  @override
  _HoverMenuItemAlerteState createState() => _HoverMenuItemAlerteState();
}

class _HoverMenuItemAlerteState extends State<HoverMenuItemAlerte> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final listeProv = Provider.of<ListeProvider>(context);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Icon(
                  widget.icon,
                  color: isHovered ? Color(0xFF25368A) : Colors.grey,
                  size: 30,
                ),
                if (listeProv.NotifictionNumber > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          listeProv.NotifictionNumber.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.label,
              style: TextStyle(
                color: isHovered ? Color(0xFF25368A) : Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
