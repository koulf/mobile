import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

part 'main_event.dart';
part 'main_state.dart';




class MainBloc extends Bloc<MainEvent, MainState> {
  
  MainBloc() : super(InitialState());

  Position currentPosition;

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if(event is InitialEvent){
      await getCurrentPosition();
      yield CurrentPositionState(position: currentPosition);
    } else if (event is AddressEvent) {
      int result = await searchAddress(event.address);
      yield AddressState(position: currentPosition, result: result);
    }
  }

  getCurrentPosition() async {
    currentPosition = await Geolocator().getCurrentPosition();
  }

  searchAddress(String address) async {
    print('searching: $address');
    try {
      List<Placemark> places = await Geolocator().placemarkFromAddress(address);
      print('length: ${places.length}');
      currentPosition = places[0].position;
      return 0;
    } catch (Platformexception) {
      print('couldn\'t find');
      return 1;
    }
  }
}
