import 'package:flutter/material.dart';

import 'package:study_1/pages/home_page.dart';
import 'package:study_1/utils/request.dart';

void main() {
  addInterceptors(); // 添加拦截器
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool darkModeOn = false;


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
        child: Icon(darkModeOn ? Icons.dark_mode_outlined : Icons.dark_mode,
            color: darkModeOn ? Colors.white : Colors.black, size: 25),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                  print("onPressed");
                  setState(() {
                    darkModeOn = !darkModeOn;
                  });
                },
                child: Icon(
                    darkModeOn ? Icons.dark_mode_outlined : Icons.dark_mode,
                    color: darkModeOn ? Colors.white : Colors.black,
                    size: 25),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
