// ignore_for_file: use_build_context_synchronously
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:study_1/database/Db.dart';
import 'package:study_1/pages/index/index.dart';
import 'package:study_1/router/routes.dart';
import 'package:study_1/store/write_store.dart';
import 'package:study_1/utils/SharedPrefutil.dart';
import 'package:study_1/utils/request.dart';

final router = FluroRouter();

void main() {
  addInterceptors(); // 添加拦截器
  Routes.configureRoutes(router); // 配置路由
  var _ = Db(); // 初始化数据库

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      onGenerateRoute: router.generator,
      debugShowCheckedModeBanner: false,
      home: const Diary(),
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('zh', 'CH')],
      locale: const Locale('zh', 'CN'),
    );
  }
}

class Diary extends StatefulWidget {
  const Diary({super.key});

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  String? username = "";

  @override
  void initState() {
    super.initState();
    // 监听渲染事件，在渲染完成后跳转到AppConfig页面
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jumpToAppConfig();
    });
  }

  // 渲染页面

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialBinding: BindingsBuilder(() {
        Get.put(WriteController());
      }),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IndexPage(),
    );
  }

  // 跳转到AppConfig页面
  void _jumpToAppConfig() async {
    // 从SharedPrefUtil中获取用户名
    var username = await SharedPrefUtil.instance.getString("username");
    // 如果用户名为空，则跳转到config页面
    if (username == null) {
      router.navigateTo(context, Routes.config, clearStack: true);
    } else {
      // 否则弹出提示框
      showCupertinoDialog(
          context: context,
          builder: (context) {
            // 返回一个CupertinoAlertDialog，标题为"欢迎回来"，内容为username，actions中有一个CupertinoDialogAction，child为"确定"，onPressed为弹出Navigator.of(context).pop()
            return CupertinoAlertDialog(
              title: const Text("欢迎回来"),
              content: Text(username),
              actions: [
                CupertinoDialogAction(
                  child: const Text("确定"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }
}
