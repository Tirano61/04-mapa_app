part of 'busqueda_bloc.dart';

@immutable
class BusquedaState{

  final bool seleccionManual;
  final List<SearchResults> historial;


  BusquedaState({
    this.seleccionManual = false,
    List<SearchResults> historial

  }): this.historial = (historial == null) ? [] : historial;



  BusquedaState copyWith({
    bool seleccionManual,
    List<SearchResults> historial
  }) => BusquedaState(
    seleccionManual: seleccionManual ?? this.seleccionManual,
    historial: historial ?? this.historial
  );

}
