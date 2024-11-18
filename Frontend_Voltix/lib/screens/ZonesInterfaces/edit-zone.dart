import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voltix/PageContent.dart';
import 'package:voltix/Services/ZoneService.dart';
import 'package:voltix/screens/ZonesInterfaces/Zones.dart';
import '../../models/zone.dart';
import 'package:cool_alert/cool_alert.dart';

class EditZone extends StatefulWidget {
  var selectedZone; // Add this parameter
  final building;
  EditZone(
      {required this.selectedZone,
      required this.building}); // Add the constructor

  @override
  State<EditZone> createState() => _EditZoneState(); // Pass the selectedZone
}

String formatTime(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute'; // This will display time in HH:mm format
}

/*TimeOfDay parseTimeOfDay(String? time) {
  // Extracting hours and minutes from the input string
  String formattedTime = time.substring(10, 15); // Extracting "HH:mm"
  List<String> parts = formattedTime.split(':');
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}*/

TimeOfDay parseTimeOfDay(String? time) {
  if (time == null || time.length < 15) {
    // Handle the case where the input is null or doesn't have the expected format
    // You can return a default TimeOfDay or handle it according to your app's logic
    return TimeOfDay.now();
  }

  String formattedTime = time.substring(10, 15); // Extracting "HH:mm"
  List<String> parts = formattedTime.split(':');
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);
  return TimeOfDay(hour: hour, minute: minute);
}

class _EditZoneState extends State<EditZone> {
  late TextEditingController zoneNameController;
  late TextEditingController zoneSurfaceController;
  late TextEditingController zoneMainActivityController;
  List<String> updatedAttendanceDays = [];
  String? workStartTime;
  String? workEndTime;
  // Constructor to initialize the selectedZone

  @override
  void initState() {
    super.initState();
    zoneNameController =
        TextEditingController(text: widget.selectedZone['zoneName']);
    zoneSurfaceController =
        TextEditingController(text: widget.selectedZone['zoneSurface']);
    zoneMainActivityController =
        TextEditingController(text: widget.selectedZone['zoneMainActivity']);
    updatedAttendanceDays = List.from(widget.selectedZone['attendanceDays']);
    workStartTime = widget.selectedZone['workStartTime'];
    workEndTime = widget.selectedZone['workEndTime'];
  }

  //create service class
  ZoneService zoneService = ZoneService();

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
                                building: widget.selectedZone['building'],
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
                      'Edit Zone',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SelectionButton(
                                buttonText: 'Monday',
                                attendanceDays: updatedAttendanceDays,
                              ),
                              SizedBox(width: 5),
                              SelectionButton(
                                buttonText: 'Tuesday',
                                attendanceDays: updatedAttendanceDays,
                              ),
                              SizedBox(width: 5),
                              SelectionButton(
                                buttonText: 'Wednesday',
                                attendanceDays: updatedAttendanceDays,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SelectionButton(
                                buttonText: 'Thursday',
                                attendanceDays: updatedAttendanceDays,
                              ),
                              SizedBox(width: 10),
                              SelectionButton(
                                buttonText: 'Friday',
                                attendanceDays: updatedAttendanceDays,
                              ),
                              SizedBox(width: 10),
                              SelectionButton(
                                buttonText: 'Saturday',
                                attendanceDays: updatedAttendanceDays,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
                          SelectionUpdatedTime(
                            initialTime: parseTimeOfDay(workStartTime),
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
                          SelectionUpdatedTime(
                            initialTime: parseTimeOfDay(workEndTime),
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
                        // Update the zone attributes
                        String id =
                            widget.selectedZone['id']; // Use the actual zone ID
                        String updatedName = zoneNameController.text;
                        String updatedSurface = zoneSurfaceController.text;
                        String updatedMainActivity =
                            zoneMainActivityController.text;
                        List<String> updatedAttendanceDays = this
                            .updatedAttendanceDays; // Convert the comma-separated string to a list
                        String? updatedStartTime = workStartTime;
                        String? updatedEndTime = workEndTime;
                        // Check if all fields are filled
                        if (zoneNameController.text.isEmpty ||
                            zoneSurfaceController.text.isEmpty ||
                            zoneMainActivityController.text.isEmpty ||
                            updatedAttendanceDays.isEmpty ||
                            workStartTime == null ||
                            workEndTime == null) {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            title: 'Incomplete Fields',
                            text: 'Please fill all required fields.',
                          );
                          return; // Exit the function to prevent further execution
                        }
                        var response = await ZoneService().updateZone(
                          id,
                          updatedName,
                          updatedSurface,
                          updatedMainActivity,
                          updatedAttendanceDays,
                          updatedStartTime,
                          updatedEndTime,
                        );

                        if (response.statusCode == 200) {
                          Navigator.pop(context);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageContent(
                                  content: ZonesScreen(
                                building: widget.selectedZone["building"],
                              )),
                            ),
                          );
                          // Close the dialog
                        } else {
                          // Update failed, handle accordingly
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
                        'Update',
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
  _SelectionButtonState createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.attendanceDays.contains(widget.buttonText);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isSelected = !isSelected;
          if (isSelected) {
            widget.attendanceDays.add(widget.buttonText);
          } else {
            widget.attendanceDays.remove(widget.buttonText);
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Color(0xFFFF6139) : Colors.white,
        foregroundColor: isSelected ? Colors.white : Color(0xFFFF6139),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11.0),
          side: isSelected
              ? BorderSide.none
              : BorderSide(color: Color(0xFFFF6139), width: 1),
        ),
      ),
      child: Text(
        widget.buttonText,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }
}

class SelectionUpdatedTime extends StatefulWidget {
  final TimeOfDay? initialTime;
  final Function(TimeOfDay) onTimeSelected;

  SelectionUpdatedTime({
    required this.initialTime,
    required this.onTimeSelected,
  });

  @override
  _SelectionUpdatedTimeState createState() => _SelectionUpdatedTimeState();
}

class _SelectionUpdatedTimeState extends State<SelectionUpdatedTime> {
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime ?? TimeOfDay.now();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        widget.onTimeSelected(selectedTime);
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
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: Container(
        width: 80,
        decoration: BoxDecoration(
          color: Color(0xFFFF6139),
          borderRadius: BorderRadius.circular(11.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              formatTime(selectedTime),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
