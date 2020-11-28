

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapa_app/bloc/mapa/mapa_bloc.dart';

import 'package:mapa_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:mapa_app/widgets/widgets.dart';


class MapaPage extends StatefulWidget {


  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {


  @override
  void initState() {
   
    context.read<MiUbicacionBloc>().iniciarSeguimiento();

    super.initState();
  }

  @override
  void dispose() {
    context.read<MiUbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: [

          BlocBuilder<MiUbicacionBloc, MiUbicacionState>(

            builder: (context, state) => crearMapa(state) 
          
          ),

          // Positioned(
          //   top: 10,
          //   child: SearchBar()),

          MarcadorManual(),

        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          BtnUbicacion(),
          BtnSeguirUbicacion(),
          BtnMiRuta(),
          
        ],
      ) ,
    );
  }


  Widget crearMapa(MiUbicacionState state){

    if(!state.existeUbicacion) return Center(child: Text('Ubicando ...'));

    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    mapaBloc.add(OnNuevaUbicacion(state.ubicacion));

    final camaraPosition = new CameraPosition(
      target: state.ubicacion,
      zoom: 15, 
    
    );
    return GoogleMap(
      initialCameraPosition: camaraPosition,
      compassEnabled: true,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: mapaBloc.initMap,
      polylines: mapaBloc.state.polyLines.values.toSet(),
      onCameraMove: (cameraPosition){
        mapaBloc.add(OnMovioMapa(camaraPosition.target));
      },
    );

  }


}


