import 'package:voltix/config.dart';

import '../themes/InitialTheme.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

class ConsomationAndLImites extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;
  bool isLoading = true;
  double TotaleConsomation = 0;
  ConsomationAndLImites({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  State<ConsomationAndLImites> createState() => _ConsomationAndLImitesState();
}

class _ConsomationAndLImitesState extends State<ConsomationAndLImites> {
  fetchDataFromAPI() async {
    try {
      // circuitBreaker;
      final url = '${AppConfig.apiKey}/machine/totalConsumption';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Traitement des données de la réponse ici

        setState(() {
          widget.isLoading = false;
          widget.TotaleConsomation = double.parse((response.body));
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
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
              ],
            ),
          )
        : AnimatedBuilder(
            animation: widget.animationController!,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: widget.animation!,
                child: new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 30 * (1.0 - widget.animation!.value), 0.0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 16, bottom: 18),
                    child: Container(
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(68.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: FitnessAppTheme.grey.withOpacity(0.2),
                              offset: Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 16),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, top: 4),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              height: 48,
                                              width: 2,
                                              decoration: BoxDecoration(
                                                color: HexColor('#87A0E5')
                                                    .withOpacity(0.5),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4, bottom: 2),
                                                    child: Text(
                                                      'Consomation',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            FitnessAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                        letterSpacing: -0.1,
                                                        color: FitnessAppTheme
                                                            .grey
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 28,
                                                        height: 28,
                                                        child: Image.asset(
                                                            "assets/fitness_app/eaten.png"),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4,
                                                                bottom: 3),
                                                        child: Text(
                                                          '${(widget.TotaleConsomation * widget.animation!.value).toInt()}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                FitnessAppTheme
                                                                    .fontName,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16,
                                                            color:
                                                                FitnessAppTheme
                                                                    .darkerText,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4,
                                                                bottom: 3),
                                                        child: Text(
                                                          'KWH',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                FitnessAppTheme
                                                                    .fontName,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12,
                                                            letterSpacing: -0.2,
                                                            color:
                                                                FitnessAppTheme
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.5),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              height: 48,
                                              width: 2,
                                              decoration: BoxDecoration(
                                                color: HexColor('#F56E98')
                                                    .withOpacity(0.5),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4, bottom: 2),
                                                    child: Text(
                                                      'Limite',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            FitnessAppTheme
                                                                .fontName,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                        letterSpacing: -0.1,
                                                        color: FitnessAppTheme
                                                            .grey
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 28,
                                                        height: 28,
                                                        child: Image.asset(
                                                            "assets/fitness_app/burned.png"),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4,
                                                                bottom: 3),
                                                        child: Text(
                                                          '${(10200 * widget.animation!.value).toInt()}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                FitnessAppTheme
                                                                    .fontName,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16,
                                                            color:
                                                                FitnessAppTheme
                                                                    .darkerText,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                bottom: 3),
                                                        child: Text(
                                                          'KWH',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                FitnessAppTheme
                                                                    .fontName,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12,
                                                            letterSpacing: -0.2,
                                                            color:
                                                                FitnessAppTheme
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.5),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Center(
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: FitnessAppTheme.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(100.0),
                                              ),
                                              border: new Border.all(
                                                  width: 4,
                                                  color: FitnessAppTheme
                                                      .nearlyDarkBlue
                                                      .withOpacity(0.2)),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  ' ${(widget.TotaleConsomation * widget.animation!.value).toInt()}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: FitnessAppTheme
                                                        .fontName,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 24,
                                                    letterSpacing: 0.0,
                                                    color: FitnessAppTheme
                                                        .nearlyDarkBlue,
                                                  ),
                                                ),
                                                Text(
                                                  'KWH',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: FitnessAppTheme
                                                        .fontName,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    letterSpacing: 0.0,
                                                    color: FitnessAppTheme.grey
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: CustomPaint(
                                            painter: CurvePainter(
                                                colors: [
                                                  FitnessAppTheme
                                                      .nearlyDarkBlue,
                                                  HexColor("#8A98E8"),
                                                  HexColor("#8A98E8")
                                                ],
                                                angle: 350 +
                                                    (1.0 -
                                                        widget
                                                            .animation!.value)),
                                            child: SizedBox(
                                              width: 108,
                                              height: 108,
                                            ),
                                          ),
                                        ),
                                        Text("ee${widget.animation!.value}"),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}

class CurvePainter extends CustomPainter {
  final double? angle;
  final List<Color>? colors;

  CurvePainter({this.colors, this.angle = 3000});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = [];
    if (colors != null) {
      colorsList = colors ?? [];
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shdowPaint = new Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shdowPaintCenter = new Offset(size.width / 2, size.height / 2);
    final shdowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.3);
    shdowPaint.strokeWidth = 16;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.2);
    shdowPaint.strokeWidth = 20;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    shdowPaint.color = Colors.grey.withOpacity(0.1);
    shdowPaint.strokeWidth = 22;
    canvas.drawArc(
        new Rect.fromCircle(center: shdowPaintCenter, radius: shdowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shdowPaint);

    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = new SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        new Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        paint);

    final gradient1 = new SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = new Paint();
    cPaint..shader = gradient1.createShader(rect);
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle! + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(new Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
