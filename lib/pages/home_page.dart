import 'package:flutter/material.dart';
import 'package:study_1/utils/request.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String textContent = '';
  String from = '';

  @override
  void initState() {
    super.initState();
    loadTextContent();
  }

  void loadTextContent() async {
    try {
      print("state loadTextContent");
      var data = await postRequest("", {"c": "i"});
      setState(() {
        textContent = data["hitokoto"];
        from = data["creator"];
      });
      print("xxxx $data");
    } catch (e) {
      print("erorr $e");
    }
  }


  // 头像
  Widget imageWidget() {
    return const CircleAvatar(
      radius: 90,
      backgroundColor: Colors.white70,
      foregroundImage: NetworkImage(
          'https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302'),
    );
  }

  Widget textWidget() {
    return  Text("$textContent-$from");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[imageWidget(), textWidget()],
        ),
      ),
    );
  }
}
