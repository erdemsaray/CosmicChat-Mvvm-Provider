import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorItems {
  //static const Color mainRedColor = Color.fromARGB(255, 126, 23, 18);
  static const Color facebookButtonColor = Color.fromARGB(255, 74, 97, 168);
  static const Color googleButtonColor = Color.fromARGB(255, 83, 160, 244);
  static const Color generalTurquaseColor = Color.fromARGB(156, 7, 214, 207);

}

class StringItems {
  //static const String projectName = 'App Name';
}

class ImageItems {
  //static AssetImage backgroundImage = const AssetImage('assets/background.png');
  
}

class FontItems {
  static TextStyle normalTextInter18 = GoogleFonts.inter(
    fontSize: 18,
    color: Colors.white,
  );
  static TextStyle normalTextInter14 = GoogleFonts.inter(
    fontSize: 18,
    color: Colors.white,
  );

  static TextStyle boldTextInter20 = GoogleFonts.inter(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);

  static TextStyle normalTextWorkSans16 = GoogleFonts.workSans(fontSize: 16, color: Colors.white);
  static TextStyle boldTextWorkSans20 =
      GoogleFonts.workSans(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
  static TextStyle boldTextInter24 = GoogleFonts.inter(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold);

  static TextStyle normalTextStyle16 = const TextStyle(fontSize: 16, color: Colors.white);
  static TextStyle normalTextStyle20 = const TextStyle(fontSize: 20, color: Colors.white);
  static TextStyle normalTextStyle14 = const TextStyle(fontSize: 14, color: Colors.white);
}