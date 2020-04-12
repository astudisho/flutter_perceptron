

import 'dart:ui';

class SizeUtil{
  //logic size in device
  static Size _logicSize;

  //device pixel radio.

  static get width {
    return _logicSize.width;
  }

  static get height {
    return _logicSize.height;
  }

  static set size(size) {
    _logicSize = size;
  }
}