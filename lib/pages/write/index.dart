import 'package:flutter/material.dart';

class WritePage extends StatefulWidget {
  const WritePage({Key? key}) : super(key: key);

  @override
  State<WritePage> createState() {
    return _WritePageState();
  }
}

class _WritePageState extends State<WritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("写文章"),
      ),
      body: Container(
        child: const Text("xcxx"),
      ),
    );
  }
}
