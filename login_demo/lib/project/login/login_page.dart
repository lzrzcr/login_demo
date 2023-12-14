

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:login_demo/function/components/btn/lz_border_btn.dart';
import 'package:login_demo/function/components/btn/lz_round_btn.dart';
import 'package:login_demo/function/components/dialog/lz_toast.dart';
import 'package:login_demo/function/components/list/user_list_view.dart';
import 'package:login_demo/function/components/textfield/lz_round_Input_field.dart';
import 'package:login_demo/function/components/textfield/lz_round_pwd_field.dart';
import 'package:login_demo/function/config/lz_screen_utils.dart';
import 'package:login_demo/function/config/project_config.dart';
import 'package:login_demo/function/getx/lz_getx_controller.dart';
import 'package:login_demo/function/screen_fit/rpx_fit/size_extension.dart';
import 'package:login_demo/function/screen_fit/screenutil_fit/screen_fit.dart';
import 'package:login_demo/function/utils/lz_dialog_utils.dart';
import 'package:login_demo/function/utils/shared_preference_utils.dart';
import 'package:login_demo/project/login/user.dart';
import 'package:login_demo/routes/getx_routes.dart';
import 'package:jhtoast/jhtoast.dart';




class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

 class _LoginPageState extends State<LoginPage> {

   late TextEditingController _userController;
   late TextEditingController _pwdController;

   late FocusNode _nameNode;
   late FocusNode _pwdNode;

   var _name = '';
   var _pwd = '';
   final List<User> _userList = []; //用户账号列表
   final List<User> _remembersList = []; //记录密码列表

   bool _isAgree = false;

   final GlobalKey _globalKey = GlobalKey(); //用来标记控件


   @override
   void initState() {
     super.initState();
     _userController = TextEditingController();
     _pwdController = TextEditingController();
     _nameNode =  FocusNode();
     _pwdNode = FocusNode();
     _getUserList();//获取保存的用户
     _getRemembersList();//获取记录密码的列表

   }


   @override
   void dispose() {
     // TODO: implement dispose
     super.dispose();
     print("login_page dispose");
     _nameNode.unfocus();
     _pwdNode.unfocus();
     _name = '';
     _pwd = '';

   }



   @override
  Widget build(BuildContext context) {

     //第三方屏幕适配初始化
     ScreenFit.int(context);

     return Scaffold(
      resizeToAvoidBottomInset: false,//防止键盘遮挡住控件
      backgroundColor: KColor.GRAY_BG_COLOR,
      body: _buildBody(),


    );
  }




     ///创建body
   Widget _buildBody(){

     return Stack(

       children: [

         //输入框等内容
         _buildContent(),

         //记住密码下拉框
         GetBuilder<LZGetXController>(builder: (data){

           // print('data.isShow ======== :  ${data.isShow}');

           return Positioned(
             left: 38.w,
             top: data.offset.dy + globalH + 10.w,
             child: data.isShow? _buildUserListView(data.rememberList):Container(),

           );

         }),

       ],

     );


   }

   ///创建内容
   Widget _buildContent(){

     return SingleChildScrollView(
       child: Padding(
         padding: EdgeInsets.all(10),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             SizedBox(height: 70.w),
             _logoImage(),//Logo
             SizedBox(height: 40),
             _userInput(), //用户输入框
             SizedBox(height: 10),
             _pwdInput(),//密码输入框
             SizedBox(height: 10),
             _buildRememberBtn(),//记住密码
             SizedBox(height: 80),
             _loginBtn(),//登录按钮
             SizedBox(height: 30),
             _registerBtn()//注册按钮

           ],

         ),

       ),
     );



   }



   ///Logo 图片
   Widget _logoImage(){

     return Center(
       child:
       Container(
         // color: Colors.red,
         child: Image.asset(
           width: 180.w,
           height: 100.w,
           "assets/logo.png",
         ),

       ),
     );

   }


   ///用户输入框
   Widget _userInput(){

     return Padding(padding: EdgeInsets.fromLTRB(25, 0, 25, 0), //左边加一个间距

       child: LZRoundInputField(
         key: _globalKey,
         inputH: globalH,//高度
         text: _name,
         hintText: '请输入用户名',//请输入手机或者邮箱号
         keyboardType:  TextInputType.name,//键盘类型
         controller: _userController,
         focusNode: _nameNode,
         backgroundColor: Colors.white,
         valueChanged: (value){

           _name = _userController.text;

           _filterUsers(_name);


         },
         tapCallBack: (){

           Get.find<LZGetXController>().getPosition(_globalKey);

           Get.find<LZGetXController>().changeShow(true);

           //获取记住密码列表
           _getRemembersList();


         },
         editingCompleteCallBack: (){

           Get.find<LZGetXController>().changeShow(false);

         },
         submittedCallBack: (value){

           Get.find<LZGetXController>().changeShow(false);


         },

       ),


     );

   }



   ///密码输入框
   Widget _pwdInput(){

     return Padding(padding: EdgeInsets.fromLTRB(25, 0, 25, 0), //左边加一个间距

         child: LZRoundPwdField(
           inputH: globalH,
           text: _pwd,
           hintText: '请输入密码',//请输入密码
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




   ///记住密码
   Widget _buildRememberBtn(){

     return Padding(
       padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
       child: Wrap(//自动换行

         alignment: WrapAlignment.start,//主轴方向上的对齐方式，默认为start。
         crossAxisAlignment:WrapCrossAlignment.center,//交叉轴（crossAxis）方向上的对齐方式。
         // spacing:5,
         children: [

           _agreeBtn(),

           SizedBox(width: 8,),

           Text(
             '记住密码',
             style: TextStyle(fontSize: 13),
           ),


         ],


       ),

     );


   }

   ///同意按钮
   Widget _agreeBtn(){


     return GetBuilder<LZGetXController>(builder: (data){

       return InkWell(

         child: Image.asset(
           data.isAgree?"assets/agree_selected.png":"assets/agree_normal.png",
           fit: BoxFit.fill,
           width: 21,
           height: 21,
         ),
         onTap: (){

           // print('agree 按钮点击');

           setState(() {

             _isAgree = !_isAgree;

           });


           //更新数据

           Get.find<LZGetXController>().changeAgree(_isAgree);


         },

       );


     });


   }



   ///登录按钮
   Widget _loginBtn(){

     return Padding(
       padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
       child:
       LZRoundButton(
           text: '登录',//登录
           btnH: globalH,
           textFont: 14,
           backgroundColor: Colors.black87,
           onPressed:(){

             _loginBtnClick();


           }
       ),
     );

   }



   ///注册按钮
   Widget _registerBtn(){

     return Padding(
       padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
       child:
       LZBorderButton(
           text: '注册',//登录
           btnH: globalH,
           textFont: 14,
           textColor: Colors.black87,
           backgroundColor: Colors.black87,
           onPressed:(){

             _registerBtnClick();


           }
       ),
     );

   }



   ///登录按钮点击
   _loginBtnClick() async {


     if(_userController.text.isEmpty){

       JhToast.showText(context, msg: '用户名为空，请输入用户名');


     }else if(_pwdController.text.isEmpty){

       JhToast.showText(context, msg: '密码为空，请输入密码');

       return;

     }else{

       //用户登录
       _userLogin();


     }


   }


   ///用户登录
   _userLogin() async {

     var hide =  LZToast.showLoading(context);

     // var hide =  JhToast.showIOSLoadingText(context,msg: '');

     if(_isAgree){//保存密码

       // print('agree 保存密码 11111111');

       //保存记住密码
       SharedPreferenceUtil.saveRememberUser(_userController.text, _pwdController.text);

       Get.find<LZGetXController>().changeShow(false);


     }

     // print('用户名 =======:${_userController.text}');
     // print('密码 =======:${_userController.text}');

     //判断账号是否存在
     if (_userList.contains(User(_userController.text, _pwdController.text))) {//有账号

       Future.delayed(Duration(seconds: 1), () {

         hide();

         //跳转到主页
         _pushHomePage();

         //保存登录账号
         SharedPreferenceUtil.putString(loginAccount, _userController.text);


       });


     }else{

       hide();

       JhToast.showError(context, msg: '账号或者密码错误');

     }


   }



   ///跳转到主页
   _pushHomePage() async {


     Get.toNamed(GetXRoutes.home)?.then((value){


       _pwdController.text = '';

       _getUserList();



     });



   }



   ///注册按钮点击
   _registerBtnClick() async {

     Get.toNamed(GetXRoutes.register)?.then((value){


       _pwdController.text = '';

        _getUserList();


     });



   }


   //创建用户列表
   Widget _buildUserListView(List userList){

     if(userList.isEmpty){

       return Container();

     }else{

       return Container(

         decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: const BorderRadius.only(
               bottomLeft: Radius.circular(2), bottomRight: Radius.circular(2)),
           boxShadow: [
             BoxShadow(
               color: Colors.grey.withOpacity(0.2),
               spreadRadius: 2,
               blurRadius: 3,
             ),
           ],


         ),
         width: LZScreenUtils.screenWidth - 78.px,
         // height: 38.px,
         height: 145.px,

         child: UserListView(
           dataList: userList,
           clickCallBack: (index){//cell点击

             User user = userList[index];
             _userController.text =  user.username;
             _pwdController.text = user.password;
             Get.find<LZGetXController>().changeShow(false);

             //回收键盘
             FocusScope.of(context).requestFocus(FocusNode());

           },
           deleteCallBack: (index){//删除保存的账号

             User user = userList[index];
             userList.remove(user);
             //删除记录的用户
             // _showLogoutTips(user);

             _delRememberUser(user);


           },

         ),

       );


     }


   }


   //显示弹窗
   void _showLogoutTips(User user){


     LZDialogUtil.showCenterDialog(
       context,
       CupertinoAlertDialog(
         title:  Text('提示'),//提示
         content:  Text('您确定退出登录吗？'.tr),//您确定退出登录吗？
         actions: [
           TextButton(
             child:  Text('取消'),//取消
             onPressed: () {
               Navigator.pop(context);
             },
           ),
           TextButton(
             child:  Text('确定'.tr),//确定
             onPressed: () {
               Navigator.pop(context, '确定');

               _delRememberUser(user);

             },
           ),

         ],
       ),

     );


   }



   //删除用户
   void _delRememberUser(User user) async{


     var hide =  LZToast.showLoading(context);

     SharedPreferenceUtil.delRememberUser(user);

     _pwdController.text = '';

     var remembersList = await SharedPreferenceUtil.getRememberUsers();

     print('读取记录密码列表 remembersList =======:${remembersList}');


     Future.delayed(Duration(seconds: 1), () {

         hide();

         LZToast.showSuccess(context, msg: '删除成功');

         if(remembersList.isEmpty){

           Get.find<LZGetXController>().changeShow(false);

         }


     });

     Get.find<LZGetXController>().changeRememberList(remembersList);


   }


   ///获取保存的用户
   void _getUserList() async {
     _userList.clear();
     _userList.addAll(await SharedPreferenceUtil.getUsers());

     //获取登录的用户
     String? userName = await  SharedPreferenceUtil.getString(loginAccount);

     _userController.text = userName??'';

     print('获取保存的用户 userName =======:${userName}');
     print('获取保存的用户 _userList =======:${_userList}');

   }



   ///获取记录密码的列表
   void _getRemembersList() async {

     var remembersList = await SharedPreferenceUtil.getRememberUsers();

     print('读取记录密码列表 remembersList =======:${remembersList}');


     Get.find<LZGetXController>().changeRememberList(remembersList);


   }



   ///筛选保存的用户
   void _filterUsers(String name) async {

     List<User> userList = await SharedPreferenceUtil.filterRememberUsers(name);

     Get.find<LZGetXController>().changeRememberList(userList);


   }




 }
