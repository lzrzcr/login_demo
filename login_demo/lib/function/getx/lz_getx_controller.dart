

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_demo/function/screen_fit/rpx_fit/size_extension.dart';
import 'package:login_demo/project/login/user.dart';


class LZGetXController extends GetxController {


  bool isAgree = false;//是否同意
  bool isShow = false;//是否显示
  List<User> userList = [];//用户列表
  List<User> rememberList = [];//记录密码用户列表

  // left: 40.px,
  // top: 380,
  Offset offset = new Offset(40.px, 380.px);

  ///改变状态
  void changeShow(bool value){

    // print('传递的值 value ======== :  $value');

    isShow = value;
    update();

  }


  ///改变状态
  void changeAgree(bool value){

    isAgree = value;
    update();
  }


  ///改变用户列表
  void changeUserList(List<User> list) {

    userList = list;
    update();

  }

  ///改变注册列表
  void changeRememberList(List<User> list) {

    rememberList = list;
    update();

  }



  getPosition(GlobalKey key) {

    RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    var position =  renderBox?.localToGlobal(Offset.zero); //组件坐标
    offset = position!;

    // print('组件 y ======== :  ${offset.dy}');

    update();
  }






}
