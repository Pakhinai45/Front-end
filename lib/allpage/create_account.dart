import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utility/my_constant.dart';
import '../widgets/show_image.dart';
import '../widgets/show_title.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool statusRedEye = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future signUp() async {
    String url ="http://192.168.56.1/flutter_login_php/flutter_login/register.php";
    final response = await http.post(Uri.parse(url), body: {
      'firstname':fname.text,
      'lastname':lname.text,
      'email':email.text,
      'username':user.text,
      'password':pass.text,
    });
    var data = json.decode(response.body);
    if(data == 'Error'){
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/createAccount');
    }else{
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double size = MediaQuery.of(context).size.width;
    return SafeArea(
        child: GestureDetector(
      //เมื่อเเตะที่วางให้เเป้นพิมพ์หาย
      onTap: () => FocusScope.of(context).requestFocus(
        FocusNode(),
      ),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('สมัคสมาชิก'),
          backgroundColor: MyConstant.dark,
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTitle('สร้างบัญชี'),
                //buildImage(size),
                buildFirstName(size),
                buildLastName(size),
                buildEmail(size),
                buildUser(size),
                buildPassword(size),
                buildConfirmPassword(size),
                buildLogin(size),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ignore: sized_box_for_whitespace
        Container(
          width: size * 0.5,
          child: ShowImage(path: MyConstant.image7),
        ),
      ],
    );
  }

  Container buildTitle(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h4Style(),
      ),
    );
  }

  Row buildFirstName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: size * 0.6,
          // ignore: body_might_complete_normally_nullable
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก ชื่อ';
              } else {}
              return null;
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'ชื่อ :',
              prefixIcon: const Icon(
                Icons.fingerprint,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            controller: fname,
          ),
        ),
      ],
    );
  }

  Row buildLastName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: size * 0.6,
          // ignore: body_might_complete_normally_nullable
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก นามสกุล';
              } else {}
              return null;
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'นามสกุล :',
              prefixIcon: const Icon(
                Icons.fingerprint,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            controller: lname,
          ),
        ),
      ],
    );
  }


  Row buildEmail(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: size * 0.6,
          // ignore: body_might_complete_normally_nullable
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกอีเมล';
              } else {}
              return null;
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'อีเมล :',
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            controller: email,
            keyboardType: TextInputType.emailAddress,
          ),
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
          // ignore: body_might_complete_normally_nullable
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกชื่อบัญชี';
              } else {}
              return null;
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'ชื่อบัญชี :',
              prefixIcon: const Icon(
                Icons.perm_identity,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            controller: user,
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
          // ignore: body_might_complete_normally_nullable
          child: TextFormField(
            obscureText: statusRedEye,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกรหัสผ่าน';
              } else {}
              return null;
            },
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
                        color: MyConstant.dark,
                      )
                    : const Icon(
                        Icons.remove_red_eye_outlined,
                        color: MyConstant.dark,
                      ),
              ),
              labelStyle: MyConstant().h3Style(),
              labelText: 'รหัสผ่าน :',
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            controller: pass,
          ),
        ),
      ],
    );
  }

  Row buildConfirmPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: size * 0.6,
          // ignore: body_might_complete_normally_nullable
          child: TextFormField(
            obscureText: statusRedEye,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกรหัสผ่าน';
              // ignore: unrelated_type_equality_checks
              } else if(value != pass.text){
                return 'รหัสผ่านไม่ตรงกัน';
              }
              return null;
            },
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
                        color: MyConstant.dark,
                      )
                    : const Icon(
                        Icons.remove_red_eye_outlined,
                        color: MyConstant.dark,
                      ),
              ),
              labelStyle: MyConstant().h3Style(),
              labelText: 'ยืนยันรหัสผ่าน:',
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            //controller: pass,
          ),
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
                  signUp();
              }
            },
            child: const Text('สร้างบัญชี'),
          ),
        ),
      ],
    );
  }
}
