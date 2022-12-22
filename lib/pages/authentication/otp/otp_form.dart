import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naheed_rider/pages/main/home_page.dart';

import '../../../components/constants.dart';
import '../../../components/size_config.dart';

class OTPForm extends StatefulWidget {
  const OTPForm({super.key});

  @override
  State<OTPForm> createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  FocusNode? focusNode2;
  FocusNode? focusNode3;
  FocusNode? focusNode4;
  FocusNode? focusNode5;
  FocusNode? focusNode6;

  @override
  void dispose() {
    focusNode2?.dispose();
    focusNode3?.dispose();
    focusNode4?.dispose();
    focusNode5?.dispose();
    focusNode6?.dispose();
    super.dispose();
  }

  void nextField({String? value, FocusNode? focusNode}) {
    if ((value?.length ?? 0) == 1) {
      focusNode?.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();
    focusNode6 = FocusNode();
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: getProportionateScreenWidth(50),
              child: TextFormField(
                autofocus: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                ),
                decoration: otpInputDecoration,
                onChanged: (value) {
                  nextField(value: value, focusNode: focusNode2);
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(50),
              child: TextFormField(
                focusNode: focusNode2,
                autofocus: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                ),
                decoration: otpInputDecoration,
                onChanged: (value) {
                  nextField(value: value, focusNode: focusNode3);
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(50),
              child: TextFormField(
                focusNode: focusNode3,
                autofocus: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                ),
                decoration: otpInputDecoration,
                onChanged: (value) {
                  nextField(value: value, focusNode: focusNode4);
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(50),
              child: TextFormField(
                focusNode: focusNode4,
                autofocus: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                ),
                decoration: otpInputDecoration,
                onChanged: (value) {
                  nextField(value: value, focusNode: focusNode5);
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(50),
              child: TextFormField(
                focusNode: focusNode5,
                autofocus: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                ),
                decoration: otpInputDecoration,
                onChanged: (value) {
                  nextField(value: value, focusNode: focusNode6);
                },
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(50),
              child: TextFormField(
                focusNode: focusNode6,
                autofocus: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                ),
                decoration: otpInputDecoration,
                onChanged: (value) {
                  focusNode6?.unfocus();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
