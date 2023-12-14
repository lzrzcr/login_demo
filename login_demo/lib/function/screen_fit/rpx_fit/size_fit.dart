import 'package:flutter/material.dart';
import 'dart:ui';

/*
*
* 屏幕适配
*
* */

class LZSizeFit{

  // 1.基本信息
  static double physicalWidth = 0;
  static double physicalHeight = 0;
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double dpr = 0;
  static double statusHeight = 0;

  static double rpx = 0;
  static double px = 0;

  static double scaleY = 0;

  static void initialize({double standardSize = 750, double standardHeight = 1334}) {
    // 1.手机的分辨率
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;
    print("分辨率: $physicalWidth - $physicalHeight");

    // 2.获取dpr
    dpr = window.devicePixelRatio;

    // 3.宽度和高度
    screenWidth = physicalWidth / dpr;
    screenHeight = physicalHeight / dpr;


    print("屏幕width:$screenWidth height:$screenHeight");


    // 4.状态栏高度
    statusHeight = window.padding.top / dpr;

    // 5.计算rpx的大小
    //计算公式：实际尺寸 = UI尺寸 * 设备宽度/设计图宽度
    //1px方案 : 1px = 1 / 设备像素比

    rpx = screenWidth / standardSize;
    px = screenWidth / standardSize * 2;
    scaleY = screenHeight / standardHeight * 2;


  }

  // 按照rxp来设置
  static double setRpx(double size) {
    return rpx * size;
  }

  // 按照像素来设置
  static double setPx(double size) {
    return px * size;
  }

  static double setScaleY(double size) {
    return scaleY * size;
  }



}



