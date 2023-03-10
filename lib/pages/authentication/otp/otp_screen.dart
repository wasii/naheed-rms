// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:naheed_rider/components/constants.dart';
import 'package:naheed_rider/components/size_config.dart';

import 'otp_form.dart';

class OTPScreen extends StatefulWidget {
  final String qrCode;
  final String mobileNumber;
  const OTPScreen({super.key, required this.qrCode, required this.mobileNumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool enableButton = false;
  double time = 30.0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: Image.asset(
              'assets/backgrounds/login.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'OTP Verification',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: kPrimaryColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
                  child: Text(
                    'We sent your code to\n${widget.mobileNumber}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: kSecondaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                OTPForm(qrCode: widget.qrCode,),
                SizedBox(height: 50),
                SizedBox(height: 50),
              ],
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 40,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'This code will expired in ',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w200, fontSize: 18),
                    ),
                    TweenAnimationBuilder(
                      tween: Tween(begin: time, end: 0.0),
                      duration: Duration(seconds: time.toInt()),
                      builder: (context, value, child) => Text(
                        "00:${value.toInt().toString().padLeft(2, '0')}",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                      onEnd: () {
                        setState(() {
                          time = 0.0;
                          enableButton = true;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: enableButton ? () {
                    setState(() {
                      enableButton = false;
                      time = 30.0;
                    });
                  } : null,
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith(
                      (states) {
                        return kPrimaryColor;
                      },
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) {
                        return enableButton ? Colors.white : Colors.grey[400];
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: Text(
                    'Resend OTP',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
