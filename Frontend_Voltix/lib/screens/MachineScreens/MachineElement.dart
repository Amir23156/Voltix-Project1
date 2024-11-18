import 'package:http/http.dart' as http;
import 'package:voltix/PageContent.dart';
import 'package:voltix/config.dart';
import 'package:voltix/screens/MachineScreens/MachineInterface.dart';
//import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'EditMachine.dart';

class MachineElement extends StatelessWidget {
// Title for the container
  final VoidCallback callback;
  final element;
  // Image name for the container

  const MachineElement({
    Key? key,
    required this.element,
    required this.callback,
  }) : super(key: key);

  Future<void> DeleteFunction(context) async {
    final url = '${AppConfig.apiKey}/machine/${element["id"]}';

    final response = await http.delete(
      Uri.parse(url),
    );
    if ((response.statusCode == 200) || (response.statusCode == 204)) {
      callback();
    } else {}
  }

  void Delete(context) async {
    String url;
    CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        text: 'Delete machine ${element["name"]}',
        showCancelBtn: true,
        onConfirmBtnTap: () {
          DeleteFunction(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
            color: Color(0xFF434198), // Use the passed color
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                right: 7,
                top: (150 - 97) / 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Image.asset(element["imageLink"], width: 60, height: 97),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Column(
                  // Use a Column to stack the two Text widgets vertically
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 20.0, 0.0,
                          0.0), // Add more space to the top by changing the second value (top)
                      child: Text(
                        element["name"],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        element["marque"],
                        style: TextStyle(
                          color: Color(0xff9b9b9b),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                top: (180 - 10) / 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    SizedBox(width: 8),
                    Column(
                      // Use a Column to stack the texts vertically
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Add some spacing between the image and text

                        Text(
                          element["consomation"].toString(),
                          style: TextStyle(
                            color: Color(0xff9b9b9b),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 26,
          child: PopupMenuButton<String>(
            onSelected: (String result) {
              // Function to execute when an option is selected from the menu
              switch (result) {
                case 'Edit':
                  // Implement the edit functionality
                  print('Edit Clicked!');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PageContent(
                            content: EditMachine(element: element))),
                  );
                case 'Delete':
                  // Implement the delete functionality
                  print('Delete Clicked!');
                  Delete(context);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'Edit',
                child: Text('Edit'),
              ),
              PopupMenuItem<String>(
                value: 'Delete',
                child: Text('Delete'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
