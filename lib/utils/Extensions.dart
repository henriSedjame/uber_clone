
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension Formating on LatLng {
  String format() {
    return '${this.latitude},${this.longitude}';
  }
}
