import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'News',
        style: GoogleFonts.ubuntu(fontSize: 27, color: Colors.black),
        children: <TextSpan>[
          TextSpan(
              text: 'Bucket',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue[900])),
        ],
      ),
    );
  }
}
