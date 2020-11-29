


import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapa_app/models/driving_response.dart';

class TrafficService {

  //Singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService(){
    return _instance;
  }


  final _dio = new Dio();
  final _baseUrl = 'https://api.mapbox.com/directions/v5';
  final _apiKey = 'pk.eyJ1IjoidGlyYW5vNjEiLCJhIjoiY2tpMHFrbmx2MGU3ZzJ5bXN0amw0NjR3OSJ9.7cI3LGxzHCZsXhi-0FwVCQ';


  Future<DrivingResponse> getCoordsInicioYDestino(LatLng inicio, LatLng destino) async {


    print('inicio ${inicio}');
    print('destino ${destino}');

    final coordString = '${ inicio.longitude },${ inicio.latitude };${ destino.longitude },${ destino.latitude }';
    final url = '${ this._baseUrl }/mapbox/driving/$coordString';

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



}