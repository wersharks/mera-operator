import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mera_operator/firebase/booking_db.dart';
import 'package:mera_operator/models/booking_model.dart';
import 'package:mera_operator/providers/map_provider.dart';
import 'package:mera_operator/screens/operator_bookings.dart';
import 'package:provider/provider.dart';

class WorkItem extends StatelessWidget {
  Booking bookingitem;

  WorkItem({required this.bookingitem});
  // const WorkItem({
  //   Key? key,
  // }) : super(key: key);

  Widget getServiceWidget(int bookingType, int userType){
    String s = bookingType == 0 ? "Updation, ":"Enrollment, ";
    if(userType == 0){
      s += "Specially-abled";
    } else if(userType == 1){
      s += "Senior citizen";
    }
    else if(userType == 3){
      s += "Specially-abled, Senior-citizen";
    }
    return Text(
      s,
      style:
          GoogleFonts.nunito(fontWeight: FontWeight.w300),
    );
  }

  @override
  Widget build(BuildContext context){
    return Column(
            children: [
                    Center(
                        child: Text(
                      '${bookingitem.slotTime}',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500)),
                    )),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      // height: 100,
                      width: 550,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              Provider.of<MapProvider>(context, listen: false).setFocusBooking(bookingitem);
                              Navigator.push(
                                context, MaterialPageRoute(builder: (context) => OperatorDirections()));
                            },
                            child: const Icon(
                              Icons.directions,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            "${bookingitem.userdata?.locationText}",
                            style:
                                GoogleFonts.nunito(fontWeight: FontWeight.w700),
                          ),
                          subtitle: getServiceWidget(bookingitem.bookingType!, 0),
                          trailing: GestureDetector(
                            onTap: () {
                              
                              
                            },
                            child: const Icon(
                              Icons.call,
                              size: 40,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
          );
  }
}

class WorkListScreen extends StatefulWidget {
  const WorkListScreen({Key? key}) : super(key: key);

  @override
  State<WorkListScreen> createState() => _WorkListScreenState();
}

class _WorkListScreenState extends State<WorkListScreen> {
  late Future<List<Booking>> listService;
  @override
  void initState() {
      super.initState();
      listService = BookingDB().getOperatorCurrentBooking();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFF4B3A),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 40,
              child: Image.asset(
                'assets/aadharlogo.png',
                width: 35,
                height: 35,
              ),
            ),
          ),
          
          const SizedBox(
            height: 9,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              width: MediaQuery.of(context).size.width,
              height: 700,
              child: Padding(
                padding: EdgeInsets.all(30),
                // child: Column(children: [
                //   // WorkItem(),
                // ],)
                child: FutureBuilder<List<Booking>>(
                        future: listService,
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              snapshot.connectionState == ConnectionState.done) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return WorkItem(bookingitem: (snapshot.data?[index])!);
                              },
                            );
                          }

                          /// handles others as you did on question
                          else {
                            return CircularProgressIndicator();
                          }
                        },

              ),
            ),
          ),
          )
        ],
      ),
    );
  }
}
