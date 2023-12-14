
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:login_demo/function/screen_fit/rpx_fit/size_extension.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

const Color _bgColor = Colors.black87;
const Color _contentColor = Colors.white;
const double _textFontSize = 15.0;
const double _radius = 10.0;
const double _imgWH = 30.0;
const int _time = 2;

enum _Orientation { horizontal, vertical }

class LZToast {


  /// 文字toast
  static Future showText(
      BuildContext context, {
        required String msg,
        int closeTime = _time,
      }) {
    return _showToast(
        context: context,
        msg: msg,
        stopEvent: true,
        closeTime: closeTime
    );
  }

  /// 成功toast
  static Future showSuccess(
      BuildContext context, {
        required String msg,
        int closeTime = _time,
      }) {
    Widget img =
    Icon(Icons.check_circle_outline, size: _imgWH, color: _contentColor);
    return _showToast(
        context: context,
        msg: msg,
        image: img,
        stopEvent: true,
        closeTime: closeTime);
  }

  /// 失败toast
  static Future showError(
      BuildContext context, {
        required String msg,
        int closeTime = _time,
      }) {
    Widget img = Icon(Icons.highlight_off, size: _imgWH, color: _contentColor);
    return _showToast(
        context: context,
        msg: msg,
        image: img,
        stopEvent: true,

        closeTime: closeTime);
  }

  /// 警告toast
  static Future showInfo(
      BuildContext context, {
        required String msg,
        int closeTime = _time,
      }) {
    Widget img = Icon(Icons.info_outline, size: _imgWH, color: _contentColor);
    return _showToast(
        context: context,
        msg: msg,
        image: img,
        stopEvent: true,
        closeTime: closeTime);
  }

  /// 自定义图文toast
  static Future showImageText(
      BuildContext context, {
        required String msg,
        required Widget image,
        int closeTime = _time,
      }) {
    return _showToast(
        context: context,
        msg: msg,
        image: image,
        stopEvent: true,
        closeTime: closeTime);
  }

  /// 水平自定义图文toast
  static Future showHorizontalImageText(
      BuildContext context, {
        required String msg,
        required Widget image,
        int closeTime = _time,
      }) {
    return _showToast(
        context: context,
        msg: msg,
        image: image,
        stopEvent: true,
        orientation: _Orientation.horizontal,
        closeTime: closeTime);
  }

  /// 加载中toast
  static _HideCallback showLoadingText(
      BuildContext context, {
        String msg = "加载中...",
      }) {
    return _showJhToast(
        context: context,
        msg: msg,
        isLoading: true,
        stopEvent: true,
        orientation: _Orientation.vertical);
  }

  /// 水平加载中toast
  static _HideCallback showHorizontalLoadingText(
      BuildContext context, {
        String msg = "加载中...",
      }) {
    return _showJhToast(
        context: context,
        msg: msg,
        isLoading: true,
        stopEvent: true,
        orientation: _Orientation.horizontal);
  }

  /// iOS加载中toast
  static _HideCallback showIOSLoadingText(
      BuildContext context, {
        String msg = "加载中...",
      }) {
    Widget img = Image.asset("assets/images/loading.gif",
        width: _imgWH, package: "jhtoast");
    return _showJhToast(
        context: context,
        msg: msg,
        image: img,
        isLoading: false,
        isNoText: true,
        stopEvent: true);
  }


  /// 没有文字

  static _HideCallback showLoading(
      BuildContext context, {
        String msg = "加载中...",
      }) {
    Widget img = Image.asset("assets/images/loading.gif",
        width: _imgWH, package: "jhtoast");
    return _showJhToast(
        context: context,
        msg: msg,
        // image: img,
        isLoading: true,
        isNoText: true,
        stopEvent: true);
  }



  /// iOS加载中toast
  static _HideCallback showIosLoading(
      BuildContext context, {
        String msg = "加载中...",
      }) {
    Widget img = Image.asset("assets/images/loading.gif",
        width: _imgWH, package: "jhtoast");
    return _showJhToast(
        context: context,
        msg: msg,
        image: img,
        isLoading: false,
        isNoText: true,
        stopEvent: true);
  }



}

/// _showToast
Future _showToast(
    {required BuildContext context,
      String msg: "",
      stopEvent = false,
      Widget? image,
      int closeTime: _time,
      _Orientation orientation = _Orientation.vertical}) {
  msg = msg;
  var hide = _showJhToast(
      context: context,
      msg: msg,
      isLoading: false,
      stopEvent: stopEvent,
      image: image,
      isNoText: false,
      orientation: orientation);
  return Future.delayed(Duration(seconds: closeTime), () {
    hide();
  });
}

