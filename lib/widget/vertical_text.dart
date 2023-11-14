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
    print("widget.textContent ${widget.textContent}");

    int start = 0;

    for (int i = 0; i < numberOfLine; i++) {
      int end = start + widget.numberOfSingleLineText;
      if (end > textContentList.length) {
        end = textContentList.length;
      }
      result.add(textContentList.sublist(start, end));
      start+=widget.numberOfSingleLineText;
    }

    // for (int i = 0;i<=numberOfLine;i++){
    //   int start = i * widget.numberOfSingleLineText;
    //   int end = start + widget.numberOfSingleLineText;
    //   if (end > textContentList.length) {
    //     end = textContentList.length;
    //   }
    //   result.add(textContentList.sublist(start, end));
    // }

    setState(() {
      print("result $result");
      this.textContentList = result.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return animationWidget(
        child:
        Column(
          children: [
          const Padding(padding: EdgeInsets.only(top: 10)),
            createText(),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                "-- ${widget.from} --",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: widget.singleLineWidth + 1,
                ),
              ),
            ),
        ],
    )
    );
  }


  Widget animationWidget({required Widget child}) {
    return AnimatedScale(
        duration: const Duration(microseconds: 2000),
        scale: widget.textContent != '' ? 1.0 : 0.0,
        child: AnimatedRotation(
          duration: const Duration(microseconds: 2000),
          turns: widget.textContent != '' ? 1.0 : 0.0,
          child: child,
        ));
  }

  Widget createText() {
    List<Widget> columnResult = [];
    textContentList?.forEach((element) {
      columnResult.add(createColumnText(element));
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: columnResult,
    );
  }

  Widget createColumnText(List list) {
    List<Widget> result = [];
    list?.forEach((element) {
      result.add(Container(
          width: widget.singleLineWidth,
          margin: const EdgeInsets.only(top: 5,left: 5),
          child: Text(
            element,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: widget.singleLineWidth + 1,
            ),
          )));
    });

    return Column(
      children: result,
    );
  }
}
