
import 'package:flutter/material.dart';


class LZDialogUtil {


  //显示底部弹窗
  static void showBottomDialog(BuildContext context, Widget widget, {bool isDismiss = true}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismiss,
      //设置圆角`
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      // 抗锯齿
      clipBehavior: Clip.antiAlias,
      builder: (ctx) {
        return widget;
      },
    );
  }


  //显示中间弹窗
  static void showCenterDialog(BuildContext context, Widget widget, {bool isDismiss = true}) {

    showDialog(
      context: context,
      barrierDismissible: isDismiss, //点击遮罩不关闭对话框
      builder: (ctx) {
        return widget;
      },
    );
  }


  //返回上一级
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }


  //push到下一级
  static Future push(BuildContext context, Widget widget) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }


}