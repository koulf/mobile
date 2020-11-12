import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noticias/models/noticia.dart';
import 'package:path/path.dart' as Path;

part 'mis_noticias_event.dart';
part 'mis_noticias_state.dart';


class MisNoticiasBloc extends Bloc<MisNoticiasEvent, MisNoticiasState> {

  List<Noticia> _noticiasList = List();
  List<Noticia> get listaNoticias => _noticiasList;
  File image;


  MisNoticiasBloc() : super(MisNoticiasInitial());

  @override
  Stream<MisNoticiasState> mapEventToState(
    MisNoticiasEvent event
  ) async* {
    if(event is CrearNoticiaEvent){
      try {
        String imageUrl = await _uploadPicture(image);
        await _saveNew(
          event.titulo,
          event.descripcion,
          event.autor,
          imageUrl
        );
        yield NoticiaGuardadaState();
        //clear variables
      } catch (e) {
        yield NoticiasErrorState(errorMessage: 'No fue posible guardar la noticia');
        print("Error al guardar noticia \n$e");
      }
    }
    else if(event is LeerNoticiasEvent){
      try {
        await _getNews();
        yield NoticiasDescargadasState();
      } catch (e) {
        yield NoticiasErrorState(errorMessage: 'No fue posible descargar las noticias');
        print("Error reading: \n$e");
      }
    }
    else if(event is CargarImagenEvent) {
      try {
        image = await _chooseImage(event.takePicFromCamera);
        yield ImagenCargadaState(imagen: image);
      } catch (e) {
        print('Error seleccionando imagen: $e');
      }
    }
  }

  Future _getNews() async {
    // recuperar lista de docs guardados en Cloud firestore
    // mapear a objeto de dart (Apunte)
    // agregar cada ojeto a una lista
    
    var misNoticias = await FirebaseFirestore.instance.collection("noticias").get();
    _noticiasList = misNoticias.docs
      .map(
        (element) => Noticia(
          author: element['autor'],
          title: element['titulo'],
          description: element['descripcion'],
          urlToImage: element['imageUrl'],
          publishedAt: element['fecha']
        ),
      )
      .toList();
  }

  Future<void> _saveNew(
    String titulo,
    String descripcion,
    String autor,
    String imageUrl
  ) async {
    // Crea un doc en la collection de apuntes

    await FirebaseFirestore.instance.collection("noticias").doc().set({
      "titulo": titulo,
      "descripcion": descripcion,
      "autor": autor,
      "imageUrl": imageUrl,
      "fecha": DateTime.now().toString()
    });
  }

  Future<String> _uploadPicture(File image) async {
    String imagePath = image.path;
    // referencia al storage de firebase
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("practice3/${Path.basename(imagePath)}");

    // subir el archivo a firebase
    StorageUploadTask uploadTask = reference.putFile(image);
    await uploadTask.onComplete;

    // recuperar la url del archivo que acabamos de subir
    dynamic imageURL = await reference.getDownloadURL();
    return imageURL;
  }

  Future<File> _chooseImage(bool camera) async {
    final picker = ImagePicker();
    final PickedFile chooseImage = await picker.getImage(
      source: camera? ImageSource.camera : ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
    );
    return File(chooseImage.path);
  }
}