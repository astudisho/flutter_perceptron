

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_chart/sizeUtil.dart';
import 'package:flutter_chart/vectorDetector.dart';

class VectorPainter extends CustomPainter {
  List<Vector> listaPuntos = <Vector>[];
  VectorPainter({this.listaPuntos});

  @override
  void paint(Canvas canvas, Size size) {

    canvas.save();
    SizeUtil.size = size;

    final paint = Paint()    
    ..color = Colors.black
    ..strokeWidth = 4
    ..strokeCap = StrokeCap.round;    

    var listaAzul = listaPuntos.where((Vector element) => element.clase == ClaseEnum.blue).map((e) => Offset(e.xPos,e.yPos)).toList();
    var listaRoja = listaPuntos.where((Vector element) => element.clase == ClaseEnum.red).map((e) => Offset(e.xPos,e.yPos)).toList();

    if( listaAzul != null) {
      paint.color = Colors.blue;
      canvas.drawPoints(PointMode.points, listaAzul , paint);
    }

    if( listaRoja != null) {
      paint.color = Colors.red;
      canvas.drawPoints(PointMode.points, listaRoja , paint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    var delegate = oldDelegate as VectorPainter;
    var result = this.listaPuntos?.length != delegate.listaPuntos?.length;
    result = true;
    return result;
  }
}