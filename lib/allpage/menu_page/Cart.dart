// ignore_for_file: file_names
import 'dart:convert';
// import 'package:appreview/allpage/menu_page/home_page.dart';
// import 'package:appreview/allpage/menu_page/tableDetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  // final proname = Get.arguments as String;
  final price = Get.arguments as String?;
  // ignore: non_constant_identifier_names
  List<Map<String, dynamic>> CardData = [];


  @override
void initState() {
  super.initState();
  fetchData(); // เรียกใน initState เพื่อดึงข้อมูลเมื่อหน้าถูกสร้าง
  
}

  Future<void> fetchData() async {
    String url =
        "http://192.168.56.1/flutter_login_php/flutter_login/order.php";
    final response = await http.get(Uri.parse(url));
    // ignore: avoid_print
    print(response.body);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List;
      setState(() {
        CardData = List<Map<String, dynamic>>.from(jsonData);
      });
    } else {
      // ignore: avoid_print
      print('Error: ${response.statusCode}');
    }
  }

   // ignore: non_constant_identifier_names
   Future<void> DeleteData(String cid) async {
    String url =
        "http://192.168.56.1/flutter_login_php/flutter_login/deletecard.php";
    final response = await http.post(Uri.parse(url), body: {
      'cid': cid,
    });
    // ignore: avoid_print
    print(response.body);
  }

  Future<void> reservTable(String tid) async {
    String url =
        "http://192.168.56.1/flutter_login_php/flutter_login/bookTable.php";

    final response = await http.post(Uri.parse(url), body: {
      'tid': tid,
    });

    // ignore: avoid_print
    print(response.body);

    // if (response.statusCode == 200) {
    //   final jsonData = json.decode(response.body) as List;
    //   setState(() {
    //     CardData = List<Map<String, dynamic>>.from(jsonData);
    //   });
    // } else {
    //   // ignore: avoid_print
    //   print('Error: ${response.statusCode}');
    // }
  }

   Future<void> proOrder(String pid) async {
  // ignore: unnecessary_null_comparison
  if (pid != null && price != null) {
    print('not Null');
    String url = "http://192.168.56.1/flutter_login_php/flutter_login/proorder.php";

    final response = await http.post(Uri.parse(url), body: {
      'pid': pid,
      'total': price
    });

    // คำขอ POST ถูกส่งไปเซิร์ฟเวอร์
    // คุณสามารถเพิ่มการจัดการข้อมูลที่ได้รับจากเซิร์ฟเวอร์ที่นี่
  } else {
  }
}

  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 62, 60, 60),
        title:  const Text('รายการที่เลือก'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: showCard(),
              
            ),
            
          ],
        ),
      ),
    );
  }

  Widget showCard() {

    return ListView.builder(
      itemCount: CardData.length,
      itemBuilder: (context, index) {
        final user = CardData[index];
        return InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => TableDetail(user),
            //   ),
            // );
            fetchData();
          },
          child: Column(
            children: [
              Card(
                elevation: 3,
                margin: const EdgeInsets.all(8),
                color: const Color.fromARGB(255, 196, 196, 196),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'โต๊ะ ${price}',
                        style: const TextStyle(
                          fontSize: 23,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Text('โปรที่จอง : ${user['pid']}',
                      style: const TextStyle(
                          fontSize: 23,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),),
                          Text('จำนวนที่นั่ง : ${user['amount']}',
                      style: const TextStyle(
                          fontSize: 23,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),)
                    ],
                  ),
                ),
              ),
ElevatedButton(
                onPressed: () {
                  reservTable(user['tid']);
                  DeleteData(user['cid']);
                  Navigator.of(context).pop();
                  //proOrder(user['pid']);
                },
                child: const Text('ยืนยันการจอง'),

              ),
            ],
          ),
        );
      },
    );
  }
}