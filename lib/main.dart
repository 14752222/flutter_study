import 'package:flutter/material.dart';

import 'package:study_1/pages/home_page.dart';
import 'package:study_1/utils/request.dart';

void main() {
  addInterceptors(); // 添加拦截器
  runApp(const MyApp());
}

class MyApp extends StatefulWidget  {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool darkModeOn = false;

  @override // initState() 方法在 State 对象被插入视图树的时候调用，这个时候可以获取 BuildContext 和 State 对象的 context 属性
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // WidgetsBindingObserver 用于监听应用生命周期变化
  }

  @override // dispose 方法在 State 对象从视图树中被移除的时候调用
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // 移除监听
    super.dispose();
  }

  @override // didChangePlatformBrightness 方法在平台主题变化的时候调用
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    setState(() {
      darkModeOn = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: darkModeOn ? ThemeData(brightness: Brightness.dark,fontFamily: 'ShuYunSong') : ThemeData(brightness: Brightness.light,fontFamily: 'ShuYunSong'),
        darkTheme: darkModeOn ? ThemeData.dark() : ThemeData.light(),
        home: Scaffold(
      body: Stack(
        children: [
          const HomePage(),
          Positioned(
            top: 40,
            right: 20,
            child: SizedBox(
              width: 30,
              height: 30,
              child: MaterialButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  setState(() {
                    darkModeOn = !darkModeOn;
                  });
                },
                child: Icon(
                    darkModeOn ? Icons.dark_mode_outlined : Icons.dark_mode_sharp,
                    color: darkModeOn ?  Colors.white : Colors.black,
                    size: 25),
              ),
            ),
          ),
        ],
      ),
    ));
  }
  Future<Widget> themeButton() async {
    return SizedBox(
      width: 30,
      height: 30,
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        onPressed: () {
          setState(() {
            darkModeOn = !darkModeOn;
          });
        },
        child: Icon(darkModeOn ? Icons.brightness_4_rounded: Icons.brightness_5,
            color: darkModeOn ?  Colors.white : Colors.black , size: 25)  ,
      ),
    );
  }
}
