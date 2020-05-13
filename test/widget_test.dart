// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

//import 'package:flutter_perceptron/main.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_chart/Perceptron/CoordenadasLinea.dart';
import 'package:flutter_chart/Perceptron/Entrada.dart';
import 'package:flutter_chart/Perceptron/PlotFormatterService.dart';
import 'package:flutter_chart/Perceptron/perceptronUtil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_chart/Perceptron/Perceptron.dart';
import 'package:flutter_chart/vectorDetector.dart';
import 'package:flutter_chart/sizeUtil.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
  List<Vector> listaVectoresMock;
  Perceptron perceptronTest;

  void initializeMockData() {
    print("Perceptron initialized");
    listaVectoresMock = [
      //Clase 0
      Vector(-4.0, 0.0, ClaseEnum.red),
      Vector(-4.0, -2.0, ClaseEnum.red),
      Vector(-3.0, 0.0, ClaseEnum.red),
      //Clase 1
      Vector(-3.0, -2.0, ClaseEnum.blue),
      Vector(-3.0, -3.0, ClaseEnum.blue),
      Vector(-2.0, -2.0, ClaseEnum.blue),
    ];

    SizeUtil.size = Size(1, 1);
    perceptronTest = Perceptron(listaVectoresMock);
    perceptronTest.entradaX = Entrada(5.0);
    perceptronTest.entradaY = Entrada(5.0);
    perceptronTest.w0 = Entrada(2.5);
  }

  group("Perceptron tests", () {
    initializeMockData();
    test("Should converge perceptron", () {
      initializeMockData();
      print(perceptronTest.toString());

      do {
        perceptronTest.correrEpoca();
        print(perceptronTest.toString());
      } while (perceptronTest.epoca < PerceptronUtil.maxEpocas &&
          perceptronTest.tieneError);

      expect(perceptronTest.epoca, 11);
      expect(perceptronTest.tieneError, false);
    });

    test("Should graph weights correctly", () {
      initializeMockData();
      var plotService = PlotFormatterService();
      print(perceptronTest.toString());
      CoordenadasLinea linea;

      do {
        perceptronTest.correrEpoca();
        print(perceptronTest.toString());
        linea = plotService.plotWeights2D(
            [perceptronTest.entradaX, perceptronTest.entradaY],
            perceptronTest.w0,
            10.0,
            -10.0);

        print("Linea: '${linea.toString()}'");
      } while (perceptronTest.epoca < PerceptronUtil.maxEpocas &&
          perceptronTest.tieneError);
      expect(linea.inicioLinea.dy, -3.7500000000000067);
      expect(linea.finLinea.dy, 1.2500000000000164);
    });
  });
}
