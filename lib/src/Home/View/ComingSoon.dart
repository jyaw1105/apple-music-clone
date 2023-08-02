import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ComingSoonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(
              FontAwesomeIcons.personRunning,
              size: 80,
            ),
          ),
          Text(
            "Coming Soon",
            style: TextStyle(fontSize: 30),
          )
        ],
      ),
    );
  }
}
