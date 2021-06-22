import 'dart:collection';

import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import 'package:unihub_app/i18N/appTranslations.dart';

class GMap extends StatefulWidget {
  GMap(this.lat, this.long);
  String lat;
  String long;
  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  Set<Polygon> _polygons = HashSet<Polygon>();
  GoogleMapController _mapController;
  List<Marker> myMarker = [];
  List<String> coordenadas = [];

  @override
  void initState() {
    _setMarkerIcon();
    super.initState();
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

  void _onMapCreated(GoogleMapController controller) {
    this._mapController = controller;

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
  }

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
          title: Text(AppLocalizations.instance.text("location")),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: this.widget.lat == null || this.widget.long == null
                    ? LatLng(41.3879, 2.16992)
                    : LatLng(double.parse(this.widget.lat),
                        double.parse(this.widget.long)),
                zoom: 13,
              ),
              markers: Set.from(myMarker),
              polygons: _polygons,
              onTap: _handleTap,
            ),
            // Para añadir cosas en el mapa que no estan fijas en el, sino como encima, que si mueves el mapa sigue estando en la pantalla
            /*Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Text("Whatever"))*/
          ],
        ));
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
