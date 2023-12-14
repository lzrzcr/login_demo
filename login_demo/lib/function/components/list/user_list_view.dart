
import 'package:flutter/material.dart';
import 'package:login_demo/function/components/btn/lz_inkwell.dart';
import 'package:login_demo/function/config/project_config.dart';
import 'package:login_demo/function/screen_fit/rpx_fit/size_extension.dart';
import 'package:login_demo/project/login/user.dart';


typedef _ClickCallBack = void Function(int index);//cell 点击回调
typedef _DeleteCallBack = void Function(int index);//cell 点击回调

class UserListView extends StatefulWidget {

  final List? dataList;
  final _ClickCallBack? clickCallBack;//点击回调
  final _DeleteCallBack? deleteCallBack;//删除按钮点击回调

  const UserListView({
    Key? key,
    this.dataList,
    this.clickCallBack,
    this.deleteCallBack,

  }) : super(key: key);

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  Widget build(BuildContext context) {
    return _buildList();
  }



  //设备列表
  Widget _buildList(){

    return ListView.builder(

        padding:  EdgeInsets.fromLTRB(8, 0, 8, 0),
        scrollDirection: Axis.vertical,
        itemExtent: 38,
        itemCount: widget.dataList?.length,

        itemBuilder: (BuildContext context, int index) {

          User user = widget.dataList?[index];

          return LZInkWell(
              child: _buildCell(user.username,index),
              onTap: (){

                //回调数据
                if(widget.clickCallBack != null){

                  widget.clickCallBack!(index);
                }

              }

          );

        }

    );


  }


  //创建 cell
  Widget _buildCell(String nameStr,int index){


    return Padding(
      padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
      child: Container(
        decoration: BoxDecoration(//Colors.grey
            // color: KColor.BLACK_TEXT_COLOR,
            border: Border(bottom: BorderSide(width: 0.5, color: KColor.BLACK_TEXT_COLOR))
        ),

        child: _buildCellContent(nameStr,index),


      ),


    );


  }



  //创建 cellContent
  Widget _buildCellContent(String nameStr,int index){


    return Row(

      mainAxisAlignment:MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Text(
          nameStr,
          style: TextStyle(
            fontSize:15,
            color: KColor.BLACK_TEXT_COLOR,
          ),
        ),

        _buildDeleteBtn(index),



      ],

    );




  }



  //删除按钮
  Widget _buildDeleteBtn(int index){

    return LZInkWell(
        child: Image.asset(
          'assets/delete.png',
          fit: BoxFit.fill,
          width: 16,
          height: 16,
        ),

        onTap: (){

          //回调数据
          if(widget.deleteCallBack != null){

            widget.deleteCallBack!(index);
          }


        }

    );


  }



}
