import 'dart:collection';
import 'dart:ffi';

import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import 'package:unihub_app/screens/addOffer/addOffer.dart';

class GMap extends StatefulWidget {
  GMap({Key key}) : super(key: key);

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;
  List<Marker> myMarker = [];
  String latitud;
  String longitud;
  List<String> coordenadas = [];

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
    // _setPolygons();
  }

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/unihubLogo.png');
    // Añadir el icono que queramos!!!
  }

  // void _setPolygons() {
  //   List<LatLng> polygonLatLongs = <LatLng>[];
  //   polygonLatLongs.add(LatLng(41.1,1.95));
  //   polygonLatLongs.add(LatLng(41.4,1.95));
  //   polygonLatLongs.add(LatLng(41.1,2.18));
  //   polygonLatLongs.add(LatLng(41.4,2.18));

  //   _polygons.add(
  //     Polygon(
  //       polygonId: PolygonId("0"),
  //       points: polygonLatLongs,
  //       fillColor: Colors.transparent,
  //       strokeWidth: 1,
  //     )
  //   );
  // }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Text("Location"),
              IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    print(coordenadas[1]);
                    Navigator.of(context).pop(coordenadas);
                  }),
            ])),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(41.3879, 2.16992),
                zoom: 13,
              ),
              markers: Set.from(myMarker),
              polygons: _polygons,
              onTap: _handleTap,
            ),
            // Para añadir cosas en el mapa que no estan fijas en el, sino como encima, que si mueves el mapa sigue estando en la pantalla
            Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Text("Whatever"))
          ],
        ));
  }

  _handleTap(LatLng tappedPoint) {
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
      latitud = tappedPoint.latitude.toString();
      longitud = tappedPoint.longitude.toString();
      coordenadas.add(latitud);
      coordenadas.add(longitud);
      return coordenadas;
    });
  }
}
