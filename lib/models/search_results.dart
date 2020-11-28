


import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng ;

class SearchResults {

  final bool cancelo;
  final bool manual;
  final LatLng position;
  final String nombredestino;
  final String descripcion;

  SearchResults({
    @required this.cancelo, 
    this.manual, 
    this.position, 
    this.nombredestino, 
    this.descripcion
  });




}