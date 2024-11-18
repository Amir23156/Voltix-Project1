import 'package:flutter/material.dart';
import '../Alert/alerte.dart';
import '../MachineScreens/MachineInterface.dart';
import 'update-circuit-breaker.dart';
import 'package:cool_alert/cool_alert.dart';
import '../../Services/CircuitBreakerService.dart';
import '../../PageContent.dart';

class CircuitBreakerElement extends StatelessWidget {
  final element;
  final Function(Map<String, dynamic> element) onUpdatePressed;
  final Function(String id) onDeletePressed;
  final CircuitBreakerService apiService = CircuitBreakerService();

  final Function() fetchdata;

  CircuitBreakerElement({
    Key? key,
    required this.element,
    required this.onUpdatePressed,
    required this.onDeletePressed,
    required this.fetchdata,
  }) : super(key: key);

  /*void Delete(context) async {
    String url;
    CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        text: 'Delete machine ${element["name"]}',
        showCancelBtn: true,
        onConfirmBtnTap: () {
          DeleteFunction(context);
        });*/
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PageContent(
                  content: MachineInterface(
                circuitBreaker: element,
              )),
            ));
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 3, 16, 0),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: Color(0xFFDAE0EC),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 18),
                child: SizedBox(
                  width: 35,
                  height: 46,
                  child: Image.asset(
                    'assets/page-1/images/breaker-1-5.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: 22),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      element["circuitBreakerName"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(element["circuitBreakerRefrence"]),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PopupMenuButton<String>(
                      onSelected: (String result) {
                        switch (result) {
                          case 'Edit':
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PageContent(
                                      content: UpdateCircuitBreaker(
                                    selectedElement: element,
                                  )),
                                ));

                            break;
                          case 'Edit Limit':
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(
                                    Circuitbreaker:
                                        element); // Your custom dialog widget
                              },
                            );

                            break;
                          case 'Delete':
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.warning,
                                text:
                                    'Delete machine ${element['circuitBreakerName']}',
                                showCancelBtn: true,
                                onConfirmBtnTap: () async {
                                  await apiService
                                      .deleteCircuitBreaker(element['id']);
                                  await fetchdata();
                                  //onDeletePressed(element['id']);
                                });
                          /*onDeletePressed(element['id']);
                            break;*/
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'Edit',
                          child: Text('Edit'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Delete',
                          child: Text('Delete'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Edit Limit',
                          child: Text('Edit Limit'),
                        ),
                      ],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
