import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:mera_operator/services/auth/otp_signin.dart';
import 'package:mera_operator/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:mera_operator/utilities/size_config.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final _formKey = GlobalKey<FormState>();

  FocusNode mobileNumberFocusNode = FocusNode();
  FocusNode otpFocusNode = FocusNode();
  bool isOTPScreen = false;
  //final sizeConfig = SizeConfig();
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (isOTPScreen)
          ? FloatingActionButton(
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
              onPressed: ()async {

 if (isOTPScreen ) {
                          setState(() {
                            // Provider.of<Auth>(context, listen: false)
                            //     .isLoading = true;
                          });
                        //   await Provider.of<Auth>(context, listen: false)
                        //       .submitOTP(context);
                          setState(() {
                            // Provider.of<Auth>(context, listen: false)
                            //     .isLoading = false;
                          });
                        }


              },
            )
          : null,

      backgroundColor: Color(0xffF2F2F2),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
              'OPERATOR LOGIN',
              style: appBarTextStyle)),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: getProportionateScreenHeight(270),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.1),
                      offset: Offset(0, 0),
                      spreadRadius: .1,
                      blurRadius: 15),
                ],
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
                // border: Border.all(color: Colors.grey.withOpacity(.01))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(1),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/aadharlogo.png',
                      width: getProportionateScreenWidth(125),
                      height: getProportionateScreenHeight(112),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Login',
                          style:
                              textStyle.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(100),
                        child: Divider(
                          thickness: 3,
                          color: Color(0xffFA4A0C),
                          height: getProportionateScreenHeight(4),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            // Center(
            //   child: Image.asset(
            //     (!isOTPScreen)
            //         ? 'assets/verification1.png'
            //         : 'assets/verification2.png',
            //     width: 292,
            //     height: 200,
            //   ),
            // ),
            SizedBox(
              height: 30,
            ),
            if (isOTPScreen) Text('Enter OTP', style: oTextStyle),
            Text(
                "Please login!",
                style: textStyle),
            SizedBox(
              height: 20,
            ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      setState(() {});
                    },
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        counterText: '',
                        labelStyle: TextStyle(
                            color: mobileNumberFocusNode.hasFocus
                                ? Colors.orange
                                : Colors.black54),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Email',
                      ),

                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      setState(() {});
                    },
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        counterText: '',
                        labelStyle: TextStyle(
                            color: mobileNumberFocusNode.hasFocus
                                ? Colors.orange
                                : Colors.black54),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: 'Email',
                      ),

                    ),
                  ),
                ),
              ),

            // if (isOTPScreen)
            //   SizedBox(
            //     height: 10,
            //   ),
            // if (isOTPScreen)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn't get OTP? ", style: textStyle),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Resend',
                        style: TextStyle(color: Colors.red, fontSize: 17),
                      ))
                ],
              ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}