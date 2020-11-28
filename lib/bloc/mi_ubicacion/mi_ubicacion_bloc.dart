import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart' ;
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(MiUbicacionState());


  //final _geolocator = GeolocatorPlatform.instance.isLocationServiceEnabled();
  StreamSubscription<Position> _positionSubscryption;


  void iniciarSeguimiento(){

    _positionSubscryption = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10
    ).listen((Position position) {

      final nuevaUIbicacion = new LatLng(position.latitude, position.longitude);
      add(OnUbicacionCambio(nuevaUIbicacion));

    });
  }

  void cancelarSeguimiento(){
    _positionSubscryption?.cancel();
  }

  @override
  Stream<MiUbicacionState> mapEventToState(MiUbicacionEvent event, ) async* {
    
    if( event is OnUbicacionCambio ){
      yield state.copyWith(
        existeUbicacion: true,
        ubicacion: event.ubicacion
      );
    }


  }
}
