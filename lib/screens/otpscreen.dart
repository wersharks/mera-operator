import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class otpscreen extends StatefulWidget {
  const otpscreen({Key? key}) : super(key: key);

  @override
  State<otpscreen> createState() => _otpscreenState();
}

class _otpscreenState extends State<otpscreen> {
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
                            'Done Service',
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
              
             
              SizedBox(
                height: 30,
              ),

             
              
              

              
            ],
          )),
    );
  }
}
