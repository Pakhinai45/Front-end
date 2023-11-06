import 'dart:convert';
import 'dart:io';
import 'package:appreview/allpage/login.dart';
import 'package:appreview/utility/my_constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Account extends StatefulWidget {
  final String account;

  const Account({Key? key, required this.account}) : super(key: key);
  @override
  // ignore: no_logic_in_create_state
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  File? file;
  List<Map<String, dynamic>> userData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String url =
        "http://192.168.56.1/flutter_login_php/flutter_login/account.php";
    final response = await http.post(Uri.parse(url), body: {
      'username': widget.account,
    });
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
   fetchData();
    // ignore: unused_local_variable
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
       backgroundColor: const Color.fromARGB(255, 62, 60, 60),
        title: const Text('บัญชีของฉัน'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
                Icons.logout),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const Login(),
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
            const SizedBox(height: 25),
            buildImage(size),
            const SizedBox(height: 20),
            showfirstname(),
            const SizedBox(height: 20),
            showlastname(),
            const SizedBox(height: 20),
            showName(),
            const SizedBox(height: 20),
            showemail(),
          ],
        ),
      ),
    );
  }

  
  Widget userLogout() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ButtonBar(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Call your logout function here
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    primary: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  child: const Icon(
                    Icons.logout,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

    Widget showName() {
    // ignore: avoid_unnecessary_containers
    return Container(
      decoration:  BoxDecoration(
        color: MyConstant.dark,
        borderRadius: BorderRadius.circular(18),
      ),
      
      child:  Column(
        children: userData.map((user) {
          // fetchData();
          return ListTile(
            title: Text('Username: ${user['username']}'),
            titleTextStyle: const TextStyle(
                fontSize: 23, color: Color.fromARGB(255, 255, 255, 255)),
          );
          
        }).toList(),
      ),
    );
  }

   Widget showfirstname() {
    // ignore: avoid_unnecessary_containers
    return Container(
      decoration:  BoxDecoration(
        color:MyConstant.dark,
        borderRadius: BorderRadius.circular(18),
      ),
      
      child:  Column(
        children: userData.map((user) {
          // fetchData();
          return ListTile(
            title: Text('FirstName: ${user['firstname']}'),
            titleTextStyle: const TextStyle(
                fontSize: 23, color: Color.fromARGB(255, 255, 255, 255)),
          );
          
        }).toList(),
      ),
    );
  }

   Widget showlastname() {
    // ignore: avoid_unnecessary_containers
    return Container(
      decoration:  BoxDecoration(
        color:MyConstant.dark,
        borderRadius: BorderRadius.circular(18),
      ),
      
      child:  Column(
        children: userData.map((user) {
          // fetchData();
          return ListTile(
            title: Text('LastName: ${user['lastname']}'),
            titleTextStyle: const TextStyle(
                fontSize: 23, color: Color.fromARGB(255, 255, 255, 255)),
          );
          
        }).toList(),
      ),
    );
  }

  Widget showemail() {
    // ignore: avoid_unnecessary_containers
    return Container(
      decoration:  BoxDecoration(
        color: MyConstant.dark,
        borderRadius: BorderRadius.circular(18),
      ),
      
      child:  Column(
        children: userData.map((user) {
          // fetchData();
          return ListTile(
            title: Text('Email: ${user['email']}'),
            titleTextStyle: const TextStyle(
                fontSize: 23, color: Color.fromARGB(255, 255, 255, 255)),
          );
          
        }).toList(),
      ),
    );
  }

   Row buildImage(double size) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(backgroundImage: AssetImage('images/8.jpg'),radius: 100,)
      ],
    );
  }

}
