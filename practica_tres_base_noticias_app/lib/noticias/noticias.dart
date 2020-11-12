import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noticias/noticias/noticia_deportes.dart';

import 'bloc/noticias_bloc.dart';
import 'noticia_negocios.dart';

class Noticias extends StatefulWidget {

  final NoticiasBloc bloc;
  Noticias({
    Key key,
    this.bloc
  }) : super(key: key);

  @override
  _NoticiasState createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias> {
  final _tabsList = [
    Tab(icon: Icon(Icons.article), text: "Deportes"),
    Tab(icon: Icon(Icons.description), text: "Negocios"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Noticias de la semana'),
          bottom: TabBar(
            tabs: _tabsList,
          ),
        ),
        body: BlocProvider(
          create: (context) {
            widget.bloc.add(GetNewsEvent());
            return widget.bloc;
          },
          child: BlocConsumer<NoticiasBloc, NoticiasState>(
            listener: (context, state) {
              //
            },
            builder: (context, state) {
              if (state is NoticiasSuccessState) {
                return TabBarView(
                  children: [
                    NoticiaDeportes(noticias: state.noticiasSportList),
                    NoticiaNegocios(noticias: state.noticiasBusinessList),
                  ],
                );
              } else if (state is FilteredNewsState) {
                return TabBarView(
                  children: [
                    NoticiaDeportes(noticias: state.noticiasSportList),
                    NoticiaNegocios(noticias: state.noticiasBusinessList),
                  ],
                );
              }
              return Center(
                child: Text("No hay noticias disponibles"),
              );
            },
          ),
        ),
      ),
    );
  }
}
