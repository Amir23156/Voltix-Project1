import 'dart:io';
import './app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'screens/HomeComponent/HomePage.dart';
import 'shared/menu_container.dart';

class PageContent extends StatefulWidget {
  final Widget content;

  const PageContent({super.key, required this.content});

  @override
  State<PageContent> createState() => _PageContent();
}

class _PageContent extends State<PageContent> {
  Widget Screen = HomeScreen();

  @override
  void initState() {
    super.initState();
    Screen = HomeScreen();
  }

  void updateDataFromChild(Widget newWidget) {
    setState(() {
      Screen = newWidget;
    });
  }

  @override
  Widget build(BuildContext context) {
    //  final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Flutter UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: AppTheme.textTheme,
      ),
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: widget.content,
            ),
            /* StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // Handle the incoming data (notifications) here
                  // return Text('Received: ${snapshot.data}');
                }
                return null;
                //Text('Connecting...');
              },
            ),*/
          ],
        ),
        bottomNavigationBar: MenuContainer(callback: updateDataFromChild),
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
