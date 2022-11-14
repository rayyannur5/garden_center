import 'package:flutter/material.dart';

class AppColor {
  static const Color primary = Color(0xff35605A);
  static const Color primaryDark = Color(0xff133F39);
  static const Color secondary = Color(0xffA3B18A);
  static const Color light = Color(0xffD8E4FF);
  static const Color gatau = Color(0xffD7BE82);
  static const Color grey = Color(0xffF0F0F0);
}

class AppStyle {
  static TextStyle miniparagraph = const TextStyle(fontFamily: 'Poppins', color: Colors.black, fontSize: 10);
  static TextStyle miniparagraphBold =
      const TextStyle(fontFamily: 'Poppins', color: Colors.black, fontSize: 10, fontWeight: FontWeight.w800);
  static TextStyle paragraph = const TextStyle(fontFamily: 'Poppins', color: Colors.black, fontSize: 12);
  static TextStyle paragraphBold = const TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.bold);
  static TextStyle paragraphLight = const TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 12);
  static TextStyle paragraph2Light = const TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 16);
  static TextStyle heading1 =
      const TextStyle(fontFamily: 'Poppins', fontSize: 20, color: Colors.black, fontWeight: FontWeight.w800);
  static TextStyle heading1Light =
      const TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900);
  static TextStyle heading3 = const TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w800);
  static TextStyle heading3Light =
      const TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900);
  static TextStyle heading2thin = const TextStyle(fontFamily: 'Poppins', fontSize: 15);
}
