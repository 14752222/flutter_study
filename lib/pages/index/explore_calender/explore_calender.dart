import 'package:flutter/material.dart';

class ExploreCalenderPage extends StatefulWidget {
  const ExploreCalenderPage({super.key});

  @override
  State<ExploreCalenderPage> createState() => _ExploreCalenderPageState();
}

class _ExploreCalenderPageState extends State<ExploreCalenderPage> {
  @override
  Widget build(BuildContext context) {
    return const  Center(child: Text('按日期筛选日记列表'));
  }
}
