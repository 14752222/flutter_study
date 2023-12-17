import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_1/store/write_store.dart';
import 'package:study_1/utils/Colors.dart';
import 'package:study_1/utils/datetime_util.dart';
import 'package:study_1/widget/dividing_line.dart';

class BottomNavigationBar extends StatefulWidget {
  final void Function(String type, String value) updateContent;

  const BottomNavigationBar({super.key, required this.updateContent});

  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {
  final WriteController writeController =
      Get.put<WriteController>(WriteController());
  Map selectedWeather = {};
  Map selectedEmotion = {};
  DateTime selectedDate = DateTime.now();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  // 显示设置窗口
  void showSettingDialog() {
    //TODO 显示设置窗口
  }

// 插入图片
  void insertImage() {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
              title: const Text('选择图片来源'),
              cancelButton: CupertinoActionSheetAction(
                isDestructiveAction: true, // isDestructiveAction 设置按钮文字为红色
                child: const Text('取消', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <CupertinoActionSheetAction>[
                CupertinoActionSheetAction(
                  child: const Text('拍照'),
                  onPressed: () async {
                    Navigator.pop(context);
                    _imageFile =
                        await _picker.pickImage(source: ImageSource.camera);
                    writeController.insertImage(_imageFile!.path);
                    print("insert1 imageFile: ${_imageFile!.path}");
                  },
                ),
                CupertinoActionSheetAction(
                  child: const Text('从相册选择'),
                  onPressed: () async {
                    Navigator.pop(context);
                    _imageFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    writeController.insertImage(_imageFile!.path);
                    print("insert imageFile: ${_imageFile!.path}");
                  },
                ),
              ]);
        });
  }

// 在文本底部插入时间日期
  void insertDateTime() {
    // String text =
    //     "${writeController.content}\n${DateTimeUtil.parseDateTimeNow()}";
    //
    // print("insertDateTime: $text");
    // writeController.insertContent(text);
    widget.updateContent("text", DateTimeUtil.parseDateTimeNow());
  }

// 设置天气
  void setWeather() {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.only(top: 6.0),
              height: 200,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // 作用是 使背景色跟随系统
              child: SafeArea(
                top: false,
                child: CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 30,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      selectedWeather = Consts.weatherResource[index];
                      // widget.updateContent(
                      //     "weather", Consts.weatherResource[index]);
                      writeController
                          .insertSelectedWeather(Consts.weatherResource[index]);
                    });
                  },
                  children: List<Widget>.generate(
                      Consts.weatherResource.length,
                      (index) => Center(
                              child: Text(
                            Consts.weatherResource[index]['name'],
                            textAlign: TextAlign.center,
                          ))),
                ),
              ));
        });
  }

// 设置心情
  void setEmotion() {
    //TODO 设置心情
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              height: 216,
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                  top: false,
                  child: CupertinoPicker(
                    magnification: 1.22,
                    // 放大倍数
                    squeeze: 1.2,
                    // 间距
                    useMagnifier: true,
                    // 是否使用放大效果
                    itemExtent: 30,
                    // 每个item的高度
                    onSelectedItemChanged: (index) {
                      print(Consts.emotionResource[index]);
                      writeController
                          .insertSelectedWeather(Consts.emotionResource[index]);
                      setState(() {
                        selectedEmotion = Consts.emotionResource[index];
                      });
                    },
                    children: List<Widget>.generate(
                        Consts.emotionResource.length,
                        (index) => Center(
                                child: Text(
                              Consts.emotionResource[index]['name'],
                              textAlign: TextAlign.center,
                            ))), // 生成子控件
                  )));
        });
  }

// 设置日期
  void setDate() {
    //TODO 设置日期
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom, // 适配键盘
              ),
              height: 216, // 高度
              color: CupertinoColors.systemBackground
                  .resolveFrom(context), // 作用是 使背景色跟随系统
              child: SafeArea(
                  top: false, // 适配刘海屏
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date, // 显示模式
                    initialDateTime: selectedDate, // 初始时间
                    onDateTimeChanged: (DateTime value) {
                      writeController.insertSelectedDate(value);
                      setState(() {
                        selectedDate = value;
                      }); // 选中时间
                    },
                  )));
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        child: Row(children: [
          Expanded(
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: _iconButton(CupertinoIcons.settings,
                      onPressed: showSettingDialog))),
          _iconButton(CupertinoIcons.photo, onPressed: insertImage),
          _iconButton(CupertinoIcons.clock, onPressed: insertDateTime),
          // 分割线
          const DividingLine(
            width: 1,
            height: 20,
            color: CupertinoColors.systemGrey,
            alignment: Alignment.center,
          ),
          _weatherButton(),

          _emotionButton(),

          _dateButton(),
        ]));
  }

  // 设置按钮
  Widget _iconButton(IconData iconName, {required Function onPressed}) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {
        onPressed();
      },
      child: Icon(
        iconName,
        size: 20,
        color: CupertinoColors.systemGrey,
      ),
    );
  }

  // 设置天气
  Widget _weatherButton() {
    Widget weatherIcon;

    if (selectedWeather == {} || selectedWeather['path'] == null) {
      weatherIcon = const Icon(CupertinoIcons.sun_max_fill,
          size: 20, color: CupertinoColors.systemGrey);
    } else {
      weatherIcon = SvgPicture.asset(
        selectedWeather['path'],
        width: 20,
        height: 20,
      );
    }

    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {
        setWeather();
      },
      child: weatherIcon,
    );
  }

  // 设置心情
  Widget _emotionButton() {
    Widget emotionIcon;

    if (selectedEmotion == {} || selectedEmotion['path'] == null) {
      emotionIcon = const Icon(CupertinoIcons.smiley,
          size: 20, color: CupertinoColors.systemGrey);
    } else {
      emotionIcon = SvgPicture.asset(
        selectedEmotion['path'],
        width: 20,
        height: 20,
      );
    }

    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {
        setEmotion();
      },
      child: emotionIcon,
    );
  }

  // 设置日期
  Widget _dateButton() {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {
        setDate();
      },
      child: const Icon(
        CupertinoIcons.calendar,
        size: 20,
        color: CupertinoColors.systemGrey,
      ),
    );
  }
}
