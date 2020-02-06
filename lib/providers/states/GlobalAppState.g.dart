// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GlobalAppState.dart';

// **************************************************************************
// DataGenerator
// **************************************************************************

abstract class _$GlobalAppStateLombok {
  /// Field
  LatLng _userPosition;
  LatLng _destinationPosition;
  LatLngBounds cameraBounds;
  Set<Marker> _markers;
  Set<Polyline> _polylines;
  Map<String, Polyline> _recentsDestinations;

  /// Setter

  void set_userPosition(LatLng _userPosition) {
    this._userPosition = _userPosition;
  }

  void set_destinationPosition(LatLng _destinationPosition) {
    this._destinationPosition = _destinationPosition;
  }

  void setCameraBounds(LatLngBounds cameraBounds) {
    this.cameraBounds = cameraBounds;
  }

  void set_markers(Set<Marker> _markers) {
    this._markers = _markers;
  }

  void set_polylines(Set<Polyline> _polylines) {
    this._polylines = _polylines;
  }

  void set_recentsDestinations(Map<String, Polyline> _recentsDestinations) {
    this._recentsDestinations = _recentsDestinations;
  }

  /// Getter
  LatLng get_userPosition() {
    return _userPosition;
  }

  LatLng get_destinationPosition() {
    return _destinationPosition;
  }

  LatLngBounds getCameraBounds() {
    return cameraBounds;
  }

  Set<Marker> get_markers() {
    return _markers;
  }

  Set<Polyline> get_polylines() {
    return _polylines;
  }

  Map<String, Polyline> get_recentsDestinations() {
    return _recentsDestinations;
  }
}
