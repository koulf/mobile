part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}


class InitialEvent extends MainEvent {
  List<Object> get props => [];
}

class AddressEvent extends MainEvent {

  final String address;

  AddressEvent({@required this.address});

  List<Object> get props => [];
}
