import 'package:flutter/material.dart';
import 'package:flutter_chart/VectorPainter.dart';
import 'package:flutter_chart/sizeUtil.dart';
import 'package:flutter_chart/vectorDetector.dart';

void main() {
  runApp(PerceptronApp());
}

class PerceptronApp extends StatefulWidget {
  @override
  _PerceptronAppState createState() => _PerceptronAppState();
}

class _PerceptronAppState extends State<PerceptronApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Perceptron app", home: StateHomePage());
  }
}

class StateHomePage extends StatefulWidget {
  @override
  _StateHomePageState createState() => _StateHomePageState();
}

class _StateHomePageState extends State<StateHomePage> {
  ClaseEnum selectedClase = ClaseEnum.red;
  @override
  Widget build(BuildContext context) {
    SizeUtil.size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      title: Text("Perceptron"),
      actions: <Widget>[
        DropdownButton(
          value: selectedClase,
          items: ClaseEnum.values
              .map((e) => new DropdownMenuItem<ClaseEnum>(
                  value: e,
                  child: Row(
                    children: <Widget>[
                      Container(
                        color: getColor(e),
                        width: SizeUtil.width * .10,
                        height: SizeUtil.width * .05,
                      ),
                    ],
                  )))
              .toList(),
          onChanged: (value) => onSelectColor(value),
        )
      ],
    );
  }

  Widget getBody() {
    return VectorDetector(
      customPainter: VectorPainter(),
      selectedClase: selectedClase,
    );
  }

  void onSelectColor(ClaseEnum clase) {
    setState(() {
      selectedClase = clase;
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
