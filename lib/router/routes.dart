import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import 'package:study_1/pages/index/index.dart';
import 'package:study_1/pages/home/index.dart';
import 'package:study_1/pages/config/index.dart';
import 'package:study_1/pages/write/index.dart';

// 这是一个 Handler 类型的函数，用于定义路由处理函数
var indexHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
        const IndexPage());

var homeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
        const HomePage());

var configHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
        const ConfigPage());

var writeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) =>
        const WritePage());

class Routes {
  static String index = "/";
  static String home = "/home";
  static String config = "/config";
  static String write = "/write";

  static void configureRoutes(FluroRouter router) {
    router.define(index, handler: indexHandler);
    router.define(home, handler: homeHandler);
    router.define(config, handler: configHandler);
    router.define(write, handler: writeHandler);
    router.notFoundHandler = homeHandler;
  }
}
