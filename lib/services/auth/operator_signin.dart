import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mera_operator/screens/verification.dart';
import 'package:mera_operator/screens/workList.dart';
import 'package:provider/provider.dart';
import 'package:mera_operator/services/snackbar.dart';
import 'package:mera_operator/screens/operator_bookings.dart';

class OperatorAuth extends ChangeNotifier {
    String email = 'Unknown';
    String password = 'Unknown';
    User? _operatorUser;

    void setOperatorLogin(String email, String password){
        this.email = email;
        this.password = password;
    }

    Future<void> oplogin(BuildContext context) async {
        print("Atleast try to login pal");

        try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: this.email,
            password: this.password
        );
        _operatorUser = userCredential.user;
        
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => WorkListScreen()));

        showSnackBar('Operator Logged In!', context);

        } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
            showSnackBar('No user found for that email.', context);
        } else if (e.code == 'wrong-password') {
            showSnackBar('Wrong password provided for that user.', context);
        }
        }

        notifyListeners();
    }


    Future<void> oplogout(BuildContext context) async {
        try {
        // signout code
        await FirebaseAuth.instance.signOut();
    
        _operatorUser = null;
        final snackBar = SnackBar(content: Text('Operator Logged Out!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        
        } catch (e) {
        final snackBar = SnackBar(content: Text(e.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Verification()));


        notifyListeners();
    }


}