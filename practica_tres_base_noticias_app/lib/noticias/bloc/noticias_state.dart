part of 'noticias_bloc.dart';

abstract class NoticiasState extends Equatable {
  const NoticiasState();

  @override
  List<Object> get props => [];
}

class NoticiasInitial extends NoticiasState {}

class NoticiasSuccessState extends NoticiasState {
  final List<Noticia> noticiasSportList;
  final List<Noticia> noticiasBusinessList;

  NoticiasSuccessState(
      {@required this.noticiasSportList, @required this.noticiasBusinessList});
  @override
  List<Object> get props => [noticiasSportList, noticiasBusinessList];
}

class FilteredNewsState extends NoticiasState {
  final List<Noticia> news;
  final List<Noticia> noticiasSportList;
  final List<Noticia> noticiasBusinessList;

  FilteredNewsState({@required this.news, @required this.noticiasSportList, @required this.noticiasBusinessList});

  @override
  List<Object> get props => [news, noticiasSportList, noticiasBusinessList];
}

class NoticiasErrorState extends NoticiasState {
  final String message;

  NoticiasErrorState({@required this.message});
}
