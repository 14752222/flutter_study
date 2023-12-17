import 'package:flutter/material.dart';
import 'package:study_1/database/diary.dart';
import 'package:study_1/pages/index/widget/item_single_diary_widget.dart';

class DiaryListWidget {
  static Widget diaryList(List<Diary> allDiary) {
    if (allDiary.isEmpty || allDiary == []) {
      return const Center(
        child: Text("暂无日记", style: TextStyle(fontSize: 20)),
      );
    }
    List<Widget> diaryListWidget = [];

    for( var item in allDiary) {
        diaryListWidget.add(ItemSingleDiary(diary: item));
    }

    return SingleChildScrollView(
      child: Column(
        children: diaryListWidget,
      ),
    );
  }
}
