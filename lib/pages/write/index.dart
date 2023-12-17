import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:study_1/pages/index/widget/bottom_navigation_bar.dart'
    as bottom;
import 'package:study_1/pages/index/widget/top_navigation_bar.dart';
import 'package:study_1/store/write_store.dart';
import 'package:study_1/utils/Colors.dart';

class WritePage extends StatefulWidget {
  final String id;
  const WritePage({Key? key, required this.id}) : super(key: key);

  @override
  State<WritePage> createState() {
    return _WritePageState();
  }
}

class _WritePageState extends State<WritePage> {
  final WriteController writeController =
      Get.put<WriteController>(WriteController());
  bool textRightToLeft = false;
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController =
        TextEditingController(text: writeController.content.value);
    writeController.insertIsEdit(widget.id == "-1");
    writeController.insertId(int.parse(widget.id));
  }

  void updateContent(String type, String value) {
    // writeController.insertContent(value);
    switch (type) {
      case "text":
        _textEditingController.text += value;
        break;
      case "weather":
        writeController.insertImage(value);
        break;
      default:
        break;
    }
  }

  void saveDiary() async {
    int id = await writeController.saveDiary();
    print("id: $id");
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: TopNavigationBar(),
      child: SafeArea(
        child: Column(
          children: [
            Obx(() => diaryPicture()),
            textInputArea(),
            bottom.BottomNavigationBar(updateContent: updateContent),
          ],
        ),
      ),
    );
  }

  Widget diaryPicture() {
    if (writeController.imageFile.value.isEmpty) {
      return Container(child: null);
    }

    return Container(
        margin: const EdgeInsets.all(16),
        height: 180,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: CupertinoColors.systemGrey,
                offset: Offset(3.0, 3.0),
                blurRadius: 4,
                spreadRadius: 0.5,
              )
            ],
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(File(writeController.imageFile.value)),
            )));
  }

  Widget textInputArea() {
    return Expanded(
        child: CupertinoTextField(
      textAlign: !textRightToLeft ? TextAlign.start : TextAlign.end,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      cursorColor: Consts.themeColor,
      controller: _textEditingController,
      autofocus: true,
      style: const TextStyle(
        fontSize: 18,
        height: 1.8,
      ),
      placeholder: "请输入内容",
      maxLines: 500,
      decoration: const BoxDecoration(border: null),
    ));
  }
}
