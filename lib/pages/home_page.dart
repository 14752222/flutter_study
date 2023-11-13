import 'package:flutter/material.dart';
import 'package:study_1/utils/request.dart';
import 'package:study_1/widget/vertical_text.dart';

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
      var data = await postRequest("", {"c": "i"});
      setState(() {
        textContent = data["hitokoto"];
        from = data["creator"];
      });
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
        'https://img.xjh.me/random_img.php?type=bg&ctype=nature&return=302',
        scale: 0.5,
      ),
    );
  }

  Widget textWidget() {
    return  VerticalText(
      textContent: textContent,
      from: from,
    );
    // return Text(textContent);
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
