import 'package:flutter/material.dart';
import 'package:flutter_chart/VectorPainter.dart';
import 'package:flutter_chart/sizeUtil.dart';

class VectorDetector extends StatefulWidget {
  final VectorPainter customPainter;
  final ClaseEnum selectedClase;

  @override
  _VectorDetectorState createState() => _VectorDetectorState();

  const VectorDetector({this.customPainter, this.selectedClase});
}

class _VectorDetectorState extends State<VectorDetector> {
  List<Vector> listVectores = List<Vector>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeUtil.width,
      height: SizeUtil.height,
      child: GestureDetector(
        // child: Container(
        //   width: SizeUtil.width,
        //   height: SizeUtil.height,
        child: CustomPaint(
          painter: VectorPainter(
            listaPuntos: listVectores,
          ),
        ),
        // ),
        onTapUp: (details) => addVector(details),
      ),
    );
  }

  void addVector(TapUpDetails details) {
    var newVector = Vector(
      xPos: details.localPosition.dx,
      yPos: details.localPosition.dy,
      clase: widget.selectedClase,
    );

    setState(() {
      listVectores.add(newVector);
    });
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

  Vector({this.xPos, this.yPos, this.clase});

  @override
  String toString() {
    return "x: $xPos y: $yPos clase: ${clase.toString()}";
  }
}

enum ClaseEnum { red, blue, green }
