import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mera_operator/screens/finishpage.dart';
import 'package:mera_operator/services/auth/operator_signin.dart';
import 'package:mera_operator/utilities/size_config.dart';
import 'package:provider/provider.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../utilities/constants.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  FocusNode otpFocusNode = FocusNode();
   final _formKey = GlobalKey<FormState>();
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

            Text('Enter OTP', style: oTextStyle),
            Text( 'Enter the OTP received from user.',
                style: textStyle),
            SizedBox(
              height: 20,
            ),
           
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Focus(
                  focusNode: otpFocusNode,
                  child: OtpTextField(
                    onSubmit: (value) {
                      Provider.of<OperatorAuth>(context, listen: false).otp = value;
                      print(value);
                    },
                    cursorColor:
                        otpFocusNode.hasFocus ? Colors.orange : Colors.black54,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    filled: true,
                    fillColor: Colors.white,
                    borderColor: Colors.white,
                    focusedBorderColor: Colors.white,
                    enabledBorderColor: Colors.white,
                    showFieldAsBox: true,
                    numberOfFields: 6,
                  ),
                ),
              ),
           
              SizedBox(
                height: 10,
              ),
      
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
       SizedBox(
              width: 325,
              height: getProportionateScreenHeight(50),
              child: !Provider.of<OperatorAuth>(context).isLoading
                  ? TextButton(
                      style: buttonStyle,
                      onPressed: () async {
                        
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            Provider.of<OperatorAuth>(context, listen: false)
                                .isLoading = true;
                          });
                          await Provider.of<OperatorAuth>(context, listen: false)
                              .submitPhoneNumber(context);
                          setState(() {
                            Provider.of<OperatorAuth>(context, listen: false)
                                .isLoading = false;
                    
                            
                          });
                        }
                       
                      },
                      child: Text(
                       'Request OTP',
                        style: buttonTextStyle,
                      ))
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.redAccent,
                      ),
                    ),)
              
              

              
            ],
          )),
    );
  }
}
