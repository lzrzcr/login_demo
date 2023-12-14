import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_demo/function/components/btn/lz_inkwell.dart';
import 'package:login_demo/function/components/textfield/lz_field_container.dart';
import 'package:login_demo/function/config/colors.dart';
import 'package:login_demo/function/screen_fit/rpx_fit/size_extension.dart';

const Color _roundBgColor = KColor.GRAY_BG_COLOR;

//提示文字样式
TextStyle _hintTextStyle =
    TextStyle(fontSize: 15.0, color: Color(0xFFBBBBBB));
typedef _onTapCallBack = void Function();
typedef _onEditingCompleteCallBack = void Function();
typedef _onSubmittedCallBack = void Function(String);

class LZRoundInputField extends StatefulWidget {
  final String? text; //传入的文字
  final String? hintText; //提示文字
  final TextEditingController? controller; //控制器
  final TextInputType keyboardType; //键盘类型，即输入类型
  final FocusNode? focusNode; //焦点
  final Widget? rightWidget; //右侧widget ，默认隐藏
  final int maxLength; //最大长度，默认20
  final bool isShowDeleteBtn; //是否显示右侧删除按钮，默认不显示
  final List<TextInputFormatter>? inputFormatters; //输入校验
  final bool isDense; //是否紧凑显示，默认false
  final Color? backgroundColor; //背景颜色
  final double? inputH; //输入框高度
  final double? textFont;
  final ValueChanged<String> valueChanged;
  final _onTapCallBack? tapCallBack;
  final _onEditingCompleteCallBack? editingCompleteCallBack;
  final _onSubmittedCallBack? submittedCallBack;

  const LZRoundInputField({
    Key? key,
    this.text = '', //传入的文字
    this.hintText, //提示文字
    this.controller, //控制器
    this.keyboardType: TextInputType.text, //键盘类型，即输入类型
    this.focusNode, //焦点
    this.rightWidget, //右侧widget ，默认隐藏
    this.maxLength: 50, //最大长度，默认20
    this.isShowDeleteBtn = false, //是否显示右侧删除按钮，默认不显示
    this.inputFormatters, //输入校验
    this.isDense: false, //是否紧凑显示，默认false
    this.backgroundColor = _roundBgColor, //背景颜色
    // this.inputW = 90,
    this.inputH = 50, //输入框高度
    this.textFont = 15,
    required this.valueChanged,
    this.tapCallBack,
    this.editingCompleteCallBack,
    this.submittedCallBack,
  }) : super(key: key);

  @override
  State<LZRoundInputField> createState() => _LZRoundInputFieldState();
}

class _LZRoundInputFieldState extends State<LZRoundInputField> {
  late TextEditingController _textController; //控制器
  late FocusNode _focusNode; //焦点
  late bool _isShowDelete; //是否显示删除按钮

  @override
  void initState() {
    super.initState();

    //初始化
    _textController = widget.controller ?? TextEditingController();
    _textController.text = widget.text ?? '';
    _focusNode = widget.focusNode ?? FocusNode();
    _isShowDelete = _focusNode.hasFocus && _textController.text.isNotEmpty;

    //添加监听-是否显示删除按钮
    _textController.addListener(() {
      setState(() {
        _isShowDelete = _textController.text.isNotEmpty && _focusNode.hasFocus;
      });
    });

    _focusNode.addListener(() {
      setState(() {
        _isShowDelete = _textController.text.isNotEmpty && _focusNode.hasFocus;
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
  Widget _buildBody() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 230,
          // height: 50,
          // color: Colors.red,
          child: _buildInput(),
        ),
        _buildRight(),
      ],
    );
  }

  //创建输入框
  Widget _buildInput() {
    return TextField(
      controller: _textController,
      //控制器
      focusNode: _focusNode,
      //焦点
      keyboardType: widget.keyboardType,
      //键盘类型
      cursorColor: Colors.black87,
      //光标颜色
      style: TextStyle(color: Colors.black87, fontSize: 15),
      inputFormatters: widget.inputFormatters != null
          ? widget.inputFormatters
          : [LengthLimitingTextInputFormatter(widget.maxLength)],
      //输入校验
      decoration: InputDecoration(
        //装饰 (边框、提示文字等)
        hintText: widget.hintText, //输入提示
        hintStyle: _hintTextStyle, //输入提示文字的样式
        border: InputBorder.none, //取消下划线
        // fillColor: Colors.grey, // 输入框背景色为灰色
        // filled: true,
      ),

      onChanged: widget.valueChanged,
      onTap: () {
        if (widget.tapCallBack != null) {
          widget.tapCallBack!();
        }
      },

      onEditingComplete: () {

        if (widget.editingCompleteCallBack != null) {
          widget.editingCompleteCallBack!();
        }

      },
      onSubmitted: (value) {

        if (widget.submittedCallBack != null) {
          widget.submittedCallBack!(value);
        }

      },
    );
  }

  //右边的控件
  Widget _buildRight() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Offstage(
          offstage: !_isShowDelete, //true 表示隐藏

          child: _buildDeleteBtn(),
        ),
      ],
    );
  }

  //删除按钮
  Widget _buildDeleteBtn() {
    return LZInkWell(
        child: Image.asset(
          'assets/delete.png',
          fit: BoxFit.fill,
          width: 16,
          height: 16,
        ),
        onTap: () {
          _textController.text = "";

        });
  }
}
