import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_1/utils/SharedPrefutil.dart';

import '../../main.dart';
import '../../router/routes.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final TextEditingController _nameInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  return  GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("配置"),
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                Expanded(
                    child: Center(
                  child: _buildInputFrom(),
                )),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );

    // return CupertinoPageScaffold(
    //   navigationBar: const CupertinoNavigationBar(
    //     middle: Text("配置"),
    //   ),
    //   child: SafeArea(
    //     child: Container(
    //       padding: const EdgeInsets.all(50),
    //       child: Column(
    //         children: [
    //           Expanded(
    //               child: Center(
    //             child: _buildInputFrom(),
    //           )),
    //           _buildSubmitButton(),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget _buildInputFrom() {
    return CupertinoTextField(
      placeholder: "请输入",
      padding: const EdgeInsets.all(10),
      keyboardType: TextInputType.name,
      controller: _nameInputController,
    );
  }

  Widget _buildSubmitButton() {
    return CupertinoButton(
      child: const Text("继续"),
      onPressed: () {
        _submit();
      },
    );
  }

  void _submit() async {
    String name = _nameInputController.text;
    if (name.isEmpty) {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text("提示"),
              content: const Text("请输入"),
              actions: [
                CupertinoDialogAction(
                  child: const Text("确定"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }else {
      SharedPrefUtil.instance.setString("name", name);
      router.navigateTo(context, Routes.index, clearStack: true);
    }
  }

  void dispose() {
    _nameInputController.dispose();
    super.dispose();
  }
}
