import 'package:flutter/material.dart';
import 'package:study_1/utils/request.dart';

void main() {
  addInterceptors(); // 添加拦截器

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, // 去掉右上角的debug标签
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List goodsList = [
    {
      "name": '苹果',
      "isSelect": false,
      "isAll": false,
    },
    {
      "name": '香蕉',
      "isSelect": false,
      "isAll": false,
    },
    {
      "name": '梨子',
      "isSelect": false,
      "isAll": false,
    },
    {
      "name": '全部',
      "isSelect": false,
      "isAll": true,
    }
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void changeSelect(int index) {
    print(index);
    var current =goodsList[index];
    if (current['isAll']) {
      var selectLength = goodsList.where((element) => element['isSelect']);
      if (selectLength.length == goodsList.length ) {
        goodsList.forEach((element) {
          element['isSelect'] = false;
        });
      } else {
        goodsList.forEach((element) {
          element['isSelect'] = true;
        });
      }
      
    } else {
      current['isSelect'] = !current['isSelect'];
      if (goodsList.every((element) => element['isSelect'] == true)) {
        goodsList[goodsList.length - 1]['isSelect'] = true;
      } else {
        goodsList[goodsList.length - 1]['isSelect'] = false;
      }
    }
    setState(() {
      goodsList = goodsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('请选择想要吃的食物',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center),
            goods(goodsList, onChange: changeSelect),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget goods(List goodsList, {required Function onChange}) {
  return ListView.builder(
    itemCount: goodsList.length,
    shrinkWrap: true,
    itemBuilder: (BuildContext context, int index) {
      return Row(
        children: [
          Checkbox(
            value: goodsList[index]['isSelect'],
            onChanged: (value) {
              print(index);
              onChange(index);
            },
          ),
          Text(goodsList[index]['name']),
        ],
      );
    },
  );
}
