import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/services.dart';
// import 'package:mera_operator/api/map_api.dart';

import 'package:mera_operator/services/snackbar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:location/location.dart';
import 'dart:typed_data';
// import 'package:mapmyindia_place_widget/mapmyindia_place_widget.dart';
import 'dart:convert';

import 'dart:async';
import 'package:async/async.dart' show StreamGroup;
import 'package:mera_operator/models/operator_data_model.dart';

class OperatorBookings extends StatefulWidget {
  const OperatorBookings({Key? key}) : super(key: key);

  @override
  State<OperatorBookings> createState() =>
      _OperatorBookingsState();
}

class _OperatorBookingsState extends State<OperatorBookings> {
  late MapmyIndiaMapController _mapController;
  LatLng pinLocation = LatLng(25.321684, 82.987289);
  Symbol? location_pin = null;
  var operatorMapPins = new Map();
  String _locationText = "...";
  
  String? _serviceError = '';
  final Location _locationService = Location();
  bool _liveUpdate = false;
  bool _permission = false;
  LocationData? _currentLocation;
  String? address = "Getting...";

  @override
  void initState() {
    super.initState();
    initLocationService();
    // openMapmyIndiaPlacePickerWidget();
  }

  void initLocationService() async {
    LocationData? location;
    bool serviceEnabled;
    bool serviceRequestResult;

    try {
      serviceEnabled = await _locationService.serviceEnabled();

      if (serviceEnabled) {
        final permission = await _locationService.requestPermission();
        _permission = permission == PermissionStatus.granted;

        await _locationService.changeSettings(
          accuracy: LocationAccuracy.high,
          interval: 1000,
        );

        if (_permission) {
          location = await _locationService.getLocation();
          _currentLocation = location;
          print(_currentLocation);
          // Symbol symbol = await _mapController.addSymbol(SymbolOptions(geometry: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!)));

        }
      } else {
        serviceRequestResult = await _locationService.requestService();
        if (serviceRequestResult) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      if (e.code == 'PERMISSION_DENIED') {
        _serviceError = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        _serviceError = e.message;
      }
      location = null;
    }
  }


  void addOrUpdateLocationMarker(LatLng latlng) async {
    print("Add or update location marker");
    if(location_pin == null){
      location_pin = await _mapController.addSymbol(SymbolOptions(
          draggable: true,
          iconSize: 1.5,
          geometry: latlng));
    } else {
      _mapController.updateSymbol(location_pin!, SymbolOptions(
          draggable: true,
          iconSize: 1.5,
          geometry: latlng));
    }

    await _mapController.easeCamera(
            CameraUpdate.newLatLngZoom(
                latlng, 14));
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return _mapController.addImage(name, list);
  }

//   void addOrUpdateOperatorLocation(OperatorData odata) async {
//     LatLng latlng = LatLng(odata.loc!.lat!, odata.loc!.lon!);
//     print("Show op ${odata.operatorId!} with latlon ${latlng.toJson()}");
//     SymbolOptions symops = SymbolOptions(
//         draggable: true,
//         iconImage: "icon",
//         iconSize: 0.5,
//         geometry: latlng);

//     if(operatorMapPins.containsKey(odata.operatorId!)){
//       // Update marker
//       Symbol sym = operatorMapPins[odata.operatorId!];
//       _mapController.updateSymbol(sym, symops);
//     } else {
//       Symbol sym = await _mapController.addSymbol(symops);
//       operatorMapPins[odata.operatorId!] = sym;
//     }
//   }

//   void registerDeregisterOperators() async {
//       String lat = pinLocation.latitude.toString();
//       String lon = pinLocation.longitude.toString();
//       StreamGroup<OperatorData> streamgroup = await getAllOperatorsByMyLatLong(lat, lon);

//       StreamSubscription<OperatorData> subscriber = streamgroup.stream.listen((OperatorData data) {
//         addOrUpdateOperatorLocation(data);
//         print("received data: ${data.toJson()}");
//       },
//       onError: (error) {
//           print("Error in multistream");
//           print(error);
//       },
//       onDone: () {
//           print('Stream closed!');
//       });
//   }

  @override
  Widget build(BuildContext context) {
    print("Widget finally rebuild");
    print(pinLocation);
    return Scaffold(
      backgroundColor: Color(0xFFFF4B3A),
      body: SlidingUpPanel(
        maxHeight: 280,
        minHeight: 150,
        backdropEnabled: true,
        color: Colors.transparent,
        panel: Container(
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.arrow_drop_up_outlined,
                size: 40,
              ),
              ListTile(
                leading: const Icon(
                  Icons.house,
                  color: Colors.black,
                  size: 36,
                ),
                title: Text(
                  _locationText,
                  style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                subtitle: Text(
                  'Mobile Number: 9305895903',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFB2B2B2),
                      fontSize: 16),
                ),
                trailing: IconButton(
                  icon: new Icon(Icons.edit),
                  highlightColor: Colors.pink,
                  onPressed: (){
                    // openMapmyIndiaPlacePickerWidget();
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 70,
                width: 315,
                decoration: BoxDecoration(
                    color: Color(0xFFF8774A),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    'Select an operator for yourself',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: CircleAvatar(
                backgroundColor: Color(0xFFF4F4F4),
                radius: 40,
                child: Image.asset(
                  'assets/aadharlogo.png',
                  width: 35,
                  height: 35,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Expanded(
                    child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 600,
                    child: MapmyIndiaMap(
                      initialCameraPosition: CameraPosition(
                        target: pinLocation,
                        zoom: 14.0,
                      ),
                      myLocationEnabled: true,
                      myLocationTrackingMode: MyLocationTrackingMode.Tracking,
                      onMapCreated: (map) async {
                        _mapController = map;
                      },
                      onStyleLoadedCallback: () {
                        addImageFromAsset("icon", "assets/operator_pin_icon.png");
                        // openMapmyIndiaPlacePickerWidget();
                      },
                    ),
                  ),
                )),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: SizedBox(
                          width: 140,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              ),
                              Text(
                                'Appointments',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
