import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget heading(
  String text,
  double fontSize,
) {
  return Text(
    text,
    style: fontStyle(fontSize),
  );
}

TextStyle fontStyle(double fontSize) {
  return GoogleFonts.nunito(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.none);
}

Widget heading1(String text, double fontSize,
    {TextOverflow overF = TextOverflow.ellipsis, bool center = false}) {
  return Text(
    text,
    style: GoogleFonts.nunito(
        color: Colors.grey, fontSize: fontSize, fontWeight: FontWeight.w500),
    overflow: overF,
    textAlign: center ? TextAlign.center : TextAlign.justify,
  );
}

Widget productTileText(String text, double fontSize,
    {TextOverflow overF = TextOverflow.ellipsis,
    bool center = false,
    Color? color}) {
  return Text(
    text,
    softWrap: true,
    overflow: overF,
    textAlign: center ? TextAlign.center : TextAlign.justify,
    style: GoogleFonts.nunito(
        fontSize: fontSize, fontWeight: FontWeight.w500, color: color),
  );
}

Widget simpleText(String text, double fontSize,
    {TextAlign align = TextAlign.left}) {
  return Text(
    text,
    textAlign: align,
    style: GoogleFonts.nunito(
      fontSize: fontSize,
    ),
  );
}

Widget buttonText(
  String text,
  double fontSize, {
  Color color = Colors.white,
}) {
  return Text(
    text,
    style: GoogleFonts.nunito(
        color: color, fontSize: fontSize, fontWeight: FontWeight.w500),
  );
}

BoxDecoration dashBoxDex(BuildContext context, {bool isContrast = false}) {
  return BoxDecoration(
      // boxShadow: [
      //   BoxShadow(
      //       spreadRadius: 2,
      //       offset: Offset(0.2, 0.2),
      //       blurRadius: 1.0,
      //       color: Colors.blueGrey),
      // ],
      borderRadius: BorderRadius.circular(10),
      color: isContrast
          ? Colors.blueGrey
          : Theme.of(context).dialogBackgroundColor);
}
