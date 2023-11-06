import 'dart:convert';
import 'package:appreview/allpage/menu_page/account_page.dart';
import 'package:appreview/allpage/menu_page/home_page.dart';
import 'package:appreview/utility/my_constant.dart';
import 'package:appreview/widgets/show_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/show_title.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool statusRedEye = true;

  final formKey = GlobalKey<FormState>();
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future signIn() async {
    String url =
        "http://192.168.56.1/flutter_login_php/flutter_login/login.php";
    final response = await http.post(Uri.parse(url), body: {
      'username': user.text,
      'password': pass.text,
    });
    var data = json.decode(response.body);
    if (data == 'Error') {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/login');
    } else {
      // ignore: use_build_context_synchronously
      Account account = Account(account: user.text);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  HomePage(account: account),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: formKey,
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(
              FocusNode(),
            ),
            behavior: HitTestBehavior.opaque,
            child: ListView(
              children: [
                SizedBox(height: 80,),
                buildImage(size),
                const Center(child: Text('Reserve table',style:TextStyle(fontSize: 35,fontWeight: FontWeight.bold),)),
                buildUser(size),
                buildPassword(size),
                buildLogin(size),
                buildCreateAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ignore: sized_box_for_whitespace
        Container(
          width: size * 0.5,
          child: ShowImage(path: MyConstant.image10),
        ),
      ],
    );
  }

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก ชื่อบัญชี';
              } else {}
              return null;
            },
            controller: user,
            decoration: InputDecoration(
              
              labelStyle: MyConstant().h3Style(),
              labelText: 'ชื่อบัญชี :',
              prefixIcon: const Icon(
                Icons.person,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            obscureText: statusRedEye,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก รหัสผ่าน';
              } else {}
              return null;
            },
            controller: pass,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    statusRedEye = !statusRedEye;
                  });
                },
                icon: statusRedEye
                    ? const Icon(
                        Icons.remove_red_eye,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )
                    : const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
              ),
              labelStyle: MyConstant().h3Style(),
              labelText: 'รหัสผ่าน :',
              prefixIcon: const Icon(
                Icons.lock_person,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildCreateAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: 'ยังไม่มีบัญชี ?',
          textStyle: MyConstant().h3Style(),
        ),
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, MyConstant.routeCreateAccount),
          child: const Text('สมัคสมาชิก'),
        ),
      ],
    );
  }

  Row buildLogin(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          width: size * 0.6,
          child: ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black87)),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                signIn();
              }
            },
            child: const Text('เข้าสู่ระบบ'),
          ),
        ),
      ],
    );
  }
}
