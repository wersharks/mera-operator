import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkListScreen extends StatefulWidget {
  const WorkListScreen({Key? key}) : super(key: key);

  @override
  State<WorkListScreen> createState() => _WorkListScreenState();
}

class _WorkListScreenState extends State<WorkListScreen> {
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
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      'Slot 1:00-1:30',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w500)),
                    )),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 100,
                      width: 550,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: ListTile(
                          leading: GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.directions,
                              size: 50,
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            "B-116, Hostel C, Thapar University",
                            style:
                                GoogleFonts.nunito(fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            "Updation, Senior Citizen, Handicaped",
                            style:
                                GoogleFonts.nunito(fontWeight: FontWeight.w300),
                          ),
                          trailing: GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.call,
                              size: 40,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
