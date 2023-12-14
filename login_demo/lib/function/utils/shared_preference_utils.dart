
import 'dart:convert';
import 'package:login_demo/project/login/user.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';


///数据相关的工具
class SharedPreferenceUtil {
  static const String loginNumber = "loginNumber";
  static const String loginName = "loginName";
  static const String loginPwd = "loginPwd";



  /// get string.
  static Future<String?> getString(String key, {String? defValue = ''}) async{

    SharedPreferences sp = await SharedPreferences.getInstance();

    return sp.getString(key) ?? defValue;


  }

  /// put string.
  static Future<bool>? putString(String key, String value) async{

    SharedPreferences sp = await SharedPreferences.getInstance();

    return sp.setString(key, value);

  }




  ///删掉单个账号
  static void delUser(User user) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<User> list = await getUsers();
    list.remove(user);
    saveUsers(list, sp);
  }

  ///保存账号，如果重复，就将最近登录账号放在第一个
  static void saveUser(User user) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<User> list = await getUsers();
    addNoRepeat(list, user);
    saveUsers(list, sp);
  }

  ///去重并维持次序
  static void addNoRepeat(List<User> users, User user) {
    if (users.contains(user)) {
      users.remove(user);
    }
    users.insert(0, user);
  }

  ///获取已经登录的账号列表
  static Future<List<User>> getUsers() async {
    List<User> list =  [];
    SharedPreferences sp = await SharedPreferences.getInstance();
    int num = sp.getInt(loginNumber) ?? 0;
    for (int i = 0; i < num; i++) {
      String? username = sp.getString ("$loginName$i");
      String? password = sp.getString("$loginPwd$i");
      list.add(User(username, password));
    }
    return list;
  }

  ///保存账号列表
  static saveUsers(List<User> users, SharedPreferences sp){
    sp.clear();
    int size = users.length;
    for (int i = 0; i < size; i++) {
      sp.setString("$loginName$i", users[i].username);
      sp.setString("$loginPwd$i", users[i].password);
    }
    sp.setInt(loginNumber, size);
  }


  ///筛选账号列表
  static Future<List<User>> filterUsers(String value) async {
    List<User> list =  [];
    SharedPreferences sp = await SharedPreferences.getInstance();
    int num = sp.getInt(loginNumber) ?? 0;
    for (int i = 0; i < num; i++) {

      String? username = sp.getString("$loginName$i");
      String? password = sp.getString("$loginPwd$i");

      if (username?.indexOf(value) == -1) {
        // 未匹配到
      } else {
        // 匹配到了

        // print(' 匹配到了：  $username');

        list.add(User(username, password));

      }


    }
    return list;
  }




  ///保存账号，如果重复，就将最近登录账号放在第一个
  static void saveRememberUser(String name, String pwd) async {
      SharedPreferences sp = await SharedPreferences.getInstance();

      // 首先获取
      String? rememberStr = sp.getString('rememberKey');

      Map rememberJson = {};
      if (rememberStr == null) {
        rememberJson = {};
      } else {
        rememberJson = json.decode(rememberStr);

      }

      // 将用户信息加入到loginJson
      rememberJson[name] = pwd;

      // 写入持久化
      await sp.setString('rememberKey', json.encode(rememberJson));


    }



  ///获取记住密码保存的用户
  static Future<List<User>> getRememberUsers() async {

    List<User> list = [];

    SharedPreferences sp = await SharedPreferences.getInstance();

    // 首先获取
    String? rememberStr = sp.getString('rememberKey');
    Map rememberJson = {};
    if (rememberStr == null) {
      rememberJson = {};
    } else {
      rememberJson = json.decode(rememberStr);

    }

    for (var item in rememberJson.keys) {
      String? username = item;
      String? password = rememberJson[item];
      list.add(User(username, password));
    }

    // print('读取记录密码列表 list =======:$list');
    return list;


  }


  ///筛选记住密码账号列表
  static Future<List<User>> filterRememberUsers(String value) async {

    List<User> list =  [];
    SharedPreferences sp = await SharedPreferences.getInstance();

    // 首先获取
    String? rememberStr = sp.getString('rememberKey');
    Map rememberJson = {};
    if (rememberStr == null) {
      rememberJson = {};
    } else {
      rememberJson = json.decode(rememberStr);

    }


    for (var item in rememberJson.keys) {

      String? username = item;
      String? password = rememberJson[item];

      if (username?.indexOf(value) == -1) {
        // 未匹配到
      } else {
        // 匹配到了
        // print(' 匹配到了：  $username');

        list.add(User(username, password));

      }

    }


    return list;

  }



  ///删掉记录的单个账号
  static void delRememberUser(User user) async {

    List<User> list =  [];

    SharedPreferences sp = await SharedPreferences.getInstance();

    // 首先获取
    String? rememberStr = sp.getString('rememberKey');
    Map rememberJson = {};
    if (rememberStr == null) {
      rememberJson = {};
    } else {
      rememberJson = json.decode(rememberStr);

    }

    rememberJson.remove(user.username);

    print(' 删除后的 map ：  $rememberJson');

    // 写入持久化
    await sp.setString('rememberKey', json.encode(rememberJson));

  }



}
