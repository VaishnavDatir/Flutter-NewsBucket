import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateDateAndTime extends StatelessWidget {
  const UpdateDateAndTime({
    Key key,
    @required this.dateTime,
  }) : super(key: key);

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      padding: EdgeInsets.all(3),
      child: Text(
          "Updated at ${DateFormat("dd/MM/yyyy hh:mm a").format(dateTime)}",
          textAlign: TextAlign.right,
          style: GoogleFonts.rubik(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.blue[900],
          )),
    );
  }
}
