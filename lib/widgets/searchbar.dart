

part of 'widgets.dart';


class SearchBar extends StatelessWidget {
  
  

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: width,

        child: GestureDetector(
          onTap: () async {
            final SearchResults resultado = await showSearch(context: context, delegate: SearchDestination());
            this.retornoBusqueda(resultado);
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


  void retornoBusqueda(SearchResults result){

    if(result.cancelo) return;
    


  }


}