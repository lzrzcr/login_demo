
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_demo/function/components/btn/lz_round_btn.dart';
import 'package:login_demo/function/components/dialog/lz_toast.dart';
import 'package:login_demo/function/components/nav/base_appbar.dart';
import 'package:login_demo/function/config/project_config.dart';
import 'package:login_demo/function/screen_fit/rpx_fit/size_extension.dart';
import 'package:login_demo/function/utils/lz_dialog_utils.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: baseAppBar(context, '主页',leftItem: null),
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          '主页',
          style: TextStyle(
            fontSize: 18,
            color: KColor.BLACK_TEXT_COLOR,
          ),

        ),
      ),
      backgroundColor: KColor.GRAY_BG_COLOR,
      resizeToAvoidBottomInset: false, //防止键盘遮挡住控件
      body: _buildBody(),
    );


  }



  ///创建body
  Widget _buildBody(){

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

      child: Center(

        child:Column(

          mainAxisAlignment: MainAxisAlignment.start,

          children: [

            _buildImage(),

            SizedBox(height: 120,),

            _customBtn(),

          ],

        ),


      ),


    );


  }



  //上边图片
  Widget _buildImage(){

    return Image.asset(
      "assets/haibao.png",
      fit: BoxFit.fill,
      // width: 100.px,
      height: 200,

      // width: 230.px,
      // height: 220,

    );

  }



  //按钮
  Widget _customBtn(){

    return Padding(
      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
      child:
      LZRoundButton(
          text: '退出登录',//登录
          btnH: globalH,
          textFont: 14,
          backgroundColor: Colors.black87,
          onPressed:(){

            _btnClick();


          }
      ),
    );

  }



  //按钮点击
  _btnClick() async {

    _showLogoutTips();


  }


  //显示弹窗
  void _showLogoutTips(){


    LZDialogUtil.showCenterDialog(
      context,
      CupertinoAlertDialog(
        title:  Text('提示'),//提示
        content:  Text('您确定退出登录吗？'),//您确定退出登录吗？
        actions: [
          TextButton(
            child:  Text('取消'),//取消
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child:  Text('确定'),//确定
            onPressed: () {
              Navigator.pop(context, '确定');

              _logoutClick();

            },
          ),

        ],
      ),

    );


  }



  //退出登录点击
  void _logoutClick() {

    var hide =  LZToast.showLoading(context);


    Future.delayed(Duration(seconds: 1), () {

      Get.back(result: '1');

      // Get.offAll( LoginPage());

      hide();


    });


  }



}
