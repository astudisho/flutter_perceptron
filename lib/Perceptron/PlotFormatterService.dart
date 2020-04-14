import 'package:flutter/material.dart';
import 'package:flutter_chart/Perceptron/CoordenadasLinea.dart';

import 'Entrada.dart';

class PlotFormatterService{
  PlotFormatterService();

  CoordenadasLinea plotWeights2D(List<Entrada> pesos, Entrada bias, num maxX, num minX) 
  {
    assert(pesos.length == 2);

    CoordenadasLinea result;

    var minY = (bias.valor / pesos[1].valor) - ((pesos[0].valor / pesos[1].valor) * minX);
    var maxY = (bias.valor / pesos[1].valor) - ((pesos[0].valor / pesos[1].valor) * maxX);

    //result = <Offset>[new Offset(minX, minY), new Offset(maxX, maxY)];
    var inicioLinea = new Offset(minX, minY);
    var finLinea = new Offset(maxX, maxY);
    result = CoordenadasLinea(inicioLinea, finLinea);

    return result;
  }
}