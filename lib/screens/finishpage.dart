import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class FinishPage extends StatefulWidget {
  const FinishPage({Key? key}) : super(key: key);

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      extendBodyBehindAppBar: true,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 270,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.1),
                    offset: Offset(0, 0),
                    spreadRadius: .1,
                    blurRadius: 15),
              ],
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              // border: Border.all(color: Colors.grey.withOpacity(.01))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 1,
                ),
                Center(
                  child: Image.asset(
                    'assets/aadharlogo.png',
                    width: 125,
                    height: 112,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Finish',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Divider(
                        thickness: 3,
                        color: Color(0xffFA4A0C),
                        height: 4,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Text(
              'You are all done!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/checked.png',
            width: 166,
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
              width: 350,
              height: 60,
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffF8774A))),
                  onPressed: () async {},
                  child: Text(
                    'Next Booking',
                    style: GoogleFonts.nunito(
                      textStyle:
                          TextStyle(color: Color.fromARGB(255, 250, 248, 248)),
                    ),
                  )))
        ],
      )),
    );
  }
}
