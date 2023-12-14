
import 'package:flutter/material.dart';
import 'package:login_demo/function/config/colors.dart';


const Color _roundBgColor = KColor.BTN_BG_COLOR;
class LZBorderButton extends StatelessWidget {

  final String text;
  final Color? textColor;
  final Color? backgroundColor;//背景颜色
  final double? btnW;
  final double? btnH;
  final double? textFont;
  final VoidCallback onPressed;

  const LZBorderButton({
    Key? key,
    this.text="",
    this.textColor = Colors.white,
    this.backgroundColor = _roundBgColor,
    this.btnW = 90.0,
    this.btnH = 40.0,
    this.textFont = 13.0,
    required this.onPressed,//点击
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Container(
      // width: btnW,
      height: btnH,
      decoration: BoxDecoration(
        // color: backgroundColor,
        borderRadius: BorderRadius.circular(28.0),
        //设置四周边框
        border: Border.all(width: 1, color: Colors.black87,),

      ),

      child: _buildBtn(),

    );


  }



  //创建按钮
  Widget _buildBtn(){

    return Row(

      children: [

        Expanded(
          child: TextButton(
            onPressed: onPressed,
            style: ButtonStyle(
              //设置水波纹颜色
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              //背景颜色
              // backgroundColor: MaterialStateProperty.all<Color>(KColor.BTN_BG_COLOR),

            ),

            child: Text(
              text,
              style: TextStyle(
                  fontSize:textFont,
                  color: textColor
              ),
            ),

          ),


        ),
      ],

    );


  }



}
