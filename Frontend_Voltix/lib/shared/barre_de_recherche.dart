import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/ListeProvider.dart';
import '../Provider/ListeProvider.dart';

class BarreDeRecherche extends StatefulWidget {
  final Function(String) filterList;

  BarreDeRecherche({super.key, required this.filterList});

  @override
  State<BarreDeRecherche> createState() => _BarreDeRechercheState();
}

class _BarreDeRechercheState extends State<BarreDeRecherche> {
  @override
  Widget build(BuildContext context) {
    final listeProvider = Provider.of<ListeProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 50,
            color: Color(0xFF25368A).withOpacity(0.13),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            color: Color(0xFF25368A).withOpacity(0.5),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: (value) {
                widget.filterList(value);
              },
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Color(0xFF25368A).withOpacity(0.5),
                ), // TextStyle
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
