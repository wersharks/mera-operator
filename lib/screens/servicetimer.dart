import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mera_operator/screens/otpscreen.dart';

class servicetimer extends StatefulWidget {
  const servicetimer({Key? key}) : super(key: key);

  @override
  State<servicetimer> createState() => _servicetimerState();
}

class _servicetimerState extends State<servicetimer> {
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
                        'Service',
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
              ' Service Timer',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TweenAnimationBuilder<Duration>(
              duration: Duration(minutes: 20),
              tween: Tween(begin: Duration(minutes: 20), end: Duration.zero),
              onEnd: () {
                print('Timer ended');
              },
              builder: (BuildContext context, Duration value, Widget? child) {
                final minutes = value.inMinutes;
                final seconds = value.inSeconds % 60;
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text('$minutes:$seconds',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30)));
              }),
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Text(
              ' After completing service click DONE',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          SizedBox(
              width: 350,
              height: 60,
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffF8774A))),
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => OTPScreen())));
                  },
                  child: Text(
                    'Done Service',
                    style: GoogleFonts.nunito(
                      textStyle:
                          TextStyle(color: Color.fromARGB(255, 244, 240, 240)),
                    ),
                  )))
        ],
      )),
    );
  }
}
