
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapa_app/bloc/busqueda/busqueda_bloc.dart';
import 'package:mapa_app/bloc/mapa/mapa_bloc.dart';
import 'package:mapa_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:mapa_app/pages/acceso_gps_page.dart';
import 'package:mapa_app/pages/louding_page.dart';
import 'package:mapa_app/pages/mapa_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider( 
      providers: [

        BlocProvider(create: (_) => MiUbicacionBloc()),
        BlocProvider(create: (_) => MapaBloc()),
        BlocProvider(create: (_) => BusquedaBloc()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
   
        home: LoadingPage(),
      
        routes: {
          'mapa': (_) => MapaPage(),
          'loading': (_) => LoadingPage(),
          'acceso': (_) => AccesoGpsPage() 
        },
      ),
    );
  }
}