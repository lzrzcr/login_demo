

import 'package:get/get.dart';
import 'package:login_demo/function/getx/lz_getx_controller.dart';


//声明需要进行的绑定控制器类
class LZGetXBinding implements Bindings {

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LZGetXController>(() => LZGetXController(),fenix: true);


  }
}