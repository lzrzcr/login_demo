
import 'size_fit.dart';

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
