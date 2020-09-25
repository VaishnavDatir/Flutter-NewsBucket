import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageNotAvaWidget extends StatelessWidget {
  const ImageNotAvaWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RichText(
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
          ),
          Text("Image Not Availabe",
              style: GoogleFonts.ubuntu(fontSize: 20, color: Colors.black))
        ],
      ),
    );
  }
}
