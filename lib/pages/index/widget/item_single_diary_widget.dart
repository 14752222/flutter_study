import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_1/database/diary.dart';

class ItemSingleDiary extends StatefulWidget {
  final Diary diary;

  const ItemSingleDiary({super.key, required this.diary});

  @override
  State<ItemSingleDiary> createState() => _ItemSingleDiaryState();
}

class _ItemSingleDiaryState extends State<ItemSingleDiary>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double beginScale = 1.0;
  double endScale = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  void showDiaryDetail(double startX, double startY) {
    setState(() {
      endScale = 1.1;
    });

    if (_controller.isAnimating) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: beginScale, end: endScale).animate(_controller),
      child: GestureDetector(
        onTapUp: (TapUpDetails details) {
          showDiaryDetail(details.globalPosition.dx, details.globalPosition.dy);
        },
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 8, top: 8 , bottom: 8),
          margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          decoration: const BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemGrey,
                offset: Offset(2.0, 2.0),
                blurRadius: 2,
                spreadRadius: 0.5,
              )
            ]
          ),
          child: Stack(
            children:[
              Row(
                children: [
                  leftArea(),
                  const SizedBox(width: 20),
                  Expanded(child: centerArea()),
                  rightArea(),
                ],
              ),
              rightArea(),
            ]
          ),

        ),
      ),

    );
  }

  Widget leftArea() {
    return Column(
      children: [
        Text(
          widget.diary.date.day.toString(),
          style: const TextStyle(
            fontSize: 26,
            color: CupertinoColors.white,
          ),
        ),
        Container(
          height: 2,
        ),
        Text(
          DateTime.parse(widget.diary.date.toString()).weekday.toString(),
          style: const TextStyle(
            fontSize: 12,
            color: CupertinoColors.white,
          ),
        )
      ],
    );
  }

  Widget centerArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateTime.parse(widget.diary.date.toString()).toString(),
          style: const TextStyle(
            fontSize: 12,
            color: CupertinoColors.white,
          ),
        ),
        Container(
          height: 2,
        ),
        Text(
            style: const TextStyle(color: CupertinoColors.white, fontSize: 14),
            widget.diary.title == "" ? "无标题" : widget.diary.title),
        Container(height: 2),
        Text(
          widget.diary.content,
          style: const TextStyle(color: CupertinoColors.white, fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget rightArea() {
    return Positioned(
      right: 5,
      top: 5,
      child: Row(children: [
        widget.diary.weather["path"] != null
            ? SvgPicture.asset(
                widget.diary.weather["path"],
                width: 20,
                height: 20,
              )
            : const SizedBox(width: 14.0, height: 14.0),
        const SizedBox(width: 5),
        widget.diary.emotion["path"] != null
            ? SvgPicture.asset(
                widget.diary.emotion["path"],
                width: 20,
                height: 20,
              )
            : const SizedBox(width: 14.0, height: 14.0),
      ]),
    );
  }
}
