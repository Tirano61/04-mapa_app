import 'package:flutter/material.dart' show Colors;
import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapa_app/themes/uber_map_theme.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());

  //Controlador del mapa
  GoogleMapController _mapController;

  //polyLine
  Polyline _miRuta = new Polyline(
    polylineId: PolylineId('mi-ruta'),
    width: 4,
    color: Colors.black87
  );

  void initMap(GoogleMapController controller){
    if( !state.mapaListo ){
      this._mapController = controller;
      
      this._mapController.setMapStyle(jsonEncode(uberMapTheme));

      add(OnMapaListo());
    }
  }

  void moverCamara(LatLng destino){

    final cameraUpdate = CameraUpdate.newLatLng(destino);
    this._mapController.animateCamera(cameraUpdate);

  }

  @override
  Stream<MapaState> mapEventToState(MapaEvent event, ) async* {
    if( event is OnMapaListo){
      yield state.copyWith(mapaListo: true);
    }else if(event is OnNuevaUbicacion){
      
      yield* this._onNuevaUbicacion(event);

    }else if( event is OnMarcarRecorrido ){

      yield* this._onMarcarRecorrido(event);

    }else if( event is OnSeguirUbicacion ){

      yield*  _onSeguirUbicacion(event);

    }else if( event is OnMovioMapa ){
      //print(event.centroMapa);
      yield state.copyWith(ubicacionCentral: event.centroMapa);
    }
  }

  Stream<MapaState> _onSeguirUbicacion(OnSeguirUbicacion event) async*{
    if(!state.seguirUbicacion){
      this.moverCamara(this._miRuta.points[this._miRuta.points.length -1]);
    }
    yield state.copyWith(seguirUbicacion: !state.seguirUbicacion);

  }


  Stream<MapaState> _onMarcarRecorrido( OnMarcarRecorrido event)async*{
    if (!state.dibujarRecorrido) {
        this._miRuta = this._miRuta.copyWith(colorParam: Colors.black87);
    }else{
      this._miRuta = this._miRuta.copyWith(colorParam: Colors.transparent);
    }

    final currentPolylines = state.polyLines;
    currentPolylines['mi-ruta'] = this._miRuta;

    yield state.copyWith(
      dibujarRecorrido: !state.dibujarRecorrido,
      polyLines: currentPolylines
    );
  }

  Stream<MapaState> _onNuevaUbicacion( OnNuevaUbicacion event ) async*{
    if( state.seguirUbicacion ){
      moverCamara(event.ubicacion);
    }
    final List<LatLng> points = [...this._miRuta.points, event.ubicacion];
    this._miRuta = this._miRuta.copyWith(pointsParam: points);

    final currentPolylines = state.polyLines;
    currentPolylines['mi-ruta'] = this._miRuta;

    yield state.copyWith(polyLines: currentPolylines);
  }



}