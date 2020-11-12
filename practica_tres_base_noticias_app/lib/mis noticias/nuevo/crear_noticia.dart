import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noticias/mis%20noticias/bloc/mis_noticias_bloc.dart';

class CrearNoticia extends StatefulWidget {

  final MisNoticiasBloc bloc;

  CrearNoticia({
    Key key, 
    this.bloc
  }) : super(key: key);

  @override
  _CrearNoticiaState createState() => _CrearNoticiaState();
}

class _CrearNoticiaState extends State<CrearNoticia> {

  File loadedImage;
  TextEditingController tittleCtrl = new TextEditingController();
  TextEditingController descCtrl = new TextEditingController();
  TextEditingController authorCtrl = new TextEditingController();


  bool validate() {
    return tittleCtrl.text != '' && descCtrl.text != '' && authorCtrl.text != '' && loadedImage != null;
  }

  BuildContext contextUtil;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Crear noticia'),
      ),
      body: BlocProvider(
        create: (context) => MisNoticiasBloc(),
        child: BlocConsumer<MisNoticiasBloc, MisNoticiasState>(
          listener: (context, state) {
            if (state is NoticiaGuardadaState){
              tittleCtrl.clear();
              descCtrl.clear();
              authorCtrl.clear();
              loadedImage = null;
              widget.bloc.add(LeerNoticiasEvent());
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('Noticia creada'),
                    actions: [
                      FlatButton(onPressed: (){ Navigator.of(context).pop();}, child: Text('OK'))
                    ]
                  );
                }
              );
            } else if (state is NoticiasErrorState){
              tittleCtrl.clear();
              descCtrl.clear();
              authorCtrl.clear();
              loadedImage = null;
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(state.errorMessage),
                    actions: [
                      FlatButton(onPressed: (){ Navigator.of(context).pop();}, child: Text('OK'))
                    ]
                  );
                }
              );
            }
          },
          builder: (context, state) {
            contextUtil = context;
            if(state is ImagenCargadaState)
              loadedImage = state.imagen;
            return SingleChildScrollView (
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: width*0.2, bottom: width*0.1),
                      child: TextField(
                        controller: tittleCtrl,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'Título'
                        )
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: width*0.1),
                      child: TextField(
                        controller: descCtrl,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'Descripción'
                        )
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: width*0.1),
                      child: TextField(
                        controller: authorCtrl,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'Autor'
                        )
                      )
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.camera,
                            size: width*0.07,
                          ),
                          onTap: () {
                            BlocProvider.of<MisNoticiasBloc>(context).add(CargarImagenEvent(true));
                          },
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.photo,
                            size: width*0.07,
                          ),
                          onTap: () {
                            BlocProvider.of<MisNoticiasBloc>(context).add(CargarImagenEvent(false));
                          },
                        ),
                      ]
                    ),
                    loadedImage != null ?
                    Padding(
                      padding: EdgeInsets.all(width*0.1),
                      child: Image.file(loadedImage)
                    )
                    : Container()
                  ]
                )
              )
            );
          }
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if(validate())
            BlocProvider.of<MisNoticiasBloc>(contextUtil).add(CrearNoticiaEvent(
              tittleCtrl.text,
              descCtrl.text,
              authorCtrl.text
            ));
          else
            _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Por favor, llene los campos y añada una imagen')));
        }
      ),
    );
  }
}
