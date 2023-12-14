
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

///键盘工具
class LZKeyboardUtil{


  //三方键盘配置
  static KeyboardActionsConfig getKeyboardConfig(
      BuildContext context, List<FocusNode> list) {
    return KeyboardActionsConfig(
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: List.generate(
          list.length,
              (i) => KeyboardActionsItem(
            focusNode: list[i],
            toolbarButtons: [
                  (node) {
                return GestureDetector(
                    onTap: () => node.unfocus(),
                    child: Stack(
                        alignment: Alignment.centerRight,
                        children: <Widget>[
                          Container(
                            color: Colors.transparent,
                            width: 100,
                          ),
                          Positioned(
                            right: 15,
                            child: Text("关闭"),
                          ),
                        ]));
              },
            ],
          )),
    );
  }


}