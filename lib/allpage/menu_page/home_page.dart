import 'dart:convert';

import 'package:appreview/allpage/menu_page/account_page.dart';
import 'package:appreview/allpage/menu_page/tableDetail.dart';
import 'package:appreview/utility/my_constant.dart';
import 'package:appreview/widgets/show_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final Account account;

  const HomePage({super.key, required this.account});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> userData = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // เรียกใน initState เพื่อดึงข้อมูลเมื่อหน้าถูกสร้าง
  }

  Future<void> fetchData() async {
    String url =
        "http://192.168.56.1/flutter_login_php/flutter_login/table.php";
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

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 62, 60, 60),
        title: const Text('หน้าหลัก'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
                Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Account(account: widget.account.account),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            buildImage(size), // Display the image
            Expanded(
              child: showNumber(), // Display the list of numbers
            ),
          ],
        ),
      ),
    );
  }

  Widget showNumber() {
    return ListView.builder(
      itemCount: userData.length,
      itemBuilder: (context, index) {
        final user = userData[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TableDetail(user),
              ),
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
                'โต๊ะ ${user['tablenumber']}',
                style: const TextStyle(
                  fontSize: 23,
                  color: Color.fromARGB(255, 7, 2, 2),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ignore: sized_box_for_whitespace
        Container(
          width: size * 0.9,
          child: ShowImage(path: MyConstant.image9),
        ),
      ],
    );
  }
}
