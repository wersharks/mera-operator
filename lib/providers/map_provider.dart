import 'package:flutter/cupertino.dart';
import 'package:mera_operator/models/booking_model.dart';
import 'package:mera_operator/models/operator_model.dart';

class MapProvider extends ChangeNotifier {
    // LatLng? focusLocation;
    var userMapPins = new Map();
    String locationText = "Loading requests!";
    void setPins(final map) {
        userMapPins = map;
        locationText = "You have ${userMapPins.length} requests for service!";
        notifyListeners();
    }

    bool isUserClick = false;
    Booking? currentBooking;

    void setFocusBooking(Booking booking) async{
      currentBooking = booking;
      isUserClick = true;
      notifyListeners();
    }

    void removeFocus() async{
      isUserClick = false;
      notifyListeners();
    }

}
