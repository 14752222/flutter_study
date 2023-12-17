import 'package:get/get.dart';

import '../database/diary.dart';

class WriteController extends GetxController {
  Rx<String> imageFile = RxString("");
  Rx<String> content = RxString("");
  Rx<String> title = RxString("");
  RxInt id = RxInt(0);
  Rx<int> textRightToLeft = RxInt(0);
  Rx selectedWeather = Rx<Map<String, dynamic>>({});
  Rx selectedEmotion = Rx<Map<String, dynamic>>({});
  Rx date = Rx<DateTime>(DateTime.now());
  RxBool isEdit = RxBool(false);

  // singleDiary.textRightToLeft = textRightToLeft;
  // singleDiary.weather = selectedWeather;
  // singleDiary.emotion = selectedEmotion;
  // singleDiary.date = selectedDate;

  void insertId(int value) {
    id.value = value;
  }

  void insertImage(String image) {
    imageFile.value = image;
  }

  void insertContent(String text) {
    content.value = text;
  }

  void insertTitle(String text) {
    title.value = text;
  }

  void insertTextRightToLeft(int value) {
    textRightToLeft.value = value;
  }

  void insertSelectedWeather(Map<String, dynamic> value) {
    selectedWeather.value = value;
  }

  void insertSelectedEmotion(Map<String, dynamic> value) {
    selectedEmotion.value = value;
  }

  void insertSelectedDate(DateTime value) {
    date.value = value;
  }

  void insertIsEdit(bool value) {
    isEdit.value = value;
  }

  void clearAll() {
    imageFile.value = "";
    content.value = "";
    title.value = "";
    textRightToLeft.value = 0;
    selectedWeather.value = {};
    selectedEmotion.value = {};
  }

  Future<int> saveDiary() async {
    Diary diary = Diary();
    diary.id = 0;
    diary.image = imageFile.value;
    diary.content = content.value;
    diary.title = title.value;
    diary.date = DateTime.now();
    diary.textRightToLeft = textRightToLeft.value == 1;
    diary.weather = selectedWeather.value;
    diary.emotion = selectedEmotion.value;
    return diaryDb.insert(diary);
  }

  void updateDiary(Diary diary) async {
    diary.image = imageFile.value;
    diary.content = content.value;
    diary.title = title.value;
    diary.date = DateTime.now();
    diary.textRightToLeft = textRightToLeft.value == 1;
    diary.weather = selectedWeather.value;
    diary.emotion = selectedEmotion.value;

    await diaryDb.update(diary);
  }

  void deleteDiary(Diary diary) async {
    await DiaryDb().deleteById(diary.id);
  }

  void recoverDiary(int id) async {
    await diaryDb.queryById(id).then((value) {
      Diary diary = Diary().formMap(value as Map<String, Object?>);
      insertImage(diary.image);
      insertContent(diary.content);
      insertTitle(diary.title);
      insertTextRightToLeft(diary.textRightToLeft ? 1 : 0);
      insertSelectedWeather(diary.weather);
      insertSelectedEmotion(diary.emotion);
    });
  }
}
