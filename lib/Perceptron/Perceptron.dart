
import 'package:flutter_chart/Perceptron/Entrada.dart';
import 'package:flutter_chart/Perceptron/perceptronUtil.dart';
import 'package:flutter_chart/vectorDetector.dart';

class Perceptron{
  Perceptron({ this.vectores});

  final List<Vector> vectores;  

  Entrada entradaX = Entrada(valor: PerceptronUtil.getRandom( PerceptronUtil.maxX));
  Entrada entradaY = Entrada(valor: PerceptronUtil.getRandom( PerceptronUtil.maxY));
  Entrada w0 = Entrada(valor: PerceptronUtil.getRandom(PerceptronUtil.maxMin));  

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
        
        w0.valor = w0.valor + PerceptronUtil.errorRate * PerceptronUtil.x0;
        entradaX.valor = entradaX.valor + PerceptronUtil.learningRate * PerceptronUtil.errorRate + vector.xPos;
        entradaY.valor = entradaY.valor + PerceptronUtil.learningRate * PerceptronUtil.errorRate + vector.yPos;
      }
    });
    epoca++;
    print("Epoca: $epoca");
  }

  ClaseEnum respuesta(Vector vector){
    var suma = PerceptronUtil.x0 * w0.valor;

    suma += (vector.xPos * entradaX.valor) + vector.yPos * entradaY.valor;

    var result = suma > 0 ? ClaseEnum.red : ClaseEnum.blue;
    return result;
  }
}

// (w0 / entradaY) - ((entradaX / entradaY ))