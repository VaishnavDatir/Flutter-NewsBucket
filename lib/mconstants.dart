import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MConstant {
  static const mAPIKey = "186a96a01cdd4e88b16ad04df6be8e33";

  // static final fontPoppins14 = GoogleFonts.poppins(
  //     fontSize: 14,
  //     // color: Colors.black,
  //     fontWeight: FontWeight.w600);

  // static final fontPoppins16 = GoogleFonts.poppins(
  //     fontSize: 16,
  //     // color: Colors.black,
  //     fontWeight: FontWeight.w600);

  // static final fontPoppins24 = GoogleFonts.poppins(fontSize: 24);

  // static final fontPoppins19w500 =
  //     GoogleFonts.poppins(fontSize: 19, fontWeight: FontWeight.w600);

  static final fontMontserrat20w400 =
      GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w400);

  static final fontUbuntu27Orange = GoogleFonts.ubuntu(
    fontSize: 27,
    // fontWeight: FontWeight.w400,
    color: Colors.orange[900],
  );

  static final fontWorkSans16 = GoogleFonts.workSans(
      // color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500);

  static final fontRoboto22 = GoogleFonts.roboto(
      fontSize: 22,
      // color: Colors.black,
      fontWeight: FontWeight.w600);

  static final fontRubik12 = GoogleFonts.rubik(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.blue[900],
  );

  static TextStyle fontPoppins(double ffontSize, ffontWeight) {
    return GoogleFonts.poppins(
      fontSize: ffontSize,
      fontWeight: ffontWeight ?? FontWeight.normal,
    );
  }
}
