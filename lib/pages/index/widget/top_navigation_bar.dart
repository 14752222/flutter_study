import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../store/write_store.dart';

class TopNavigationBar extends StatefulWidget
    implements ObstructingPreferredSizeWidget {
  const TopNavigationBar({super.key});

  @override
  State<TopNavigationBar> createState() => _TopNavigationBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(const CupertinoNavigationBar().preferredSize.height);

  // 这是一个必须实现的方法，用来判断是否需要完全遮挡底部的内容
  @override
  bool shouldFullyObstruct(BuildContext context) {
    // TODO: implement shouldFullyObstruct
    return false;
  }
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  final TextEditingController _textEditingController = TextEditingController();
  final WriteController writeController =
      Get.put<WriteController>(WriteController());
  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      leading: _leadingContent(),
      middle: _middleContent(),
      trailing: _trailingContent(),
    );
  }

  Widget _leadingContent() {
    return SizedBox(
        width: 40,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text("取消"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ));
  }

  Widget _middleContent() {
    return CupertinoTextField(
      controller: _textEditingController,
      placeholder: "请输入标题",
      onChanged: (value) {
        print("value: $value");
        writeController.insertTitle(value);
      },
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0, color: Colors.transparent),
          top: BorderSide(width: 0, color: Colors.transparent),
        ),
      ),
    );
  }

  Widget _trailingContent() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Obx(() => Text(writeController.isEdit.value ? "保存" : "修改")),
      onPressed: () {
        print("保存");
        writeController.saveDiary();
      },
    );
  }
}
