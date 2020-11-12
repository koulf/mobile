import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noticias/mis%20noticias/bloc/mis_noticias_bloc.dart';

import 'noticia_card.dart';

class MisNoticias extends StatefulWidget {

  final MisNoticiasBloc bloc;

  MisNoticias({
    Key key,
    this.bloc
  }) : super(key: key);

  @override
  _MisNoticiasState createState() => _MisNoticiasState();
}

class _MisNoticiasState extends State<MisNoticias> {
  @override
  Widget build(BuildContext context) {
    
    double width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis noticias"),
      ),
      body: BlocProvider(
        create: (context) {
          return widget.bloc;
        },
        child: BlocConsumer<MisNoticiasBloc, MisNoticiasState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (widget.bloc.listaNoticias.length > 0)
              return ListView.builder(
                  itemCount: widget.bloc.listaNoticias.length,
                  itemBuilder: (BuildContext context, int index) {
                    if(index == 0)
                      return Padding(
                        padding: EdgeInsets.only(top: width*0.1),
                        child: NoticiaCard(
                          noticia: widget.bloc.listaNoticias[index]
                        )
                      );
                    else
                      return NoticiaCard(
                        noticia: widget.bloc.listaNoticias[index]
                      );
                  },

              );
            else
              return Center(child: Text('No hay noticias guardadas'));
          }
        )
      )
    );
  }
}
