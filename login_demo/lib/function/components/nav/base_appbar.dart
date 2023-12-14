


import 'package:flutter/material.dart';
import 'package:login_demo/function/config/colors.dart';
import 'package:login_demo/function/screen_fit/rpx_fit/size_extension.dart';



const Color _navColor = KColor.BG_COLOR;
const Color _navbgColor = KColor.BG_COLOR;
const Color _titleColorWhite = Colors.white;
const Color _titleColorBlack = KColor.BLACK_TEXT_COLOR;
const double _titleFontSize = 18.0;//标题文字大小
const double _textFontSize = 16.0;
const double _itemSpace = 15.0; //右侧item内间距
const double _imgWH = 60.0; //右侧图片wh
const double _rightSpace = 5.0; //右侧item右间距
const Brightness _brightness = Brightness.light;

const Color appbarStartColor = Color(0xFF2683BE); //渐变开始色
const Color appbarEndColor = Color(0xFF34CABE); //渐变结束色



/*带返回箭头导航条*/
backAppBar(BuildContext context, String title,
    {
      String? rightText,
      String? rightImgPath,
      Color backgroundColor = _navbgColor,//背景颜色
      Brightness brightness = _brightness,
      Function? rightItemCallBack,
      Function? backCallBack}) {
  return baseAppBar(
    context,
    title,
    isBack: true,
    rightText: rightText,
    rightImgPath: rightImgPath,
    rightItemCallBack: rightItemCallBack,
    leftItemCallBack: backCallBack,
    backgroundColor: backgroundColor,
    brightness: brightness,
  );
}

/*带返回箭头的渐变导航条*/
backGradientAppBar(
    BuildContext context,
    String title, {
      String? rightText,
      String? rightImgPath,
      Function? rightItemCallBack,
      Function? backCallBack,
    }) {
  return gradientAppBar(
    context,
    title,
    isBack: true,
    rightText: rightText,
    rightImgPath: rightImgPath,
    rightItemCallBack: rightItemCallBack,
    leftItemCallBack: backCallBack,
  );
}

/*
* 渐变导航条
* */
gradientAppBar(
    BuildContext context,
    String title, {
      String? rightText,
      String? rightImgPath,
      Widget? leftItem: null,
      bool isBack: false,
      double elevation: 0,
      PreferredSizeWidget? bottom,
      Function? rightItemCallBack,
      Function? leftItemCallBack,
    }) {
  return PreferredSize(
    preferredSize: Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0)),
    child: Container(
      child: baseAppBar(
        context,
        title,
        rightText: rightText,
        rightImgPath: rightImgPath,
        leftItem: leftItem,
        isBack: isBack,
        backgroundColor: Colors.white.withOpacity(0),
        elevation: elevation,
        bottom: bottom,
        rightItemCallBack: rightItemCallBack,
        leftItemCallBack: leftItemCallBack,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            appbarStartColor,
            appbarEndColor,
          ],
        ),
      ),
    ),
  );
}



//baseAppBar
baseAppBar(
    BuildContext context,
    String title, {
      String? rightText,
      String? rightImgPath,
      Widget? leftItem: null,
      bool isBack: false,
      Color backgroundColor = _navbgColor,
      Brightness brightness = _brightness,
      double elevation: 0,
      PreferredSizeWidget? bottom,
      Function? rightItemCallBack,
      Function? leftItemCallBack,
    }) {
  Color _color = (backgroundColor == Colors.transparent ||
      backgroundColor == Colors.white ||
      backgroundColor == KColor.BG_COLOR)
      ? _titleColorBlack
      : _titleColorWhite;

  Widget rightItem = Text("");

  if (rightImgPath != null) {

    rightItem =IconButton(
      icon: Image.asset(
        rightImgPath,
        fit: BoxFit.contain,
        width: 40,
        height: 40,

        // color: Colors.red,
      ),
      // splashRadius: 1,

      iconSize: 100,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      onPressed:() {
        if (rightItemCallBack != null) {
          rightItemCallBack();


        }
      },
    );



  }
  return AppBar(//左边
    title:
    Text(title, style: TextStyle(fontSize: _titleFontSize, color: _color)),
    centerTitle: true,
    backgroundColor: backgroundColor,
    brightness: brightness,
    bottom: bottom,
    elevation: elevation,
    leading: isBack == false
        ? leftItem
        : IconButton(
      icon: Image.asset(//左边按钮
        "assets/back_nav.png",
        fit: BoxFit.cover,
        width: 20.px,
        height: 20.px,
        // color: Colors.red,
        //
      ),

      iconSize: 20,
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      onPressed: () {
        if (leftItemCallBack == null) {
          _popThis(context);
        } else {
          leftItemCallBack();
        }
      },
    ),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          rightItem,
          SizedBox(width: _rightSpace),
        ],
      ),
    ],
  );
}

void _popThis(BuildContext context) {
  if (Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }
}


