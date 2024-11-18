import 'dart:developer';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voltix/PageContent.dart';
import 'package:voltix/Services/ZoneService.dart';
import 'package:voltix/screens/ZonesInterfaces/Zones.dart';

class AddZone extends StatefulWidget {
  //const AddZone({super.key});
  final building;

  AddZone({required this.building});
  @override
  State<AddZone> createState() => _AddZoneState();
}

class _AddZoneState extends State<AddZone> {
  TextEditingController zoneNameController = TextEditingController();
  TextEditingController zoneSurfaceController = TextEditingController();
  TextEditingController zoneMainActivityController = TextEditingController();
  List<String> attendanceDays = [];
  String? workStartTime;
  String? workEndTime;

  bool _areFieldsValid() {
    return zoneNameController.text.isNotEmpty &&
        zoneMainActivityController.text.isNotEmpty &&
        zoneSurfaceController.text.isNotEmpty &&
        attendanceDays.isNotEmpty &&
        workStartTime != null &&
        workEndTime != null;
  }

  //create service class
  ZoneService zoneService = ZoneService();

  String formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute'; // This will display time in HH:mm format
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
        // Wrap the Column with ListView
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
                                  content: ZonesScreen(
                                building: widget.building,
                              )),
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
                      'Add Zone',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                // frame4204zcP (1:872)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 14.2 * fem, 20 * fem),
                width: 310 * fem,
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
                        controller: zoneNameController,
                        style: GoogleFonts.montserrat(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2175 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter zone name',
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
                        controller: zoneMainActivityController,
                        style: GoogleFonts.montserrat(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2175 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter main activity',
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
                        controller: zoneSurfaceController,
                        style: GoogleFonts.montserrat(
                          fontSize: 16 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.2175 * ffem / fem,
                          color: Color(0xff000000),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter zone surface',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Attendance days',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 14.0),
                        decoration: BoxDecoration(
                          color: Color(0xffe7e7e7),
                          borderRadius: BorderRadius.circular(11.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SelectionButton(
                                      buttonText: 'Monday',
                                      attendanceDays: attendanceDays),
                                  SizedBox(width: 5),
                                  SelectionButton(
                                      buttonText: 'Tuesday',
                                      attendanceDays: attendanceDays),
                                  SizedBox(width: 5),
                                  SelectionButton(
                                      buttonText: 'Wednesday',
                                      attendanceDays: attendanceDays),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SelectionButton(
                                      buttonText: 'Thursday',
                                      attendanceDays: attendanceDays),
                                  SizedBox(width: 10),
                                  SelectionButton(
                                      buttonText: 'Friday',
                                      attendanceDays: attendanceDays),
                                  SizedBox(width: 10),
                                  SelectionButton(
                                      buttonText: 'Saturday',
                                      attendanceDays: attendanceDays),
                                ],
                              ),
                            ),
                          ],
                        )),
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Hours of attendance',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SelectionTime(
                            onTimeSelected: (time) {
                              setState(() {
                                workStartTime = formatTime(time);
                              });
                            },
                          ),
                          Text(
                            "until",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          SelectionTime(
                            onTimeSelected: (time) {
                              setState(() {
                                workEndTime = formatTime(time);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () async {
                        if (_areFieldsValid()) {
                          await zoneService.AddZone(
                            widget.building, // Pass the selected buildingId

                            zoneNameController.text,
                            zoneSurfaceController.text,
                            zoneMainActivityController.text,
                            attendanceDays,
                            workStartTime,

                            workEndTime,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageContent(
                                  content:
                                      ZonesScreen(building: widget.building)),
                            ),
                          );
                        } else {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            title: 'Incomplete Fields',
                            text: 'Please fill all required fields.',
                          );
                        }
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SelectionButton extends StatefulWidget {
  final String buttonText;
  final List<String> attendanceDays;

  SelectionButton({
    required this.buttonText,
    required this.attendanceDays,
  });

  @override
  _SelectionButtonState createState() => _SelectionButtonState(attendanceDays);
}

class _SelectionButtonState extends State<SelectionButton> {
  bool isSelected = false;
  final List<String> attendanceDays;
  _SelectionButtonState(this.attendanceDays);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isSelected = !isSelected;
          if (attendanceDays.contains(widget.buttonText)) {
            attendanceDays.remove(widget.buttonText);
          } else {
            attendanceDays.add(widget.buttonText);
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Color(0xFFFF6139)
            : Colors
                .white, // Set the background color based on the selection status
        foregroundColor: isSelected
            ? Colors.white
            : Color(
                0xFFFF6139), // Set the text color based on the selection status
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(11.0), // Adjust the radius as needed
          side: isSelected
              ? BorderSide.none
              : BorderSide(
                  color: Color(0xFFFF6139),
                  width: 1), // Add a border when not selected
        ),
      ),
      child: Text(
        widget.buttonText,
        style: TextStyle(
          fontSize: 15,
          // fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SelectionTime extends StatefulWidget {
  final Function(TimeOfDay) onTimeSelected;

  SelectionTime({required this.onTimeSelected});

  @override
  _SelectionTimeState createState() => _SelectionTimeState();
}

class _SelectionTimeState extends State<SelectionTime> {
  TimeOfDay? selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        widget
            .onTimeSelected(selectedTime!); // Notify parent about selected time
      });
    }
  }

  /*String formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }*/

  String formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute'; // This will display time in HH:mm format
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80, // or any other desired width
          decoration: BoxDecoration(
            color: Color(0xFFFF6139),
            borderRadius: BorderRadius.circular(11.0),
          ),
          child: InkWell(
            onTap: () => _selectTime(context),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.center,
                child: selectedTime != null
                    ? Text(
                        formatTime(selectedTime!),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      )
                    : Text(
                        '00:00',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
