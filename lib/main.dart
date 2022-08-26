import 'package:flutter/material.dart';

import 'package:mera_operator/screens/confirmUserScreen.dart';
import 'package:mera_operator/screens/home_page.dart';
import 'package:mera_operator/screens/loadingPage.dart';
// import 'package:mera_aadhar/screens/loadingPage.dart';
import 'package:mera_operator/screens/verification.dart';
// import 'package:mera_aadhar/services/auth/otp_signin.dart';
import 'package:mera_operator/services/auth/operator_signin.dart';
import 'package:mera_operator/providers/map_provider.dart';
import 'package:mera_operator/screens/workList.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mera_operator/screens/finishpage.dart';
import 'package:mera_operator/screens/servicetimer.dart';
import 'package:mera_operator/screens/otpscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MapmyIndiaAccountManager.setMapSDKKey("b83ac7e5c93e97387c489386a49c7bbf"); 
  MapmyIndiaAccountManager.setRestAPIKey("b83ac7e5c93e97387c489386a49c7bbf"); 
  MapmyIndiaAccountManager.setAtlasClientId("33OkryzDZsKP92k_5IQbTQtdN8MJRMrgLjVOvWf3nnjE2Bx_42o5znUvuz5ak3y1GeS8pkpksgKK85cuukR78w=="); 
  MapmyIndiaAccountManager.setAtlasClientSecret("lrFxI-iSEg9tE2OsW8sZLwqexLcLSxycBLdukqxTw3WJF-Ckzcj5N2pkx3JcRGU9JvZ9bNfRv_gCGlMw9dYc6J8muOObOaLX");  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OperatorAuth()),
        ChangeNotifierProvider(create: (context) => MapProvider())
      ],
      child: MaterialApp(
        title: 'मेरा Operator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Verification(),
      ),
    );
  }
}
