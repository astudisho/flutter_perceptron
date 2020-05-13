import 'package:flutter/material.dart';
import 'package:flutter_chart/Perceptron/CoordenadasLinea.dart';
import 'package:flutter_chart/VectorPainter.dart';
import 'package:flutter_chart/sizeUtil.dart';

class VectorDetector extends StatefulWidget {
  final VectorPainter customPainter;
  final ClaseEnum selectedClase;
  final Function(List<Vector> lista) onVectorListChange;
  final List<CoordenadasLinea> listaLineas;

  @override
  _VectorDetectorState createState() => _VectorDetectorState();

  const VectorDetector({this.customPainter, this.selectedClase, this.listaLineas ,this.onVectorListChange});
}

class _VectorDetectorState extends State<VectorDetector> {
  List<Vector> listVectores = List<Vector>();
  List<CoordenadasLinea> listaLineas;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeUtil.width,
      height: SizeUtil.height,
      child: GestureDetector(
        child: CustomPaint(
          painter: VectorPainter(
            listaPuntos: listVectores,
            listaLineas: widget.listaLineas,
          ),
        ),
        onTapUp: (details) => addVector(details),
      ),
    );
  }

  void addVector(TapUpDetails details) {
    var newVector = Vector(
      details.localPosition.dx,
      details.localPosition.dy,
      widget.selectedClase,
    );

    setState(() {
      listVectores.add(newVector);
      widget.onVectorListChange(listVectores);
    });
  }

  num getNumClase(ClaseEnum clase){
    var result = clase == ClaseEnum.red ? 0 : 1;
    return result;
  }

  Color getColor(ClaseEnum clase) {
    switch (clase) {
      case ClaseEnum.blue:
        return Colors.blue;
      case ClaseEnum.red:
        return Colors.red;
      case ClaseEnum.green:
        return Colors.green;
      default:
        return Colors.red;
    }
  }
}

class Vector {
  num xPos;
  num yPos;
  ClaseEnum clase;

  Vector(this.xPos, this.yPos, this.clase);

  @override
  String toString() {
    return "x: $xPos y: $yPos clase: ${clase.toString()}";
  }

  static Color _getColor(ClaseEnum clase) {
    switch (clase) {
      case ClaseEnum.blue:
        return Colors.blue;
      case ClaseEnum.red:
        return Colors.red;
      case ClaseEnum.green:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  Color getColor(){
    var result = Vector._getColor(this.clase);
    return result;
  }
}

enum ClaseEnum { red, blue, green }
