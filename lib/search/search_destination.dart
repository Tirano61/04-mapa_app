


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mapa_app/models/search_response.dart';
import 'package:mapa_app/models/search_results.dart';
import 'package:mapa_app/services/traffic_service.dart';

class SearchDestination extends SearchDelegate<SearchResults> {

  @override
  final String searchFieldLabel;

  final TrafficService _trafficService;
  final LatLng proximidad; 

  SearchDestination(this.proximidad) 
  : this.searchFieldLabel = 'Buscar',
  this._trafficService = new TrafficService();


  // Lo que aparece al final de la barra
  @override
  List<Widget> buildActions(BuildContext context) {
      
      return [
        IconButton(
        icon: Icon(Icons.clear), 
        onPressed: (){
          this.query = '';
        }),
      ];
    }
  
    //Icono al inicio de la barra
    @override
    Widget buildLeading(BuildContext context) {
      
      final searchResult = SearchResults(cancelo: true);

      return IconButton(
        icon: Icon(Icons.arrow_back), 
        onPressed: (){
          this.close(context, searchResult);
        });
    }

    //Cuando se presiona enter y muestra los resultados finales, quita el teclado
    @override
    Widget buildResults(BuildContext context) {
      
      
      return this._construirResultadosSegerencias();
    }
  
    // cuando la persona esta escribiendo y aparecen las sugerencias
    @override
    Widget buildSuggestions(BuildContext context) {
    if(this.query.length == 0){
      return ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Colocar ubicación manualmente'),
            onTap: (){
              print('object');
              this.close(context, SearchResults(cancelo: false,manual: true));
            },
          ),
        ],
      );
    }

    return _construirResultadosSegerencias();
    
  }


  Widget _construirResultadosSegerencias(){

    if(query == 0 ){
      return Container();
    }

    return FutureBuilder(
      future: this._trafficService.getResultsdoXQuery(this.query.trim(), proximidad),
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {  

        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        
        final lugares = snapshot.data.features;

        if(lugares.length == 0){
          return ListTile(
            title: Text('No hay resultados con $query'),
          );
        }

        return ListView.separated(
          itemBuilder:  (_, i){
            final lugar = lugares[i];
            return ListTile(
              leading: Icon(Icons.place),
              title: Text(lugar.textEs),
              subtitle: Text(lugar.placeNameEs),
              onTap: (){
                print(lugar);
              },
            );
          },
          separatorBuilder: (_, i) => Divider(), 
          itemCount: lugares.length,
        );
         

      },
    );

  }




}