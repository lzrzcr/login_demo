
import 'package:flutter/material.dart';
import 'package:login_demo/function/config/colors.dart';


const Color _fieldBgColor = KColor.GRAY_BG_COLOR;

class LZFieldContainer extends StatelessWidget {
  final Widget child;

  final Color? backgroundColor;//背景颜色

  final double? fieldH;

  const LZFieldContainer({
    Key? key,
    required this.child,
    this.backgroundColor = _fieldBgColor,
    // this.fieldW = 90,
    this.fieldH = 50,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(

      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),//输入框左边距离 20
      // width: size.width * 0.8,
      height: fieldH,
      decoration: BoxDecoration(
        color:backgroundColor,
        // color: Colors.red,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
