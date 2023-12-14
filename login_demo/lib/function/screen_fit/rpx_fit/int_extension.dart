import 'size_fit.dart';

//1.对int类型扩展
extension IntFit on int {
  double get px {
    return LZSizeFit.setPx(this.toDouble());
  }

  double get rpx {
    return LZSizeFit.setRpx(this.toDouble());
  }

  double get scaleY {
    return LZSizeFit.setScaleY(this.toDouble());
  }

}

