// ignore: unused_import
import 'package:flutter/material.dart';

class MyConstant {
  //Genernal
  static String appName = 'App Review';

  //Route
  static String routeLogin = '/login';
  static String routeCreateAccount = '/createAccount';

  //Image
  static String image1 = 'images/1.png';
  static String image2 = 'images/2.png';
  static String image3 = 'images/3.png';
  static String image4 = 'images/4.png';
  static String image5 = 'images/5.png';
  static String image6 = 'images/6.png';
  static String image7 = 'images/7.png';
   static String image8 = 'images/8.jpg';
  static String image9 = 'images/9.png';
  static String image10 = 'images/10.png';

  //Color
  static Color primary =  const Color.fromARGB(255, 14, 14, 14);
  static const  Color dark = Color.fromARGB(255, 157, 157, 157);
  static const  Color light = Color.fromARGB(255, 0, 0, 0);

  //Style
  TextStyle h1Style() =>
      const TextStyle(fontSize: 24, color: dark, fontWeight: FontWeight.bold);
  TextStyle h2Style() => const TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );
  TextStyle h3Style() => const TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );
  TextStyle h4Style() => const TextStyle(
        fontSize: 30,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  //Bottons
  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        backgroundColor: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
}
