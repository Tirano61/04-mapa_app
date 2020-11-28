
part of 'widgets.dart';

class BtnSeguirUbicacion extends StatelessWidget {
 
  

  @override
  Widget build(BuildContext context) {

    final mapaBloc = context.watch<MapaBloc>();
    

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            mapaBloc.state.seguirUbicacion
            ? Icons.directions_run
            : Icons.accessibility_new, 
            color: Colors.black,
          ),
          onPressed: (){
            
            mapaBloc.add(OnSeguirUbicacion());
          },
        ),
      ),
    );
  }
}