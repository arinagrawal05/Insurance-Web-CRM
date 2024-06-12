import 'exports.dart';

Widget heading(
  String text,
  double fontSize,
) {
  double size = getmobile ? fontSize / 2 : fontSize;
  return Text(
    text,
    style: fontStyle(size),
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
  // final responsiveFontSize =
  //     (SizeConfig.screenWidth! + SizeConfig.screenHeight!) * 0.025;

  // // Calculate the final font size by considering the text scale factor
  // final size = fontSize * SizeConfig.textScaleFactor! * responsiveFontSize;

  // double size = (SizeConfig.screenHeight! + SizeConfig.screenHeight!) * 0.025;

  double size = getmobile ? fontSize / 1.4 : fontSize;

  return Text(
    text,
    softWrap: true,
    overflow: overF,
    textAlign: center ? TextAlign.center : TextAlign.justify,
    style: GoogleFonts.nunito(
        fontSize: size, fontWeight: FontWeight.w500, color: color),
  );
}

Widget simpleText(String text, double fontSize,
    {TextAlign align = TextAlign.left}) {
  double size = getmobile ? fontSize / 2 : fontSize;

  return Text(
    text,
    textAlign: align,
    style: GoogleFonts.nunito(
      fontSize: size,
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
          : Theme.of(context).dialogBackgroundColor.withOpacity(0.2));
}
