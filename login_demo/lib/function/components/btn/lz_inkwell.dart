
import 'package:flutter/material.dart';

typedef _InkWellCallBack = void Function();//按钮 点击回调

class LZInkWell extends StatelessWidget {

  final Widget child;

  final _InkWellCallBack onTap;//按钮 点击回调

  const LZInkWell({
    Key? key,
    required this.child,
    required this.onTap

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(

      highlightColor: Colors.transparent, // 透明色
      splashColor: Colors.transparent, // 透明色
      child: child,
      onTap: (){

        if(onTap != null){

          onTap();
        }


      },

    );
  }
}
