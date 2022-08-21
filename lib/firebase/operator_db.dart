import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mera_operator/models/operator_model.dart';
import 'package:mera_operator/models/operator_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'dart:convert';

class OperatorDB {

CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('operators');

    Future<void> setOperatorData(String operatorId, OperatorData opdata) async{
        DatabaseReference ref = FirebaseDatabase.instance.ref("operators/"+operatorId);

        await ref.set(opdata.toJson());
    }
}