import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_clone/models/Trajet.dart';
import 'package:uber_clone/services/MapService.dart';
import 'package:uber_clone/views/current_text_field.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapService service = MapService();
  GoogleMapController mapController;
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  GoogleMap map;
  LatLng userPosition;
  LatLng _lastPosition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    this._getUserPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          this.userPosition!= null ? this._buildGoogleMap() :
              Container(
                child: Text('WAIT ....'),
              ),
          Positioned(
              top: 50.0,
              left: 15.0,
              right: 15.0,
              child: Column(
                children: <Widget>[
                  CurrentTextField(
                    hintText: 'D\'où partez vous?',
                    icon: Icons.location_on,
                    controller: locationController,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  CurrentTextField(
                    hintText: 'Votre destination',
                    icon: Icons.directions_car,
                    controller: destinationController,
                    onSubmit: (dest) => this.request(dest),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  void _addMarker(LatLng position, String dest) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          icon: BitmapDescriptor.defaultMarker,
          infoWindow:
              InfoWindow(title: "Destination", snippet: dest)));
    });
  }

  void _addPolyline(LatLng position, List<LatLng> points) {
    setState(() {
      _polylines.add(Polyline(
        polylineId: PolylineId(position.toString()),
        color: Theme.of(context).primaryColor,
        width: 5,
        points: points
      ));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      this.mapController = controller;
    });
  }

  void _onCameaMove(CameraPosition position) {
    setState(() {
      this._lastPosition = position.target;
    });
  }

  GoogleMap _buildGoogleMap() {
    return GoogleMap(
      initialCameraPosition:
          CameraPosition(target: this.userPosition, zoom: 50),
      markers: _markers,
      polylines: this._polylines,
      mapType: MapType.normal,
      onMapCreated: _onMapCreated,
      onCameraMove: _onCameaMove,
    );
  }

  void _getUserPosition() async {
    Geolocator geolocator = Geolocator();

    Position position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placeMarkes = await geolocator.placemarkFromCoordinates(
        position.latitude, position.longitude);
    setState(() {
      this.userPosition = LatLng(position.latitude, position.longitude);
      this.map = this._buildGoogleMap();
      var place = placeMarkes[0];
      this.locationController.text =
          '${place.subThoroughfare}  ${place.thoroughfare}';
    });
  }

  void request(String destination) async {
    List<Placemark> placemarkes =
        await Geolocator().placemarkFromAddress(destination);

    Placemark place = placemarkes[0];

    LatLng latLng = LatLng(place.position.latitude, place.position.longitude);

   // List<LatLng> points = await this.service.getPoints(this.userPosition, latLng);

    this.service.getTrajet(this.userPosition, latLng)
        .listen((points){

      this._addMarker(latLng, destination);

      this._addPolyline(latLng, points);

     this.mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 20))).then((v){});
    });

  }
}
