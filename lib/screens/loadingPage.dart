import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:mera_operator/screens/modeSelectionPage.dart';
// import 'package:mera_operator/screens/onBoardingPage.dart';
import 'package:mera_operator/screens/verification.dart';
import 'package:mera_operator/screens/operator_bookings.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      (FirebaseAuth.instance.currentUser!=null)? Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => OperatorBookings())):
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => Verification()));
    });
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.png'),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 120,
              child: Image.asset(
                'assets/aadharlogo.png',
                width: 170,
                height: 170,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
