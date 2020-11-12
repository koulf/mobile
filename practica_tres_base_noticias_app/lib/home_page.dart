import 'package:flutter/material.dart';
import 'package:noticias/buscar/buscar.dart';
import 'package:noticias/noticias/bloc/noticias_bloc.dart';
import 'package:noticias/noticias/noticias.dart';

import 'mis noticias/bloc/mis_noticias_bloc.dart';
import 'mis noticias/creadas/mis_noticias.dart';
import 'mis noticias/nuevo/crear_noticia.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;


  MisNoticiasBloc misNoticiasBloc = MisNoticiasBloc();
  NoticiasBloc noticiasBloc = NoticiasBloc();

  @override
  void dispose() {
    // cerrar bloc
    misNoticiasBloc.close();
    noticiasBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _pagesList = [
      Noticias(bloc: noticiasBloc),
      Buscar(bloc: noticiasBloc),
      MisNoticias(bloc: misNoticiasBloc),
      CrearNoticia(bloc: misNoticiasBloc)
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pagesList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedItemColor: Colors.black38,
        selectedItemColor: Colors.indigo,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          if(index == 2)
            misNoticiasBloc.add(LeerNoticiasEvent());
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            label: "Noticias",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Buscar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks),
            label: "Mis noticias",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.subject,
            ),
            label: "Agregar noticia",
          ),
        ],
      ),
    );
  }
}
