import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noticias_mundiales/src/pages/tabs_page.dart';
import 'package:noticias_mundiales/src/services/news_service.dart';
import 'package:noticias_mundiales/src/theme/tema.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light );

    
    return MultiProvider(
      //Implementamos provider
      providers: [
        
        ChangeNotifierProvider(create: (_)=> new NewsService() ),
      ],
      child: MaterialApp(
        title: 'Material App',
        theme: miTema,
        debugShowCheckedModeBanner: false,
        home: TabsPage()
      ),
    );
  }
}