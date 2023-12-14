
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ScreenFit{


  static int(BuildContext context) {


    //设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
     ScreenUtil.init(
       context,
       designSize: const Size(375, 667),
       splitScreenMode: true,

     );




  }



  static height(double value) {
    return ScreenUtil().setHeight(value);
  }

  static width(double value) {
    return ScreenUtil().setWidth(value);
  }

  static getScreenHeight() {
    return ScreenUtil().screenWidth;
  }

  static getScreenWidth() {
    return ScreenUtil().screenWidth;
  }
  
  
}