typedef _HideCallback = Future Function();

/// JhToastWidget
class JhToastWidget extends StatelessWidget {

  final bool stopEvent;
  final Widget? image;
  final String msg;
  final bool isLoading;
  final bool? isNoText;
  final _Orientation orientation;

  const JhToastWidget({
    Key? key,
    required this.stopEvent,
    this.image,
    required this.msg,
    required this.isLoading,
    this.isNoText = false,
    required this.orientation,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {

    Widget? topW;
    bool isHidden;

    bool isNoText;

    // bool isNoText = this.isNoText!;

    isNoText = this.isNoText!;

    if (this.isLoading == true) {

      isHidden = false;
      topW = CircularProgressIndicator(
        strokeWidth: 3.0,
        valueColor: AlwaysStoppedAnimation<Color>(_contentColor),
      );

    } else {

      isHidden = image == null ? true : false;
      topW = image;
    }

    var widget = Material(
        color: Colors.transparent,
        child: Align(
          // alignment: Alignment.center,
          //   alignment: Alignment(0.0, 0.05), // 中间往上一点
            alignment: Alignment(0.0, -0.2), // 中间往上一点

            child: Container(
              margin: const EdgeInsets.all(30.0),
              width: 100,
              height: 100,
              // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0.px),
              decoration: BoxDecoration(
                color: _bgColor,
                // color: Colors.red,
                borderRadius: BorderRadius.circular(_radius),
              ),
              child: ClipRect(
                child: orientation == _Orientation.vertical
                    ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[

                    //图片开始
                    Offstage(
                      offstage: isHidden,
                      child: Container(
                        width: 45.0,
                        height: 45.0,
                        // color: Colors.red,
                        margin: EdgeInsets.only(bottom: 8.0),
                        padding: EdgeInsets.all(4.0),
//                            child: Icon(Icons.check_circle_outline, size: 30, color: Colors.white,),
                        child: topW,
                      ),
                    ),
                    //图片结束

                    //文字开始
                    Offstage(
                      offstage: isNoText,
                      child: Text(
                          msg,
                          style: TextStyle(
                              fontSize: _textFontSize,
                              color: _contentColor),
                          textAlign: TextAlign.center
                      ),
                    ),
                    //文字结束

                  ],
                )
                    : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    //图片开始
                    Offstage(
                      offstage: isHidden,
                      child: Container(
                        width: 36.0,
                        height: 36.0,
                        margin: EdgeInsets.only(right: 8.0),
                        padding: EdgeInsets.all(4.0),
                        child: topW,
                      ),
                    ),
                    //图片结束

                    //文字开始
                    Text(msg,
                        style: TextStyle(
                            fontSize: _textFontSize,
                            color: _contentColor),
                        textAlign: TextAlign.center),
                  ],
                  //文字结束

                ),
              ),
            )));
    return IgnorePointer(
      ignoring: !stopEvent,
      child: widget,
    );
  }
}

int backButtonIndex = 2;

/// _showJhToast
_HideCallback _showJhToast({
  required BuildContext context,
  required String msg,
  Widget? image,
  bool? isNoText,
  required bool isLoading,
  bool stopEvent = false,
  _Orientation orientation = _Orientation.vertical,
}) {

  Completer<VoidCallback> result = Completer<VoidCallback>();

  var backButtonName = 'LZToast$backButtonIndex';


  BackButtonInterceptor.add((bool stopDefaultButtonEvent, RouteInfo info) {
    result.future.then((hide) {
      hide();
    });
    return true;
  }, zIndex: backButtonIndex, name: backButtonName);
  backButtonIndex++;

  OverlayEntry? overlay = OverlayEntry(
      maintainState: true,
      builder: (_) => WillPopScope(
        onWillPop: () async {
          var hide = await result.future;
          hide();
          return false;
        },

        child: JhToastWidget(
          image: image,
          msg: msg,
          stopEvent: stopEvent,
          isLoading: isLoading,
          isNoText: isNoText,
          orientation: orientation,
        ),
      ));

  result.complete(() {
    if (overlay == null) {
      return;
    }
    overlay!.remove();
    overlay = null;
    BackButtonInterceptor.removeByName(backButtonName);
  });
  Overlay.of(context)?.insert(overlay!);
  return () async {
    var hide = await result.future;
    hide();
  };

}

