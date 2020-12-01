
part of 'customs_marker.dart';

class MarkerDestinoPainter extends CustomPainter {

  final String descripcion;
  final double metros;

  MarkerDestinoPainter(this.descripcion, this.metros);

   @override
  void paint(Canvas canvas, Size size) {

    final double circuloNegro = 20;
    final double circuloBlanco = 7;
      
    Paint paint = new Paint();
    paint.color = Colors.black;

    // Dibujar circulo negro
    canvas.drawCircle(
      Offset(circuloNegro, size.height - circuloNegro), 
      circuloNegro, 
      paint
    );
    // Dibujar circulo blanco
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(circuloNegro, size.height - circuloNegro), 
      circuloBlanco, 
      paint
    );
    //Sombra
    final Path path = new Path();
    path.moveTo(0, 20);
    path.lineTo(size.width -10, 20);
    path.lineTo(size.width -10, 100);
    path.lineTo(0, 100);
    
    canvas.drawShadow(path, Colors.black, 10, false);

    //caja blanca
    final cajaBlanca = Rect.fromLTWH(0, 20, size.width -10, 80);
    canvas.drawRect(cajaBlanca, paint);
    //caja negra
    paint.color = Colors.black;
    final cajaNegra = Rect.fromLTWH(0, 20, 70, 80);
    canvas.drawRect(cajaNegra, paint);

    //Dibijar textos
    double kilometros = this.metros /1000;
    kilometros = (kilometros *100).floor().toDouble();
    kilometros = kilometros /100;

    TextSpan textSpan = new TextSpan(
      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
      text: '$kilometros'
    );

    TextPainter textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: 80,
      minWidth: 80
    );

    textPainter.paint(canvas, Offset(0, 35));
    //Minutos
    textSpan = new TextSpan(
      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
      text: 'Km'
    );

    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: 70,

    );

    textPainter.paint(canvas, Offset(25, 67));

    //Mi ubicacion
    textSpan = new TextSpan(
      style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w400),
      text: this.descripcion
    );

    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLines: 2,
      ellipsis: '...'
    )..layout(
      maxWidth: size.width -100,
      minWidth: 70
    );

    textPainter.paint(canvas, Offset(90, 35));



  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;

  


}