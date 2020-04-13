
import 'package:flutter_chart/Perceptron/Entrada.dart';
import 'package:flutter_chart/Perceptron/perceptronUtil.dart';
import 'package:flutter_chart/vectorDetector.dart';

class Perceptron{
  Perceptron({ this.vectores});

  final List<Vector> vectores;  

  Entrada entradaX = Entrada(valor: PerceptronUtil.getRandom( PerceptronUtil.getMaxX()));
  Entrada entradaY = Entrada(valor: PerceptronUtil.getRandom( PerceptronUtil.getMaxY()));
  Entrada _w0 = Entrada(valor: PerceptronUtil.getRandom(PerceptronUtil.getMaxMin()));  

  bool tieneError = false;
  num epoca = 0;

  Future entrenar() async {
    do {
      await correrEpoca();
    } while (epoca < PerceptronUtil.maxEpocas && tieneError);
  }

  Future correrEpoca()async {
    vectores.forEach((vector) {
      var salida = respuesta(vector);
      var esError = salida != vector.clase;

      if(esError){
        tieneError = true;
        
        _w0.valor = _w0.valor + PerceptronUtil.errorRate * PerceptronUtil.getX0();       
        entradaX.valor = entradaX.valor + PerceptronUtil.learningRate * PerceptronUtil.errorRate + vector.xPos;
        entradaY.valor = entradaY.valor + PerceptronUtil.learningRate * PerceptronUtil.errorRate + vector.yPos;
      }
    });
  }

  ClaseEnum respuesta(Vector vector){
    var suma = PerceptronUtil.getX0() * _w0.valor;

    suma += (vector.xPos * entradaX.valor) + vector.yPos * entradaY.valor;

    var result = suma > 0 ? ClaseEnum.red : ClaseEnum.blue;
    return result;
  }
}