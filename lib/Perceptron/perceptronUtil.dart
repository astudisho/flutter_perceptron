import 'dart:math';
import 'package:flutter_chart/sizeUtil.dart';

class PerceptronUtil{
  static Random random = Random();  

  static double getRandom(num max){
    var numero = random.nextDouble();
    var result = numero * max;
    return result;
  }

  static num learningRate = 0.1;
  static num errorRate = 0.1;
  static num maxEpocas = 500;

  static double getMaxX() => SizeUtil.width;
  static double getMinX() => 0;
  static double getMaxY() => SizeUtil.height;
  static double getMinY() => 0;
  static double getX0() => -1;  
  static get getMaxMin => getMaxX() < getMaxY() ? getMaxX() : getMaxY();
}