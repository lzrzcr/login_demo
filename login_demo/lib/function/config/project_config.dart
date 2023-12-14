

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_demo/function/config/lz_screen_utils.dart';
import 'package:login_demo/function/screen_fit/rpx_fit/size_extension.dart';
import 'package:login_demo/function/screen_fit/screenutil_fit/screen_fit.dart';

/**
 * @ClassName: project_config.dart
 * @Description: 项目的一些全局配置项，数据持久化使用的key
 */

export 'strings.dart';
export 'colors.dart';


/* 保存本地的用户model */
const userInfo = 'userInfo';

/* 保存密码 */
const rememberKey = 'rememberKey';

/* 登录的账号 */
const loginAccount = 'loginAccount';

bool isIphoneX = LZScreenUtils.screenHeight > 800?true:false;

double globalH =  48.w;



