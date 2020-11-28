


import 'package:flutter/material.dart';
import 'package:mapa_app/models/search_results.dart';

class SearchDestination extends SearchDelegate<SearchResults> {

  @override
  final String searchFieldLabel;
  SearchDestination() : this.searchFieldLabel = 'Buscar';

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
      
      return Text('buildResults');
    }
  
    // cuando la persona esta escribiendo y aparecen las sugerencias
    @override
    Widget buildSuggestions(BuildContext context) {
    
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

}