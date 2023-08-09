import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  final double lat;
  final double long;

  const MapScreen({Key? key, required this.lat, required this.long})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();

  LatLng pointClick = const LatLng(0, 0);
  var title = '';
  var icon =
      'https://cdn.meidounkar.com/content/website/vendor/leaflet/images/1.png';

  @override
  initState() {
    super.initState();
    pointClick = LatLng(widget.lat, widget.long);
    title = '${widget.lat} : ${widget.long}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: pointClick,
              zoom: 16,
              maxZoom: 18,
              minZoom: 13,
              onPositionChanged: (position, hasGesture) {
                if (hasGesture) {
                  setState(() {
                    pointClick = position.center!;
                    title =
                        '${position.center!.latitude} : ${position.center!.longitude}';
                  });
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'Fakhravari.ir',
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 50,
              height: 50,
              child: Image.network(icon),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  var getdata =
                      '${pointClick.latitude}:${pointClick.longitude}';

                  Navigator.of(context).pop(getdata);
                },
                child: const Text('گرفتن نقطه جدید'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
