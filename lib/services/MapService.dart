import 'dart:convert';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:uber_clone/models/Trajet.dart';
import 'package:uber_clone/utils/ApiRoutes.dart';
import '../utils/Extensions.dart';
import '../utils/Secrets.dart';

class MapService {

  PolylinePoints polylinePoints = PolylinePoints();

  Stream<List<LatLng>> getTrajet(LatLng origin, LatLng destination) {
    return Stream<http.Response>.fromFuture(
        http
            .get(ApiRoutes.directionRoute(origin.format(), destination.format()))
    ).map((response){

      var decoded = jsonDecode(response.body);

      print('Response : $decoded');

      var trajet = Trajet.fromJson(decoded);


      var polyline = trajet.routes[0].polyline.points;

      List<PointLatLng> points = this.polylinePoints.decodePolyline(polyline);

      return points.map((p) => LatLng(p.latitude, p.longitude)).toList();
    });
  }

  Future<List<LatLng>> getPoints(LatLng origin, LatLng destination) async {
    return this.polylinePoints
        .getRouteBetweenCoordinates(API_KEY, origin.latitude, origin.longitude, destination.latitude, destination.longitude)
        .then((p) => p.map((p) => LatLng(p.latitude, p.longitude)).toList());
  }

}
