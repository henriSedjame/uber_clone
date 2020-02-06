import 'dart:core';
import 'Secrets.dart';

class ApiRoutes {

  static final String DIRECTIONS_API_BASE_ROUTE = 'https://maps.googleapis.com/maps/api/directions/json?';

  static String directionRoute(String origin, String destination) {
    return DIRECTIONS_API_BASE_ROUTE + 'origin=$origin&destination=$destination&key=$API_KEY';
  }

}
