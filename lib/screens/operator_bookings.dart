import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:mera_operator/services/auth/operator_signin.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/services.dart';
// import 'package:mera_operator/api/map_api.dart';

import 'package:mera_operator/services/snackbar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
// import 'package:location/location.dart';
import 'dart:typed_data';
// import 'package:mapmyindia_place_widget/mapmyindia_place_widget.dart';
import 'dart:convert';

import 'dart:async';
import 'package:async/async.dart' show StreamGroup;
import 'package:mera_operator/firebase/booking_db.dart';
import 'package:mera_operator/firebase/operator_db.dart';
import 'package:mera_operator/models/operator_data_model.dart';
import 'package:mera_operator/models/booking_model.dart';
import 'package:background_location/background_location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mera_operator/providers/map_provider.dart';
import 'package:provider/provider.dart';

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
  OperatorDB _odb = new OperatorDB();

  String? _serviceError = '';
  final Location _locationService = Location();
  bool _liveUpdate = false;
  bool _permission = false;
  // LocationData? _currentLocation;
  String? address = "Getting...";
  String _locationText = "Loc";

  Map symbolIdtoBooking = {};
  Symbol? lastClickSymbol;

  @override
  void initState() {
    super.initState();
    // initLocationService();
    backgroundPermissionService();
    // openMapmyIndiaPlacePickerWidget();
  }

  void sendToFirebase(double? lat, double? lon) async {
    String opid = (FirebaseAuth.instance.currentUser?.uid)!;
    OperatorData od = new OperatorData();
    od.operatorId = opid;
    od.loc = new Loc(lat: lat, lon: lon);
    od.timestamp = DateTime.now().millisecondsSinceEpoch;
    _odb.setOperatorData(opid, od);
  }

  void backgroundPermissionService() async {
    await BackgroundLocation.stopLocationService();

    await BackgroundLocation.setAndroidNotification(
      title: 'Your(Operator) location is being tracked',
      message: 'Users can see your live location',
      icon: '@mipmap/ic_launcher',
    );
    await BackgroundLocation.startLocationService(
      distanceFilter: 20);
      BackgroundLocation.getLocationUpdates((location) {
        sendToFirebase(location.latitude, location.longitude);
      });

  }

  SymbolOptions createNormalSymbol(LatLng latLng){
      return SymbolOptions(
          draggable: true,
          iconImage: "iconuser",
          iconSize: 0.5,
          geometry: latLng);
  }

  SymbolOptions createHighlightSymbol(LatLng latLng){
      return SymbolOptions(
          draggable: true,
          iconImage: "iconuser",
          iconSize: 0.66,
          geometry: latLng);
  }


  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return _mapController.addImage(name, list);
  }

  void addBookingRequestPins(BuildContext context) async {
    print("bookings request pin");
    BookingDB bdb = new BookingDB();
    List<Booking> lst = await bdb.getOperatorCurrentBooking();
    print("list size ${lst.length}");
    
    // _locationText = "You have ${lst.length} requests for service!";
    // _locationText = "lloaed";
    var pins = new Map();
    for(final e in lst){
      var booking = e;
      LatLng latlng = LatLng(booking.bookingLocation!.lat!, booking.bookingLocation!.lon!);

      SymbolOptions symops = createNormalSymbol(latlng);
      Symbol sym = await _mapController.addSymbol(symops);
      pins[booking.bookingId!] = sym;
      symbolIdtoBooking[sym.id] = booking;
      
    }
    Provider.of<MapProvider>(context, listen: false).setPins(pins);
  }

  void utilHighlightOperator(Symbol symbol, bool highlight) async {
    SymbolOptions change;
    if(highlight){
      change = createHighlightSymbol(symbol.options.geometry!);
    }
    else {
      change = createNormalSymbol(symbol.options.geometry!);
    }
    await _mapController.updateSymbol(symbol, change);
  }


  void symbolCallback(BuildContext context, Symbol symbol){
    if(lastClickSymbol != null){
      utilHighlightOperator(lastClickSymbol!, false);
      if(lastClickSymbol! == symbol){
        Provider.of<MapProvider>(context, listen: false).removeFocus();
        lastClickSymbol = null;
        return;
      }
    }
    utilHighlightOperator(symbol, true);

    Booking booking = symbolIdtoBooking[symbol.id];
    Provider.of<MapProvider>(context, listen: false).setFocusBooking(booking);

    print("Clicked on booking with user ${booking.bookingId}");
    lastClickSymbol = symbol;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF4B3A),
      body: SlidingUpPanel(
        maxHeight: 350,
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
          child: Consumer<MapProvider>(
            builder: (context, model, child) {
              if(!model.isUserClick){
                  return Column(
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
                          model.locationText,
                          style: GoogleFonts.poppins(
                            textStyle:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                          subtitle: Text(
                            'Good luck in serving all!',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFB2B2B2),
                                fontSize: 16),
                          ),
                          trailing: IconButton(
                            icon: new Icon(Icons.refresh),
                            highlightColor: Colors.pink,
                            onPressed: () async{
                              // await _mapController.clearSymbols();
                              // addBookingRequestPins();
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
                              'Select user to service!',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                  );
              
              }
              else {
                return Column(
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
                          model.currentBooking!.bookingType! == 0 ? "Updation" : "New Enrollment",
                          style: GoogleFonts.poppins(
                            textStyle:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                          subtitle: Text(
                            model.currentBooking!.userdata!.locationText!,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFB2B2B2),
                                fontSize: 16),
                          ),
                          trailing: IconButton(
                            icon: new Icon(Icons.refresh),
                            highlightColor: Colors.pink,
                            onPressed: () async{
                              // await _mapController.clearSymbols();
                              // addBookingRequestPins();
                            },
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 315,
                          child: Row (
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox.fromSize(
                              size: Size(65, 65), // button width and height
                              child: ClipOval(
                                child: Material(
                                  color: Colors.lightGreen, // button color
                                  child: InkWell(
                                    splashColor: Colors.green, // splash color
                                    onTap: () {}, // button pressed
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.call),
                                        Text("Call"), // icon // text
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox.fromSize(
                              size: Size(65, 65), // button width and height
                              child: ClipOval(
                                child: Material(
                                  color: Colors.orange, // button color
                                  child: InkWell(
                                    splashColor: Colors.blue, // splash color
                                    onTap: () {}, // button pressed
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.directions), // icon
                                        Text("Nav"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]
                        ),
                        
                        ),
                        
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 70,
                          width: 315,
                          decoration: BoxDecoration(
                              color: Color(0xFFF8774A),
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              'Confirmation OTP',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                  );
              
              }
            },
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
                        _mapController.onSymbolTapped.add((Symbol symbol){
                          symbolCallback(context, symbol);
                        });
                      },
                      onStyleLoadedCallback: () {
                        addImageFromAsset("iconuser", "assets/userpin_blue.png");
                        addBookingRequestPins(context);
                        // openMapmyIndiaPlacePickerWidget();
                      },
                    ),
                  ),
                )),
                GestureDetector(
                  onTap: () {
                    Provider.of<OperatorAuth>(context, listen: false).oplogout(context);
                  },
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
                                'Logout',
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
