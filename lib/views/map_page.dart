import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/providers/AppStateProvider.dart';
import 'package:uber_clone/views/current_text_field.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  GoogleMapController mapController;
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  AppStateProvider appStateProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    this.appStateProvider = Provider.of<AppStateProvider>(context);

    if(!this.appStateProvider.hasUserPosition()) {
      this.appStateProvider.getUserPosition((value){
        setState(() {
          this.locationController.text = value;
        });
      });
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          this.appStateProvider.hasUserPosition() ? this._buildGoogleMap() :
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
                    onSubmit: (dep) async {
                      await this.appStateProvider.setUserPosition(dep);
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  CurrentTextField(
                    hintText: 'Votre destination',
                    icon: Icons.directions_car,
                    controller: destinationController,
                    onSubmit: (dest) async {
                      if(this.locationController.text.isNotEmpty) {
                        await this.appStateProvider.request(dest, Theme.of(context).primaryColor, (value) {
                          this.mapController.animateCamera(CameraUpdate.newLatLng(value));
                        });
                      }

                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      this.mapController = controller;
    });
  }

  void _onCameaMove(CameraPosition position) {

  }

  GoogleMap _buildGoogleMap() {
    return GoogleMap(
      initialCameraPosition:
          CameraPosition(target: this.appStateProvider.get_appState().get_userPosition(), zoom: 150),
      markers: this.appStateProvider.get_appState().get_markers(),
      polylines: this.appStateProvider.get_appState().get_polylines(),
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      onMapCreated: _onMapCreated,
      onCameraMove: _onCameaMove,
    );
  }

}
