// ignore_for_file: file_names
import 'dart:convert';
import 'package:appreview/allpage/menu_page/product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TableDetail extends StatefulWidget {
  final Map<String, dynamic> tableData;

  const TableDetail(this.tableData, {super.key});
  // final String tableDetail;
  // const TableDetail(Map<String, dynamic> user, {Key? key, required this.tableData}) : super(key: key);

  @override
  State<TableDetail> createState() => _TableDetailState();
}

class _TableDetailState extends State<TableDetail> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // เรียก fetchData ใน initState เพื่อดึงข้อมูลเมื่อหน้าถูกสร้าง
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
        tableData = List<Map<String, dynamic>>.from(jsonData);
      });
    } else {
      // ignore: avoid_print
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> reservTable(String tid) async {
    String url =
        "http://192.168.56.1/flutter_login_php/flutter_login/bookTable.php";

    final response = await http.post(Uri.parse(url), body: {
      'tid': widget.tableData['tid'],
    });

    // ignore: avoid_print
    print(response.body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as List;
      setState(() {
        tableData = List<Map<String, dynamic>>.from(jsonData);
      });
    } else {
      // ignore: avoid_print
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 62, 60, 60),
        title: const Text('รายละเอียดโต๊ะ'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Status(),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Status() {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        // ignore: unused_local_variable
        final table = tableData[index];
        // final tablestatus = tableData[index];
        return Column(
          children: [
            Container(
              // elevation: 3,
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'โต๊ะที่ ${widget.tableData['tid']}',
                      style: const TextStyle(
                        fontSize: 50,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    widget.tableData['status'] == '1'
                        ? const Text(
                            'สถานะ - ว่าง',
                            style: TextStyle(
                              fontSize: 23,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          )
                        : const Text(
                            'สถานะ - ไม่ว่าง',
                            style: TextStyle(
                              fontSize: 23,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 400 ),
                child: SizedBox(
                  width: 300,height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black87)),
                    onPressed: () {
                      if (widget.tableData['status'] == '1') {
                        Get.to(const ProductPage(),arguments: widget.tableData['tid']);
                        
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ProductPage(table),
                        //   ),
                        // );
                      } else {
                        // สถานะเป็น "ไม่ว่าง" แสดง popup เเจ้ง
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('สถานะไม่ว่าง'),
                              content: const Text('โต๊ะนี้ไม่ว่าง ไม่สามารถจองได้'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('ปิด'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text("จองโต๊ะ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
