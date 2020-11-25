import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingScreenWidget extends StatelessWidget {
  const LoadingScreenWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 20,
          ),
          Text(
            "Loading...",
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
