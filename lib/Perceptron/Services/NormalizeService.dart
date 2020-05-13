

import 'package:flutter_chart/vectorDetector.dart';

class NormalizeService{
  num minX, minY, maxX, maxY;

  NormalizeService(this.maxX, this.maxY, {this.minX = 0, this.minY = 0});

  Vector normalizeVector(Vector input){
    var xPos = (input.xPos - this.minX) / (maxX - minX);
    var yPos = (input.yPos - this.minY) / (maxY - minY);

    var result = Vector(xPos, yPos, input.clase);
    
    return result;
  }

  num normalizeInputX(num input){
    var result = (input - this.minX) / (maxX - minX);
    return result;
  }
  num normalizeInputY(num input){
    var result = (input - this.minY) / (maxY - minY);
    return result;
  }
}