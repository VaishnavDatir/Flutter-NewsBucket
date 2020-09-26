import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingAndDivider extends StatelessWidget {
  final String heading;

  const HeadingAndDivider({@required this.heading});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "$heading",
              style: GoogleFonts.roboto(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Divider(
            height: 4,
            endIndent: 10,
            indent: 10,
            color: Colors.blue[900],
          ),
        ],
      ),
    );
  }
}
