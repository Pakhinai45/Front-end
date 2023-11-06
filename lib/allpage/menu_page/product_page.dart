import 'dart:convert';
import 'package:appreview/allpage/menu_page/Cart.dart';
import 'package:appreview/allpage/menu_page/NumericStepButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  // final Map<String, dynamic> tableData;
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Map<String, dynamic>> tableData = [];

  int counter = 0;
  int amout = 0;
  final tid = Get.arguments as String;

  List<Map<String, dynamic>> userData = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // เรียก fetchData ใน initState เพื่อดึงข้อมูลเมื่อหน้าถูกสร้าง
  }

  Future<void> fetchData() async {
    String url =
        "http://192.168.56.1/flutter_login_php/flutter_login/product.php";
    final response = await http.get(Uri.parse(url));
    // ignore: avoid_print
    print(response.body);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List;
      setState(() {
        userData = List<Map<String, dynamic>>.from(jsonData);
      });
    } else {
      // ignore: avoid_print
      print('Error: ${response.statusCode}');
    }
  }

  Future CartData(String pid) async {
    String url = "http://192.168.56.1/flutter_login_php/flutter_login/cart.php";
    final response = await http.post(Uri.parse(url), body: {
      'pid': pid,
      'amount': amout.toString(),
      'tid': tid,
    });
    var data = json.decode(response.body);
    if (data == 'Error') {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cart(),
              ),
            );
          },
          child: const Icon(Icons.shopping_bag_outlined,
          size: 30,),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 62, 60, 60),
        title: const Text('โปรโมชั่นเปิดโต๊ะ'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: product(),
            ),
          ],
        ),
      ),
    );
  }

  Widget product() {
    return ListView.builder(
      itemCount: userData.length,
      itemBuilder: (context, index) {
        final user = userData[index];
        return InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('${user['name']}'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('กรุณาใส่จำนวนคน(เก้าอี้)'),
                      NumericStepButton(
                        onChanged: (value) {
                          amout = value;
                        },
                        maxValue: 10,
                      )
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('ยกเลิก'),
                    ),
                    TextButton(
                      onPressed: () {
                        CartData(user['pid']);
                        Navigator.of(context).pop();
                        if (user['price'] != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Cart(),
                              settings: RouteSettings(arguments: user['price']),
                            ),
                          );
                        }
                      },
                      child: const Text('ยืนยัน'),
                    ),
                  ],
                );
              },
            );
            fetchData();
          },
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.all(8),
            color: const Color.fromARGB(255, 196, 196, 196),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '${user['name']}\nราคา ${user['price']}',
                style: const TextStyle(
                  fontSize: 23,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
