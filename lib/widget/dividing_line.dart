
import 'package:flutter/cupertino.dart';

class DividingLine extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Alignment alignment;

  const DividingLine({super.key,
    this.width = 1,
    this.height = 20,
    this.color = CupertinoColors.systemGrey,
    this.alignment = Alignment.center,});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width,
      height: height,
      color: color,
      alignment: alignment,
    );
  }
}

