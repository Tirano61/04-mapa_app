


import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show BitmapDescriptor;
import 'package:mapa_app/custom_markers/customs_marker.dart';

part 'navegar_fadein.dart';
part 'calculando_alerta.dart';
part 'custom_markers.dart';
part 'widget_to_marker.dart';


navegarMapaFadeIn( BuildContext context, Widget page ){


  return PageRouteBuilder(pageBuilder: ( _ , __ , ___ ) => page,
    transitionDuration: Duration(milliseconds: 300),
    transitionsBuilder: ( context, animation, _, child ){
      return FadeTransition(
        child: child,
        opacity: Tween<double>( begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation,curve: Curves.easeOut ),
        )
      );
    }
  );

}