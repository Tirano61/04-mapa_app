import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapa_app/helpers/helpers.dart';
import 'package:mapa_app/pages/acceso_gps_page.dart';
import 'package:mapa_app/pages/mapa_page.dart';
import 'package:permission_handler/permission_handler.dart';


class LoadingPage extends StatefulWidget   {


  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {



  @override
  void initState() {
   WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    
    if(state == AppLifecycleState.resumed){
      if(await GeolocatorPlatform.instance.isLocationServiceEnabled()){
        Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return Center(child: Text(snapshot.data),);
          }else{
            return CircularProgressIndicator(strokeWidth: 3,);
          }
        },
      ),
    );
  }

  Future checkGpsLocation( BuildContext context ) async {

    final permisoGps = await Permission.location.isGranted;
    final gpsActivo =  await GeolocatorPlatform.instance.isLocationServiceEnabled();
    
    if( permisoGps &&  gpsActivo) {
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
    }else if( !permisoGps ){
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, AccesoGpsPage()));
      return 'Es necesario dar permisos GPS';
    }else if( !gpsActivo ){

      return 'Active el GPS';
    }

  }
}


