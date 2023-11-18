import 'package:flutter/cupertino.dart';
import 'package:study_1/pages/index/explore_calender/explore_calender.dart';

import 'explore_all/explore_all.dart';


class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() {
    return _IndexPageState();
  }
}

class _IndexPageState extends State<IndexPage> {
  int currentIndex = 0;
  var tabStyle = const EdgeInsets.only(left: 25, right: 25);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: _topNavbar(),
      child: Container(
          child:_switchWidgetPage()
      ),
    );
  }



  Map<Object, Widget> segmentedControlChildren() {
    return {
      0: Container(
        padding: tabStyle,
        child: const Text("浏览"),
      ),
      1: Container(
        padding: tabStyle,
        child: const Text("日历"),
      )
    };
  }

  ObstructingPreferredSizeWidget _topNavbar() {
    return CupertinoNavigationBar(
      middle: CupertinoSegmentedControl(
        children: segmentedControlChildren(),
        groupValue: currentIndex, onValueChanged: (Object value) {
        setState(() {
          currentIndex = value as int;
        });
      },
      ),
    );
  }

  Widget _switchWidgetPage() {
    switch (currentIndex) {
      case 0:
        return const ExploreAllPage();
      case 1:
        return const ExploreCalenderPage();
      default:
        return const ExploreAllPage();
    }
  }

}
