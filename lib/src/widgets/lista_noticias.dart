import 'package:flutter/material.dart';
import 'package:noticias_mundiales/src/models/news_models.dart';
import 'package:noticias_mundiales/src/theme/tema.dart';



class ListaNoticias extends StatelessWidget {

  final List<Article> noticias;

  const ListaNoticias( this.noticias );


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia( 
                        noticia: this.noticias[index],
                        index: index 
                        );
     }
    );
  }
}


class _Noticia extends StatelessWidget {

  final Article noticia;
  final int index;

  const _Noticia({ 
    @required this.noticia, 
    @required this.index 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
         SizedBox( height: 20 ),

        _TarjetaTopBar( noticia, index ),

        _TarjetaTitulo( noticia ),

        _TarjetaImagen( noticia ),

        _TarjetaBody( noticia ),

        SizedBox( height: 20 ),
        Divider(color: Colors.black38,),
        

      ],
    );
  }
}



class _TarjetaBody extends StatelessWidget {
  
  final Article noticia;

  const _TarjetaBody( this.noticia );



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text( (noticia.description != null) ? noticia.description : '')
    );
  }
}



class _TarjetaImagen extends StatelessWidget {
  
  final Article noticia;

  const _TarjetaImagen( this.noticia );


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( vertical: 10 ),
      child: ClipRRect(
        //CLIPPECT NOS AYUDA A REALIZAR CORTES CON LOS WIDGETS
        borderRadius: BorderRadius.all(Radius.circular(50)),
        //borderRadius: BorderRadius.only( topLeft: Radius.circular(50), bottomRight: Radius.circular(50) ),
        child: Container(
          child: ( noticia.urlToImage != null ) 
          //Si la noticia es distinto de null muestra la imagen
              ? FadeInImage(
                  placeholder: AssetImage( 'assets/img/spin.gif' ), 
                  image: NetworkImage( noticia.urlToImage )
                )
            //De lo contrario mandamos la imagen  de imagenes no disponibles
              : Image( image: AssetImage('assets/img/no-image.png'), )
        ),
      ),
    );
  }
}



class _TarjetaTitulo extends StatelessWidget {

  final Article noticia;

  const _TarjetaTitulo( this.noticia );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 15 ),
      child: Text( noticia.title, style: TextStyle( fontSize: 20, fontWeight: FontWeight.w700 ), ),
    );
  }
}



class _TarjetaTopBar extends StatelessWidget {

  final Article noticia;
  final int index;

  const _TarjetaTopBar( this.noticia, this.index );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 10),
      margin: EdgeInsets.only( bottom: 10 ),
      child: Row(
        children: <Widget>[
          Text('${ index + 1 }. ', style: TextStyle( color: miTema.accentColor ),),
          Text('${ noticia.source.name.toUpperCase() }. ', style: TextStyle(color: miTema.accentColor),),
        ],
      ),

    );
  }
}