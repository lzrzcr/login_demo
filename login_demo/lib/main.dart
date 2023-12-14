import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:login_demo/function/components/btn/lz_round_btn.dart';
import 'package:login_demo/function/components/dialog/lz_toast.dart';
import 'package:login_demo/function/config/project_config.dart';
import 'package:login_demo/function/getx/lz_getx_binding.dart';
import 'package:login_demo/function/getx/lz_getx_controller.dart';
import 'package:login_demo/function/screen_fit/rpx_fit/size_fit.dart';
import 'package:login_demo/function/screen_fit/screenutil_fit/screen_fit.dart';
import 'package:login_demo/function/utils/lz_dialog_utils.dart';
import 'package:login_demo/project/home/home_page.dart';
import 'package:login_demo/project/login/login_page.dart';
import 'package:login_demo/routes/getx_pages.dart';

void main() async{

  // Add this line
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    //屏幕适配初始化
    LZSizeFit.initialize();

    //第三方屏幕适配初始化
    // ScreenFit.int(context);


  }

  @override
  void dispose() {
    _hideKeyboard();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,//去掉debug
      initialBinding: LZGetXBinding(),// GetX 绑定
      initialRoute: '/',
      getPages: GetXPages.pages,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          dialogBackgroundColor:Colors.white
      ),
      builder: (context, child) => Scaffold(
        // Global GestureDetector that will dismiss the keyboard
        body: GestureDetector(//隐藏键盘
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _hideKeyboard();
          },
          child: child,
        ),
      ),

      home: const LoginPage(),

      // home: const HomePage(),



    );
  }

  void _hideKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();

      Get.find<LZGetXController>().changeShow(false);

    }
  }



}











