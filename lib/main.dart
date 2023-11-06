import 'package:appreview/allpage/create_account.dart';
import 'package:appreview/allpage/login.dart';
import 'package:appreview/utility/my_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final Map<String, WidgetBuilder> map = {
  '/login':(BuildContext context)=>  const Login(),
  '/createAccount':(BuildContext context) =>  const CreateAccount(),
  // '/tableDetail':(BuildContext context) =>  const TabelDetail(),
};

String? initlalRoute;

void main(){
  initlalRoute = MyConstant.routeLogin;
  // ignore: prefer_const_constructors
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const Login(),
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRoute,
    );
  }
}

