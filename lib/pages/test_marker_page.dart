import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapa_app/custom_markers/customs_marker.dart';


class TestMarkerPage extends StatelessWidget {
  const TestMarkerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          color: Colors.red,
          child: CustomPaint(
            // painter: MarkerInicioPainter(16),
            painter: MarkerDestinoPainter(
              'Mi casa esta por aqui, en alguna parte del mundo, sdhsjhdh sjkdjlksdj sjdkjkj',
              6500034

            ),
          ),
        ),
      ),
    );
  }
}