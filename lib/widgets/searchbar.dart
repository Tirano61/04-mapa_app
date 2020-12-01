

part of 'widgets.dart';


class SearchBar extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
          return Container();
        }else{
          return FadeInDown(child: buildSearchbar(context));
        }
      },
    );
  }

 
  Widget buildSearchbar(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: width,

        child: GestureDetector(
          onTap: () async {
            final proximidad = context.read<MiUbicacionBloc>().state.ubicacion;
            final historial  = context.read<BusquedaBloc>().state.historial;

            final SearchResults resultado = await showSearch(
              context: context, 
              delegate: SearchDestination( proximidad, historial ));
            this.retornoBusqueda(context, resultado);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            width: double.infinity,
            height: 50,
            child: Text('Donde quieres ir?', style: TextStyle(color: Colors.black87),),
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))
            ],

            ),        
          ),
        ),
      ),
    );
  }


  void retornoBusqueda(BuildContext context, SearchResults result) async  {

    if(result.cancelo) return;
    
    if(result.manual){

      context.read<BusquedaBloc>().add(OnActivarMarcadorManual());

      return;
    }

    //calcular la ruta en valor al result
    final trasfficService = new TrafficService();
    final mapaBloc = context.read<MapaBloc>();

    final inicio = context.read<MiUbicacionBloc>().state.ubicacion;
    final destino = result.position;

    final drivingResponse = await trasfficService.getCoordsInicioYDestino(inicio, destino);
    final geometry = drivingResponse.routes[0].geometry;
    final duration = drivingResponse.routes[0].duration;
    final distancia = drivingResponse.routes[0].distance;
    final nombreDestino = result.nombredestino;

    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);
    final List<LatLng> rutaCoordenadas = points.decodedCoords.map(
      (point) => LatLng(point[0], point[1])).toList();

    mapaBloc.add(OnCrearRutaInicioDestino(rutaCoordenadas, distancia, duration,nombreDestino));  

    //Navigator.of(context).pop();

    final busquedaBloc = context.read<BusquedaBloc>();
    busquedaBloc.add(OnAgregarHistorial(result));



  }




}