


import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapa_app/helpers/debouncer.dart';
import 'package:mapa_app/models/driving_response.dart';
import 'package:mapa_app/models/search_response.dart';

class TrafficService {

  //Singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService(){
    return _instance;
  }


  final _dio = new Dio();
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 2000 ));

  final StreamController<SearchResponse> _sugerenciasStreamController = new StreamController<SearchResponse>.broadcast();

  Stream<SearchResponse> get sugerenciasStream => _sugerenciasStreamController.stream;

  final _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final _apiKey = 'pk.eyJ1IjoidGlyYW5vNjEiLCJhIjoiY2tpMHFrbmx2MGU3ZzJ5bXN0amw0NjR3OSJ9.7cI3LGxzHCZsXhi-0FwVCQ';


  Future<DrivingResponse> getCoordsInicioYDestino(LatLng inicio, LatLng destino) async {


    print('inicio ${inicio}');
    print('destino ${destino}');

    final coordString = '${ inicio.longitude },${ inicio.latitude };${ destino.longitude },${ destino.latitude }';
    final url = '${ this._baseUrlDir }/mapbox/driving/$coordString';

    final resp = await this._dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': _apiKey,
      'language': 'es',
    });
    

    final data = DrivingResponse.fromJson(resp.data);

    return data;
  } 

  Future<SearchResponse> getResultsdoXQuery(String busqueda, LatLng proximidad) async {


    final url = '${this._baseUrlGeo}/mapbox.places/$busqueda.json';
    try {
      final resp = await this._dio.get(url, queryParameters: {
        'access_token': _apiKey,
        'autocomplete': 'true',
        'proximity'   : '${ proximidad.longitude },${proximidad.latitude}',
        'language'    : 'es'
      });

      final serchResponse = searchResponseFromJson(resp.data);

      return serchResponse;
      
    } catch (e) {
      return SearchResponse(features: []);
    }

    
  } 

  void getSugerenciasPorQuery( String busqueda, LatLng proximidad ) {

  debouncer.value = '';
  debouncer.onValue = ( value ) async {
    final resultados = await this.getResultsdoXQuery(value, proximidad);
    this._sugerenciasStreamController.add(resultados);
  };

  final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
    debouncer.value = busqueda;
  });

  Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel()); 

}


}