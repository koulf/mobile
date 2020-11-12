part of 'mis_noticias_bloc.dart';

abstract class MisNoticiasEvent extends Equatable {
  const MisNoticiasEvent();

  @override
  List<Object> get props => [];
}

class CrearNoticiaEvent extends MisNoticiasEvent {
  final String titulo;
  final String descripcion;
  final String autor;

  CrearNoticiaEvent(this.titulo, this.descripcion, this.autor);
}

class LeerNoticiasEvent extends MisNoticiasEvent {

}

class CargarImagenEvent extends MisNoticiasEvent {
  final bool takePicFromCamera;

  CargarImagenEvent(this.takePicFromCamera);

}