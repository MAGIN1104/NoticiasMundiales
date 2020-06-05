import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:noticias_mundiales/src/models/category_model.dart';
import 'package:noticias_mundiales/src/models/news_models.dart';

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY   = '369eb16a1e8d489d916350297272164d';

class NewsService with ChangeNotifier {
//Creamos una lista de articulo que lo llamamos headlines, esta lista empieza vacia
  List<Article> headlines = [];

//Para identificar la categoria seleccionada
  String _selectedCategory = 'business';

  bool _isLoading = true;

//Asiganmos los iconos en las categorias. y esto lo asignamos a una lista de categoria que previamentese creo un modelo
//Esta lista de categorias lo podemos visualizar en el tab page2  
  List<Category> categories = [
    Category( FontAwesomeIcons.businessTime, 'business'  ),
    Category( FontAwesomeIcons.tv, 'entertainment'  ),
    Category( FontAwesomeIcons.addressCard, 'general'  ),
    Category( FontAwesomeIcons.virus, 'health'  ),
    Category( FontAwesomeIcons.vials, 'science'  ),
    Category( FontAwesomeIcons.baseballBall, 'sports'  ),
    Category( FontAwesomeIcons.memory, 'technology'  ),
  ];
//Para almacenar la informacion  nos creamos un mapa la lista de Articulos
//este se inicializa vacio
  Map<String, List<Article>> categoryArticles = {};


      
  NewsService() {
    this.getTopHeadlines();
    //para recorrer la lista de Articulos
    categories.forEach( (item) {
      this.categoryArticles[item.name] = new List();
    });
    this.getArticlesByCategory( this._selectedCategory );
  }

  bool get isLoading => this._isLoading;

//Debemos determinar los getter y setters de categorias seleccionadas

  get selectedCategory => this._selectedCategory;
  set selectedCategory( String valor ) {
    this._selectedCategory = valor;

    this._isLoading = true;
    //cargamos y traemos la informacion
    this.getArticlesByCategory( valor );
    notifyListeners();
  }
  
  List<Article> get getArticulosCategoriaSeleccionada => this.categoryArticles[ this.selectedCategory ];


  //ESTE METODO NOS AYUDA A CARGAR LOS DATOS

  getTopHeadlines() async {
  //LLAMAMOS A LA URL DE LA CUAL QUEREMOS CONSUMIR 
      final url ='$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ca';
  //PARA REALIZAR LA PETICION NECESITAMOS HTTP 
      final resp = await http.get(url);
  //LA RESPUESTA DE LAS NOTICIAS QUE OBTENDREMOS
  //NEWRESPONSE LLEGA A OBTENERSE DE LOS MODELS
      final newsResponse = newsResponseFromJson( resp.body );
  //PARA AGREGAR A LA LISTA DE ARTICULOS heahlines 
      this.headlines.addAll( newsResponse.articles );
  //DESPUES DE QUE SE TIENE LA INFORMACION DEBEMOS NOTIFICAR
      notifyListeners();
  }


//METODO PARA REALIZAR LAS PETICIONES ARTICULOS POR CATEGORIAS
  getArticlesByCategory( String category ) async {
//CON ESTA CONDICION PREGUNTAMOS QUE SI EN LA LISTA DE CATEGORIAS YA HAY INFORMACION 
//NOS DEVUELVE LA LISTA CARGADA
      if ( this.categoryArticles[category].length > 0 ) {
        this._isLoading = false;
        notifyListeners();
        return this.categoryArticles[category];
      }

      final url ='$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=ca&category=$category';
      final resp = await http.get(url);

      final newsResponse = newsResponseFromJson( resp.body );

      this.categoryArticles[category].addAll( newsResponse.articles );

      this._isLoading = false;
      notifyListeners();

  }


}




