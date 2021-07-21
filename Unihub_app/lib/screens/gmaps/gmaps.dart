import 'dart:async';

import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import 'package:unihub_app/i18N/appTranslations.dart';
import 'package:location/location.dart';

class GMap extends StatefulWidget {
  GMap(this.lat, this.long);
  String lat = "41.3879";
  String long = "2.16992";
  String actualLat;
  String actualLong;
  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  Completer<GoogleMapController> _mapController = Completer();
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  List<Marker> myMarker = [];
  List<String> coordenadas = [];

  @override
  void initState() {
    _setMarkerIcon();
    super.initState();
  }

  _locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    await location.getLocation().then((res) async {
      final GoogleMapController controller = await _mapController.future;
      final _position = CameraPosition(
        target: LatLng(res.latitude, res.longitude),
        zoom: 12,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(_position));
    });
  }

  void _setMarkerIcon() async {
    // Añadir el icono que queramos!!!
    if (this.widget.lat != null || this.widget.long != null) {
      coordenadas.add(this.widget.lat);
      coordenadas.add(this.widget.long);
      setState(() {
        myMarker = [];
        myMarker.add(
          Marker(
              markerId: MarkerId("0"),
              position: LatLng(double.parse(this.widget.lat),
                  double.parse(this.widget.long)),
              draggable: true,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueAzure),
              onDragEnd: (dragEndPosition) {
                print(dragEndPosition);
              }),
        );
      });
    }
  }

/*
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("0"),
        position: LatLng(41.275555, 1.9869444),
        infoWindow: InfoWindow(
          title: "EETAC",
          snippet: "Aerospacials & Telecos",
        ),
        icon: _markerIcon,
      ));
    });*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: [
          this.coordenadas.length == 0
              ? IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    coordenadas.add(this.widget.lat);
                    coordenadas.add(this.widget.long);
                    Navigator.of(context).pop(coordenadas);
                  })
              : Container(),
        ],
        title: Text(AppLocalizations.instance.text("location", null)),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
        initialCameraPosition: CameraPosition(
          target: this.widget.lat == null || this.widget.long == null
              ? LatLng(41.3879, 2.16992)
              : LatLng(double.parse(this.widget.lat),
                  double.parse(this.widget.long)),
          zoom: 13,
        ),
        markers: Set.from(myMarker),
        onTap: _handleTap,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching_outlined),
          onPressed: () => _locateMe()),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  _handleTap(LatLng tappedPoint) {
    if (this.coordenadas.length == 0) {
      print(tappedPoint);
      setState(() {
        myMarker = [];
        myMarker.add(
          Marker(
              markerId: MarkerId(tappedPoint.toString()),
              position: tappedPoint,
              draggable: true,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
              onDragEnd: (dragEndPosition) {
                print(dragEndPosition);
              }),
        );
        this.widget.lat = tappedPoint.latitude.toString();
        this.widget.long = tappedPoint.longitude.toString();
      });
    } else {}
  }
}
