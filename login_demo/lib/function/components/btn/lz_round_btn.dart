 import 'package:flutter/material.dart';
import 'package:login_demo/function/config/colors.dart';



 const Color _roundBgColor = KColor.BTN_BG_COLOR;

class LZRoundButton extends StatelessWidget {


  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final double? btnW;
  final double? btnH;
  final double? textFont;
  final bool isAble;
  final VoidCallback onPressed;

  const LZRoundButton({
    Key? key,
    required this.text,
    this.textColor = Colors.white,
    this.backgroundColor = _roundBgColor,
    this.btnW = 90.0,
    this.btnH = 45.0,
    this.textFont = 13.0,
    this.isAble = true,
    required this.onPressed,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return  Container(
      // width: btnW,
      height: btnH,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(28.0),
        //设置四周边框
        // border: new Border.all(width: 1, color: KColor.BTN_BG_COLOR,),

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
                  fontSize: textFont,
                  color: Colors.white
              ),
            ),

          ),


        ),
      ],

    );


  }


}

