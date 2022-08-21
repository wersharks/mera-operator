import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mera_operator/models/booking_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingDB {

CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('bookings');

    // Future<void> addNewBooking(Booking booking) {
    //   return _collectionRef
    //       .add(booking.toJson())
    //       .then((value) => print("Booking entry added"))
    //       .catchError((error) => print("Failed to add entry: $error"));
    // }

    Future<List<Booking>> getOperatorCurrentBooking() async {
        FirebaseAuth auth = FirebaseAuth.instance;

        print("my ph "+(auth.currentUser?.uid)!);

        QuerySnapshot snap = await _collectionRef
                                    .where('operatorId', isEqualTo: auth.currentUser?.uid)
                                    .orderBy('timestamp', descending: true)
                                    .get();

        List<Booking> bookins = [];
        for(int i=0; i<snap.size; i++){
            Booking b = Booking.fromJson(snap.docs[i].data() as Map<String, dynamic>);
            if(b.bookingStatus! != "Completed") continue;
            bookins.add(b);
        }

        return bookins;
    }

}