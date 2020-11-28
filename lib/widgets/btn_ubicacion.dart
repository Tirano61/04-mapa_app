
part of 'widgets.dart';

class BtnUbicacion extends StatelessWidget {
 
  

  @override
  Widget build(BuildContext context) {

    final mapaBloc = context.watch<MapaBloc>();
    final miUbicacionBloc = context.watch<MiUbicacionBloc>();

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.my_location, color: Colors.black),
          onPressed: (){
            final destino = miUbicacionBloc.state.ubicacion;
            mapaBloc.moverCamara(destino);
          },
        ),
      ),
    );
  }
}