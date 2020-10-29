import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class HomeMap extends StatefulWidget {
  HomeMap({Key key}) : super(key: key);

  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {

  Set<Marker> _mapMarkers = Set();
  Set<Polygon> polygons = Set();
  List<LatLng> longPressMarkers = List();
  GoogleMapController _mapController;
  Position _currentPosition;
  Position _defaultPosition = Position(
    longitude: 20.608148,
    latitude: -103.417576,
  );

  bool created = false;
  int state = 0;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    
    return FutureBuilder(
      future: _mapMain(),
      builder: (context, result) {
        if (result.error == null) {
          if (_currentPosition == null) _currentPosition = _defaultPosition;
          return Scaffold(
            body: Stack(
              children: <Widget>[
                GoogleMap(
                  polygons: polygons,
                  onMapCreated: _onMapCreated,
                  markers: _mapMarkers,
                  onLongPress: _setMarker,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _currentPosition.latitude,
                      _currentPosition.longitude,
                    )
                  )
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width*0.05, vertical: width*0.1),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                    child: TextField(
                      onSubmitted: (value){
                        searchAddress(value);
                      },
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide.none
                        )
                      )
                    )
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(top: width*1.55, left: width - 80),
                  child: MaterialButton(
                    onPressed: (){
                      print(_mapMarkers.length);
                      addToPolygons();
                    },
                    child: Icon(Icons.crop_square, color: Colors.white),
                    color: Color(0xFF2196f3),
                    shape: CircleBorder(),
                  )
                )
              ]
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  state = 0;
                });
              },
              label: Icon(Icons.location_on),
            ),
          );
        } else {
          Scaffold(
            body: Center(child: Text("Error!")),
          );
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }



  Future<void> _mapMain() async {
    if(state == 0) {
      // get current position
      _currentPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      addMarker();
      positionate();
      state = 1;
    } else if (state == 3) {
      addMarker();
      positionate();
      state = 1;
    }
  }


  addToPolygons() {
    if(!created && longPressMarkers.isNotEmpty) {
      polygons.add(Polygon(
        fillColor: Colors.transparent,
        polygonId: PolygonId('test'),
        points: longPressMarkers,
        strokeColor: Colors.red
        )
      );
    } else
      polygons.clear();
    setState(() {
      state = 1;
      created = !created;
    });
  }

  searchAddress(String address) async {
    try {
      List<Placemark> places = await Geolocator().placemarkFromAddress(address);
      _currentPosition = places[0].position;
      setState(() {
        state = 3;
      });
    } catch (Platformexception) {
      print('couldn\'t find');
    }
  }

  _onMapCreated(controller) {
    setState(() {
      _mapController = controller;
    });
  }

  _setMarker(LatLng coord) async {
    // get address
    String _markerAddress = await _getGeolocationAddress(
      Position(latitude: coord.latitude, longitude: coord.longitude),
    );

    longPressMarkers.add(coord);

    // add marker
    setState(() {
      _mapMarkers.add(
        Marker(
          markerId: MarkerId(coord.toString()),
          position: coord,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          onTap: (){
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(_markerAddress, style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                  Text(_currentPosition.toString()),
                ]
              )),
              width: MediaQuery.of(context).size.width,
            )
          );
        }
        ),
      );
    });
  }

  addMarker() async {
    for (Marker m in _mapMarkers)
      if ((m.position.latitude - _currentPosition.latitude).abs() < 0.001 && (m.position.longitude - _currentPosition.longitude).abs() < 0.001)
        return;
    String _currentAddress = await _getGeolocationAddress(_currentPosition);
    // add marker
    _mapMarkers.add(
      Marker(
        markerId: MarkerId(_currentPosition.toString()),
        position: LatLng(
          _currentPosition.latitude,
          _currentPosition.longitude,
        ),
        onTap: (){
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(_currentAddress, style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                  Text(_currentPosition.toString()),
                ]
              )),
              width: MediaQuery.of(context).size.width,
            )
          );
        }
      ),
    );
  }

  positionate() {
    // move camera
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            _currentPosition.latitude,
            _currentPosition.longitude,
          ),
          zoom: 15.0,
        ),
      ),
    );
  }

  Future<String> _getGeolocationAddress(Position position) async {
    var places = await Geolocator().placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places != null && places.isNotEmpty) {
      final Placemark place = places.first;
      return "${place.thoroughfare}, ${place.locality}";
    }
    return "No address availabe";
  }
}
