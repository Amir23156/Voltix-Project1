import 'package:flutter/material.dart';

class ListeProvider extends ChangeNotifier {
  List<Map<String, dynamic>> liste = [];
  List<Map<String, dynamic>> filtredListe = [];
  String PageName = "HomePage";
  double AVGConsomation = 0;
  int NotifictionNumber = 0;

  void InizializeListe(newListe, page) {
    liste = newListe;
    filtredListe = newListe;
    InizializePage(newListe, page);
    notifyListeners(); // Notify listeners when the counter changes
  }

  void InizializePage(newListe, page) {
    PageName = page;

    notifyListeners(); // Notify listeners when the counter changes
  }

  void InizializeAVGConsomation(
    aVGConsomation,
  ) {
    AVGConsomation = aVGConsomation;

    notifyListeners(); // Notify listeners when the counter changes
  }

  void InizializeNotificationNulber(num) {
    NotifictionNumber = num;

    notifyListeners(); // Notify listeners when the counter changes
  }

  void InizializeListeWithoutNotifier(newListe, pageName) {
    liste = newListe;
    filtredListe = newListe;
    pageName = PageName;
    // Notify listeners when the counter changes
  }

  void EditFiltredListe(newListe) {
    filtredListe = newListe;
  
    notifyListeners(); // Notify listeners when the counter changes
  }

  void EditElement(newElement) {
    int indexToUpdate = -1;

    for (int i = 0; i < filtredListe.length; i++) {
      if (filtredListe[i]['id'] == newElement["id"]) {
        indexToUpdate = i;
        break;
      }
    }

    // If the element with the given ID is found, update it
    if (indexToUpdate != -1) {
      filtredListe[indexToUpdate] = newElement;
    
    } else {
      print('Element with ID ${newElement["id"]} not found.');
    }
    notifyListeners(); // Notify listeners when the counter changes
  }
}
