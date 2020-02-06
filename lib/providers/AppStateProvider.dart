
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lombok/lombok.dart';
import 'package:uber_clone/providers/states/GlobalAppState.dart';
import 'package:uber_clone/services/MapService.dart';
import 'package:uber_clone/utils/Functions.dart';

part 'AppStateProvider.g.dart';

@getter
class AppStateProvider extends ChangeNotifier with _$AppStateProviderLombok {

  MapService _service;
  GlobalAppState _appState;

  AppStateProvider(){
    this._appState = GlobalAppState.init();
    this._service = MapService();
  }

  void _addMarker(LatLng position, String dest) {

    this._appState.get_markers().clear();

    this._appState.get_markers().add(Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow:
        InfoWindow(title: "Destination", snippet: dest)));
  }

  void _addPolyline(LatLng position, String destination, List<LatLng> points, Color color) {

    this._appState.get_polylines().clear();

    var polyline = Polyline(
        polylineId: PolylineId(position.toString()),
        color: color,
        width: 5,
        points: points
    );

    this._appState.get_recentsDestinations().putIfAbsent(destination, () => polyline);

    this._appState.get_polylines().add(polyline);
  }

  bool hasUserPosition() => this._appState.get_userPosition() != null;

  Future<Null> getUserPosition(ObjectConsumer consumer) async {

    Geolocator geolocator = Geolocator();

    Position position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placeMarkes = await geolocator.placemarkFromCoordinates(
        position.latitude, position.longitude);

    this._appState.set_userPosition(LatLng(position.latitude, position.longitude));

    var place = placeMarkes[0];

    consumer('${place.subThoroughfare}  ${place.thoroughfare}');

    notifyListeners();
  }

  Future<Null> setUserPosition(String departure) async {
    LatLng depPosition = await _positionFromAdress(departure);
    this._appState.set_userPosition(depPosition);
    notifyListeners();
  }

  Future<Null> request(String destination, Color color, ObjectConsumer<LatLng> consumer) async {

    LatLng destPosition = await _positionFromAdress(destination);

    List<LatLng> points = await this._service.getPoints(this._appState.get_userPosition(), destPosition);

    this._addMarker(destPosition, destination);

    this._addPolyline(destPosition, destination, points, color);

    consumer(destPosition);

    notifyListeners();
  }

  Future<LatLng> _positionFromAdress(String destination) async {

    List<Placemark> placemarkes = await Geolocator().placemarkFromAddress(destination);

    Placemark place = placemarkes[0];

    LatLng destPosition = LatLng(place.position.latitude, place.position.longitude);

    return destPosition;
  }

}
