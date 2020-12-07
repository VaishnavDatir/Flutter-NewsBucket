import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageNotAvaWidget extends StatelessWidget {
  final bool isBig;

  ImageNotAvaWidget({@required this.isBig});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isBig ? 200 : 100,
      width: isBig ? null : 125,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: RichText(
                text: TextSpan(
                  text: 'News',
                  style: GoogleFonts.ubuntu(
                      fontSize: 27, color: Colors.orange[900]),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Bucket',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900])),
                  ],
                ),
              ),
            ),
            Text("Image Not Availabe",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(fontSize: isBig ? 20 : 15))
          ],
        ),
      ),
    );
  }
}
