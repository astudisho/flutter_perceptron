import 'package:flutter_chart/Perceptron/Entrada.dart';
import 'package:flutter_chart/Perceptron/Services/NormalizeService.dart';
import 'package:flutter_chart/Perceptron/perceptronUtil.dart';
import 'package:flutter_chart/vectorDetector.dart';

class Perceptron {
  List<Vector> vectores;
  NormalizeService _normalizeService;
  Entrada entradaX;
  Entrada entradaY;
  Entrada w0;
  bool tieneError = false;
  num epoca = 0;

  Perceptron(List<Vector> vectores) {
    this._normalizeService = NormalizeService(
        PerceptronUtil.maxX, PerceptronUtil.maxY,
        minX: PerceptronUtil.minX, minY: PerceptronUtil.minY);

    var x = _normalizeService
        .normalizeInputX(PerceptronUtil.getRandom(PerceptronUtil.maxX));
    var y = _normalizeService
        .normalizeInputY(PerceptronUtil.getRandom(PerceptronUtil.maxY));
    var w = _normalizeService
        .normalizeInputX(PerceptronUtil.getRandom(PerceptronUtil.maxMin));

    this.entradaX = Entrada(x);
    this.entradaY = Entrada(y);
    this.w0 = Entrada(w);

    var normalizedVectors = <Vector>[];

    for (var vector in vectores) {
      var v = this._normalizeService.normalizeVector(vector);
      normalizedVectors.add(v);
    }

    this.vectores = normalizedVectors;
  }

  Future entrenar() async {
    do {
      await correrEpoca();
    } while (epoca < PerceptronUtil.maxEpocas && tieneError);
  }

  Future correrEpoca() async {
    tieneError = false;
    vectores.forEach((vector) {
      var salida = respuesta(vector);
      var error = vector.clase.index - salida;
      var esError = error != 0;

      if (esError) {
        tieneError = true;

        w0.valor = w0.valor +
            (PerceptronUtil.learningRate * error * PerceptronUtil.x0);
        entradaX.valor = entradaX.valor +
            (PerceptronUtil.learningRate * error * vector.xPos);
        entradaY.valor = entradaY.valor +
            (PerceptronUtil.learningRate * error * vector.yPos);
      }
    });
    epoca++;
  }

  num respuesta(Vector vector) {
    var suma = PerceptronUtil.x0 * w0.valor;

    suma += (vector.xPos * entradaX.valor) + (vector.yPos * entradaY.valor);

    var result = suma >= 0 ? 1 : 0;
    return result;
  }

  String toString() {
    var mensaje =
        "Epoca: '$epoca' Pesos: '${entradaX.valor}' '${entradaY.valor}' Bias: '${w0.valor}'";
    return mensaje;
  }
}

// (w0 / entradaY) - ((entradaX / entradaY ))
