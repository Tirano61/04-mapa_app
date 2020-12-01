
part of 'customs_marker.dart';

class MarkerInicioPainter extends CustomPainter {

  final int minutos;

  MarkerInicioPainter(this.minutos);



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
    path.moveTo(40, 20);
    path.lineTo(size.width -10, 20);
    path.lineTo(size.width -10, 100);
    path.lineTo(40, 100);
    
    canvas.drawShadow(path, Colors.black, 10, false);

    //caja blanca
    final cajaBlanca = Rect.fromLTWH(40, 20, size.width -60, 80);
    canvas.drawRect(cajaBlanca, paint);
    //caja negra
    paint.color = Colors.black;
    final cajaNegra = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(cajaNegra, paint);

    //Dibijar textos
    TextSpan textSpan = new TextSpan(
      style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
      text: minutos.toString()
    );

    TextPainter textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: 70,
      minWidth: 70
    );

    textPainter.paint(canvas, Offset(40, 35));
    //Minutos
    textSpan = new TextSpan(
      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
      text: 'Min'
    );

    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: 70,
      minWidth: 70
    );

    textPainter.paint(canvas, Offset(40, 67));

    //Mi ubicacion
    textSpan = new TextSpan(
      style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w400),
      text: 'Mi ubicacion'
    );

    textPainter = new TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(
      maxWidth: size.width -130,
      minWidth: 70
    );

    textPainter.paint(canvas, Offset(160, 48));



  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;





}