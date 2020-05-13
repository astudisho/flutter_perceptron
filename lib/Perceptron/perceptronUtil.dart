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
  static num maxEpocas = 2500;

  static double get maxX => SizeUtil.width;
  static double get minX => 0;
  static double get maxY => SizeUtil.height;
  static double get minY => 0;
  static double get x0 => -1;  
  static get maxMin => maxX < maxY ? maxX : maxY;
}