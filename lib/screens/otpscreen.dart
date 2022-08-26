import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mera_operator/screens/finishpage.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton(
        child: Container(
            width: 60,
            height: 60,
            child: Icon(
              Icons.arrow_forward,
              size: 30,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Color(0xffF8774A), Color(0xffF8774A)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft))),
        onPressed: () {
     
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => FinishPage()));
          
        },
      ),
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
