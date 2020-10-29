part of 'main_bloc.dart';

abstract class MainState extends Equatable {
}

class InitialState extends MainState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class CurrentPositionState extends MainState {

  final Position position;

  CurrentPositionState({@required this.position});
  @override
  List<Object> get props => throw UnimplementedError();
}

class AddressState extends MainState {

  final Position position;
  final int result;

  AddressState({@required this.position, @required this.result});
  @override
  List<Object> get props => throw UnimplementedError();
}
