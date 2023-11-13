import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerticalText extends StatefulWidget {
  final String textContent;
  final String from;
  final int numberOfSingleLineText;
  final double singleLineWidth;

  const VerticalText({
    super.key,
    required this.textContent, // 文本内容
    required this.from, // 来源
    this.numberOfSingleLineText = 10, // 每行字数
    this.singleLineWidth = 16, // 每行字宽度
  });

  @override
  State<VerticalText> createState() => _VerticalTextState();

//处理文本内容 每行10个字 返回一个二维数组，每个元素在二维数组中代表一行
}

class _VerticalTextState extends State<VerticalText> {
  List<List<String>> textContentList = [];

  @override
  void initState() {
    super.initState();
  }

  //update时候调用
  @override
  void didUpdateWidget(covariant VerticalText oldWidget) {
    super.didUpdateWidget(oldWidget);
    handleTextContent();
  }

  void handleTextContent() {
    List<List<String>> result = [];
    List<String> textContentList = widget.textContent.split("");
    int numberOfLine =
        (textContentList.length / widget.numberOfSingleLineText).ceil();
    int start = 0;
    print("widget.textContent ${widget.textContent}");
    print("numberOfLine $numberOfLine");
    print(textContentList);

    for (int i = 0; i < numberOfLine; i++) {
      int end = start + widget.numberOfSingleLineText;
      if (end > textContentList.length) {
        end = textContentList.length;
      }
      result.add(textContentList.sublist(start, end));
      start++;
    }

    print(result);

    setState(() {
      //反转
      this.textContentList = result.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child:Column(
        children: [
          createText(),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              "--${widget.from}--",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      )
      );
  }

  Widget createText() {
    List<Widget> columnResult = [];
    textContentList?.forEach((element) {
      columnResult.add(createColumnText(element));
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: columnResult,
    );
  }

  Widget createColumnText(List list) {
    List<Widget> result = [];
    list?.forEach((element) {
      result.add(Container(
          width: widget.singleLineWidth,
          margin: const EdgeInsets.only(left: 5),
          child: Text(
            element,
            textAlign: TextAlign.center,
            style:  TextStyle(
              fontSize: widget.singleLineWidth + 1,
            ),
          )));
    });

    return Column(
      children: result,
    );
  }
}
