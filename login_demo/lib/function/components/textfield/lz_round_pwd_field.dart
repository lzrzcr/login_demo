import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:login_demo/function/components/btn/lz_inkwell.dart';
import 'package:login_demo/function/components/textfield/lz_field_container.dart';
import 'package:login_demo/function/config/colors.dart';
import 'package:login_demo/function/getx/lz_getx_controller.dart';
import 'package:login_demo/function/screen_fit/rpx_fit/size_extension.dart';


const Color _roundBgColor = KColor.GRAY_BG_COLOR;

//提示文字样式
TextStyle _hintTextStyle = TextStyle(fontSize: 15.0,color: Color(0xFFBBBBBB));

class LZRoundPwdField extends StatefulWidget {

  final String? text; //传入的文字
  final String? hintText;//提示文字
  final TextEditingController? controller;//控制器
  final TextInputType keyboardType;//键盘类型，即输入类型
  final FocusNode? focusNode;//焦点
  final Widget? rightWidget; //右侧widget ，默认隐藏
  final int maxLength; //最大长度，默认20
  final bool isPwd; //是否显示密码，默认否
  final bool isShowDeleteBtn;  //是否显示右侧删除按钮，默认不显示
  final List<TextInputFormatter>? inputFormatters;//输入校验
  final bool isDense; //是否紧凑显示，默认false
  final Color? backgroundColor;//背景颜色
  final double? inputH;//输入框高度
  final String? pwdOpen; //自定义密码图片路径 睁眼
  final String? pwdClose;//自定义密码图片路径 闭眼
  final double? textFont;
  final ValueChanged<String> valueChanged;


  const LZRoundPwdField({
    Key? key,
    this.text,//传入的文字
    this.hintText,//提示文字
    this.controller,//控制器
    this.keyboardType: TextInputType.text,//键盘类型，即输入类型
    this.focusNode,//焦点
    this.rightWidget,//右侧widget ，默认隐藏
    this.maxLength=20,//最大长度，默认20
    this.isPwd = false,//是否显示密码，默认否
    this.isShowDeleteBtn = false,//是否显示右侧删除按钮，默认不显示
    this.inputFormatters,//输入校验
    this.isDense:false,//是否紧凑显示，默认false
    this.backgroundColor = _roundBgColor,
    this.inputH = 50,//输入框高度
    this.pwdOpen,//自定义密码图片路径 睁眼
    this.pwdClose,//自定义密码图片路径 闭眼
    this.textFont=14,
    required this.valueChanged,

  }) : super(key: key);


  @override
  State<LZRoundPwdField> createState() => _LZRoundPwdFieldState();
}

class _LZRoundPwdFieldState extends State<LZRoundPwdField> {

  late TextEditingController _textController;//控制器
  late FocusNode _focusNode;//焦点
  late bool _isShowDelete ;//是否显示删除按钮

  bool? _isHideenPwdBtn; //是否隐藏 右侧密码明文切换按钮 ，密码样式才显示（isPwd =true），
  bool? _pwdShow; //控制密码 明文切换
  late Widget _pwdImg; //自定义密码图片


  @override
  void initState() {
    super.initState();

    //初始化
    _textController = widget.controller ?? TextEditingController();
    // _textController.text = widget.text!;
    _focusNode = widget.focusNode ?? FocusNode();
    _isHideenPwdBtn = !widget.isPwd;
    _pwdShow = widget.isPwd;//是否显示密码，默认不显示
    _isShowDelete = _focusNode.hasFocus && _textController.text.isNotEmpty;


    //添加监听-是否显示删除按钮
    _textController.addListener(() {
      setState(() {

        _isShowDelete = _textController.text.isNotEmpty &&_focusNode.hasFocus;


      });
    });

    _focusNode.addListener(() {
      setState(() {
        _isShowDelete = _textController.text.isNotEmpty &&_focusNode.hasFocus;
      });
    });


  }


  @override
  Widget build(BuildContext context) {




    return LZFieldContainer(

      backgroundColor: widget.backgroundColor,
      fieldH: widget.inputH,

      child: _buildBody(),

    );

  }



  //Body
  Widget _buildBody(){


    return Row(

      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [


        Container(
          width: 200,
          // height: 50,
          // color: Colors.red,
          child: _buildInput(),

        ),


        _buildRight(),


      ],


    );

  }



  //创建输入框
  Widget _buildInput(){


    return TextField(

      controller: _textController,//控制器
      focusNode: _focusNode,//焦点
      keyboardType: widget.keyboardType,//键盘类型
      cursorColor: Colors.black87,//光标颜色
      obscureText: !_pwdShow!,//明文、暗文
      style: TextStyle(color: Colors.black87, fontSize: 15),
      inputFormatters: widget.inputFormatters!=null ?widget.inputFormatters:[LengthLimitingTextInputFormatter(widget.maxLength)],//输入校验
      decoration: InputDecoration(//装饰 (边框、提示文字等)

        hintText:  widget.hintText,//输入提示
        hintStyle: _hintTextStyle,//输入提示文字的样式
        border: InputBorder.none,//取消下划线

      ),
      onTap: (){

        Get.find<LZGetXController>().changeShow(false);

      },
      onChanged: widget.valueChanged,
    );


  }


  //右边的控件
  Widget _buildRight(){

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [

        Offstage(
          offstage:!_isShowDelete,//true 表示隐藏
          child:_buildDeleteBtn(),

        ),

        SizedBox(width: 12,),

        _buildPwdBtn(),

       ]
    );



  }


  //密码显示与否按钮
  Widget _buildPwdBtn(){

    return LZInkWell(
        child: Image.asset(
          _pwdShow!?'assets/eye_open.png': 'assets/eye_close.png',
          fit: BoxFit.fill,
          width: 20,
          height: 20,
        ),

        onTap: (){

          setState(() {
            _pwdShow = !_pwdShow!;
          });

        }

    );


  }



  //删除按钮
  Widget _buildDeleteBtn(){

    return LZInkWell(
        child: Image.asset(
          'assets/delete.png',
          fit: BoxFit.fill,
          width: 16,
          height: 16,
        ),

        onTap: (){

          _textController.text = "";

        }

    );


  }




}
