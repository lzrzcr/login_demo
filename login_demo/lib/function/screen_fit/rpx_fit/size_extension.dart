

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



//2.对double类型扩展
extension DoubleFit on double {
  double get px {
    return LZSizeFit.setPx(this);
  }

  double get rpx {
    return LZSizeFit.setRpx(this);
  }

  double get scaleY {
    return LZSizeFit.setScaleY(this);
  }

}
