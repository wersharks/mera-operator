import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ConfirmUserScreen extends StatefulWidget {
  const ConfirmUserScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmUserScreen> createState() => _ConfirmUserScreenState();
}

class _ConfirmUserScreenState extends State<ConfirmUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFF4B3A),
        body: SlidingUpPanel(
          backdropEnabled: true,
          color: Colors.transparent,
          maxHeight: 300,
          minHeight: 250,
          defaultPanelState: PanelState.OPEN,
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
                ),
              )
            ],
          ),
          panel: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Slot 1:00 PM - 1:30 PM",
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                    subtitle: Text(
                      "Updation",
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w800, fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.black,
                      size: 40,
                    ),
                    subtitle: Text(
                      "B-116 Hostel C, Thapar University Patiala",
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w800, fontSize: 15),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.call,
                      color: Colors.greenAccent,
                      size: 40,
                    ),
                    title: Text(
                      "Call",
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w800, fontSize: 15),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF4B3A),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "Start Service",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
