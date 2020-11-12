part of 'noticias_bloc.dart';

abstract class NoticiasEvent extends Equatable {
  const NoticiasEvent();

  @override
  List<Object> get props => [];
}

class GetNewsEvent extends NoticiasEvent {}

class SearchNewsEvent extends NoticiasEvent {

  final String search;

  const SearchNewsEvent(this.search);
}
