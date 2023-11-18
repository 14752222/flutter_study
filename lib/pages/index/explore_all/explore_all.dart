import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_1/pages/index/widget/diary_list_widget.dart';

import 'package:study_1/utils/Colors.dart';

import '../../../database/diary.dart';

class ExploreAllPage extends StatefulWidget {
  const ExploreAllPage({super.key});

  @override
  State<ExploreAllPage> createState() => _ExploreAllPageState();
}

class _ExploreAllPageState extends State<ExploreAllPage> {
  List<Diary> allDiary = [];

  @override
  void initState() {
    super.initState();
  }

  void loadDiaryAll()  async{
    var allDiaryRow = await DiaryDb().queryAll();
     allDiary.clear();

     if (allDiaryRow.isNotEmpty) {
       for (var item in allDiaryRow) {
         allDiary.add(Diary().formMap(item as Map<String, Object?>));
       }
     }

  }


  @override
  Widget build(BuildContext context) {

    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(top: 5),
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: NetworkImage("https://picsum.photos/1080/1920"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child:  Stack(
          children: [DiaryListWidget.diaryList(allDiary), addNewDiaryButton()]
        ));
  }

  Widget addNewDiaryButton() {
    return Positioned(
      right: 20,
      bottom: 20,
      child: CupertinoButton(
        onPressed: () {},
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              color: Consts.themeColor,
              borderRadius: const BorderRadius.all(Radius.circular(80)),
              border: Border.all(width: 0, style: BorderStyle.none),
              boxShadow: const [
                BoxShadow(
                  color: CupertinoColors.systemBlue,
                  offset: Offset(5.0, 5.0),
                  blurRadius: 15.0,
                  spreadRadius: 0.1,
                )
              ] ),
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
