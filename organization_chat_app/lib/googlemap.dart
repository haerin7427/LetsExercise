
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;


class FindgymPage extends StatefulWidget {
  @override
  State<FindgymPage> createState() => _FindgymPageState();
}

class _FindgymPageState extends State<FindgymPage> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Hint',
                      )
                  ),
                  Container(
                    alignment: Alignment(1.0, 0.0),
                    child: Text('HI'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(35.95, 128.25),
                  zoom: 2,
                ),
                markers: _markers.values.toSet(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}