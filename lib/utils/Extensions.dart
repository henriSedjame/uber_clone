
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension LatLngExtensions on LatLng {
  String requestParamsFormat() {
    return '${this.latitude},${this.longitude}';
  }

  Future<String> completeAddress() async {
    var geolocator = Geolocator();
    var places = await geolocator.placemarkFromCoordinates(this.latitude, this.longitude);
    var place = places[0];
    return '${place.subThoroughfare} ${place.thoroughfare}';
  }

}

