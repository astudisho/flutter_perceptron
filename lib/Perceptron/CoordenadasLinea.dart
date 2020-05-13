import 'dart:ui';

class CoordenadasLinea {
  CoordenadasLinea(this.inicioLinea, this.finLinea);

  Offset inicioLinea;
  Offset finLinea;

  String toString(){
    return "Inicio: '${inicioLinea.dx}','${inicioLinea.dy}' Fin: '${finLinea.dx}','${finLinea.dy}'";
  }
}
