part of 'mapa_bloc.dart';

@immutable
class MapaState {

  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguirUbicacion;
  final LatLng ubicacionCentral;


  //Polylines

  final Map<String, Polyline> polyLines ;
  final Map<String, Marker> markers ;

  MapaState({
    this.mapaListo = false,
    this.dibujarRecorrido = false,
    Map<String, Polyline> polyLines,
    Map<String, Marker> markers,
    this.seguirUbicacion = false,
    this.ubicacionCentral
  }): this.polyLines = polyLines ?? new Map(),
      this.markers = markers ?? new Map();


  copyWith({
    bool mapaListo,
    bool dibujarRecorrido,
    Map<String, Polyline> polyLines,
    bool seguirUbicacion,
    LatLng ubicacionCentral,
    Map<String, Marker> markers,
  }) => MapaState(
    mapaListo: mapaListo ?? this.mapaListo,
    dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
    polyLines: polyLines ?? this.polyLines,
    seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
    ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral,
    markers: markers ?? this.markers,
  );


}
