part of 'mis_noticias_bloc.dart';


abstract class MisNoticiasState extends Equatable {
  const MisNoticiasState();

  @override
  List<Object> get props => [];
}


class MisNoticiasInitial extends MisNoticiasState {}


class NoticiasDescargadasState extends MisNoticiasState {

  @override
  List<Object> get props => [];
}

class NoticiaGuardadaState extends MisNoticiasState {

  @override
  List<Object> get props => [];
}

class NoticiasErrorState extends MisNoticiasState {
  final String errorMessage;

  NoticiasErrorState({this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class ImagenCargadaState extends MisNoticiasState {
  final File imagen;

  ImagenCargadaState({this.imagen});

  @override
  List<Object> get props => [imagen];
}