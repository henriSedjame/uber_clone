import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lombok/lombok.dart';

part 'GlobalAppState.g.dart';

@data
class GlobalAppState with _$GlobalAppStateLombok {

  LatLng _userPosition;
  LatLng _destinationPosition;
  LatLngBounds cameraBounds;
  Set<Marker> _markers;
  Set<Polyline> _polylines;
  Map<String, Polyline> _recentsDestinations;

  GlobalAppState.init() {
    this._markers = {};
    this._polylines = {};
    this._recentsDestinations = <String, Polyline>{};
  }
}
