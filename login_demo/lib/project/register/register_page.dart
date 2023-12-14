
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jhtoast/jhtoast.dart';
import 'package:login_demo/function/components/btn/lz_round_btn.dart';
import 'package:login_demo/function/components/dialog/lz_toast.dart';
import 'package:login_demo/function/components/nav/base_appbar.dart';
import 'package:login_demo/function/components/textfield/lz_round_Input_field.dart';
import 'package:login_demo/function/components/textfield/lz_round_pwd_field.dart';
import 'package:login_demo/function/config/project_config.dart';
import 'package:login_demo/function/getx/lz_getx_controller.dart';
import 'package:login_demo/function/screen_fit/rpx_fit/size_extension.dart';
import 'package:login_demo/function/utils/shared_preference_utils.dart';
import 'package:login_demo/project/login/user.dart';
import 'package:login_demo/routes/getx_routes.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {


  late TextEditingController _userController;
  late TextEditingController _pwdController;
  late TextEditingController _repeatPwdController;

  late FocusNode _nameNode;
  late FocusNode _pwdNode;
  late FocusNode _repeatPwdNode;

  var _name = '';
  var _pwd = '';
  var _repeatPwd = '';

  final List<User> _getUserList = []; //用户账号


  @override
  void initState() {
    super.initState();
    _userController = TextEditingController();
    _pwdController = TextEditingController();
    _repeatPwdController = TextEditingController();

    _nameNode =  FocusNode();
    _pwdNode = FocusNode();
    _repeatPwdNode = FocusNode();

    _getRegisterList();//获取用户列表


  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("login_page dispose");
    _nameNode.unfocus();
    _pwdNode.unfocus();
    _repeatPwdNode.unfocus();
    _getUserList.clear();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:backAppBar(context, '账号注册'),
      backgroundColor: KColor.GRAY_BG_COLOR,
      resizeToAvoidBottomInset: false,//防止键盘遮挡住控件
      body: _buildBody(),
    );
  }





  Widget _buildBody(){


    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 35),
            _userInput(), //用户输入框
            SizedBox(height: 16.0),
            _pwdInput(),//密码输入框
            SizedBox(height: 16.0),
            _repeatPwdInput(),
            SizedBox(height: 100.0),
            _registerBtn(),//注册按钮


          ],

        ),

      ),
    );



  }




  //用户输入框
  Widget _userInput(){

    return Padding(padding:  EdgeInsets.fromLTRB(25, 0, 25, 0), //左边加一个间距

      child: LZRoundInputField(
        inputH: globalH,//高度
        text: _name,
        hintText: '请输入用户名',
        keyboardType:  TextInputType.name,//键盘类型
        controller: _userController,
        focusNode: _nameNode,
        backgroundColor: Colors.white,
        // backgroundColor: KColor.GRAY_BG_COLOR,
        // backgroundColor: Colors.red,
        valueChanged: (value){

          _name = _userController.text;

          // print('用户输入框的内容  $_name');

          setState(() {//更新状态

          });

        },


      ),


    );

  }



  //密码输入框
  Widget _pwdInput(){

    return Padding(padding:  EdgeInsets.fromLTRB(25, 0, 25, 0), //左边加一个间距

      child: LZRoundPwdField(
        hintText: '请输入密码',
        inputH: globalH,
        controller: _pwdController,
        focusNode: _pwdNode,
        backgroundColor: Colors.white,
        valueChanged: (value){

          _pwd = _pwdController.text;

          // print('密码输入框的内容  $_pwd');

        },

      ),

    );


  }



  //重复密码输入框
  Widget _repeatPwdInput(){

    return Padding(padding: EdgeInsets.fromLTRB(25, 0, 25, 0), //左边加一个间距

      child: LZRoundPwdField(
        hintText: '请再次输入密码',
        inputH: globalH,
        controller: _repeatPwdController,
        focusNode: _repeatPwdNode,
        backgroundColor: Colors.white,
        valueChanged: (value){

          _repeatPwd = _repeatPwdController.text;

          // print('再次密码输入框的内容  $_repeatPwd');

        },

      ),

    );



  }





  //注册按钮
  Widget _registerBtn(){

    return Padding(
      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
      child:
      LZRoundButton(
          text: '注册',//登录
          btnH: globalH,
          textFont: 14,
          backgroundColor: Colors.black87,
          onPressed:(){


            _btnClick();


          }
      ),
    );

  }





  //登录按钮点击
  _btnClick() async {

    _name = _userController.text;
    _pwd = _pwdController.text;
    _repeatPwd = _repeatPwdController.text;

    if(_name.isEmpty){

      JhToast.showText(context, msg: '用户名为空，请输入用户名');

    }else if(_pwd.isEmpty){

      JhToast.showText(context, msg: '密码为空，请输入密码'.tr);

      return;

    }else if(_repeatPwd.isEmpty){

      JhToast.showText(context, msg: '密码为空，请输入密码'.tr);

      return;

    }else if(_pwd != _repeatPwd){

      JhToast.showText(context, msg: '两次输入的密码不一致'.tr);

      return;

    }else{


      _signUp();


    }



  }





  ///注册账号
  _signUp() async {

    var hide =  LZToast.showLoading(context);

    Future.delayed(Duration(seconds: 1), () {

      hide();

      //判断账号是否存在
      for(User user in _getUserList){//for 循环

        if (user.username == _name) {

          JhToast.showError(context, msg: '账号已存在');

          return;

        }

      }

      //保存注册用户名
      SharedPreferenceUtil.saveUser(User(_name, _pwd));
      SharedPreferenceUtil.addNoRepeat(_getUserList, User(_name, _pwd));

      LZToast.showSuccess(context, msg: '注册成功');

      Get.back(result: '1');


    });



  }




  ///获取注册的用户
  void _getRegisterList() async {
    _getUserList.clear();
    _getUserList.addAll(await SharedPreferenceUtil.getUsers());
    print('读取用户列表 =======:${_getUserList}');

  }




}





