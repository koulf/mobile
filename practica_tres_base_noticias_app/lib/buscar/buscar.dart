import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noticias/noticias/bloc/noticias_bloc.dart';
import 'package:noticias/noticias/item_noticia.dart';

class Buscar extends StatefulWidget {

  final NoticiasBloc bloc;
  Buscar({
    Key key,
    this.bloc
  }) : super(key: key);

  @override
  _BuscarState createState() => _BuscarState();
}

class _BuscarState extends State<Buscar> {

  TextEditingController searchCtrl = TextEditingController();


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return widget.bloc;
        },
        child: BlocConsumer<NoticiasBloc, NoticiasState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(width*0.1),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                    child: TextField(
                      onSubmitted: (value){
                        print(value);
                        widget.bloc.add(SearchNewsEvent(value));
                      },
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Buscar',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide.none
                        )
                      )
                    )
                  )
                ),
                state is FilteredNewsState ? 
                  state.news.length > 0 ?
                    Expanded( child: ListView.builder(
                      itemCount: state.news.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemNoticia(noticia: state.news[index]);
                      },
                    ))
                  : Center(child:Text('Sin resultados'))
                : Container(),
              ]
            );
          }
        )
      )
    );
  }
}
