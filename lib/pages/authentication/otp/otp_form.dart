// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naheed_rider/pages/main/home_page.dart';
import 'package:naheed_rider/services/remote_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/constants.dart';
import '../../../components/size_config.dart';

class OTPForm extends StatefulWidget {
  final String qrCode;
  const OTPForm({super.key, required this.qrCode});

  @override
  State<OTPForm> createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  final textField1 = TextEditingController();
  final textField2 = TextEditingController();
  final textField3 = TextEditingController();
  final textField4 = TextEditingController();
  final textField5 = TextEditingController();
  final textField6 = TextEditingController();
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: getProportionateScreenWidth(50),
              child: TextFormField(
                controller: textField1,
                autofocus: false,
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
                controller: textField2,
                focusNode: focusNode2,
                autofocus: false,
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
                controller: textField3,
                focusNode: focusNode3,
                autofocus: false,
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
                controller: textField4,
                focusNode: focusNode4,
                autofocus: false,
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
                controller: textField5,
                focusNode: focusNode5,
                autofocus: false,
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
                controller: textField6,
                focusNode: focusNode6,
                autofocus: false,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                ),
                decoration: otpInputDecoration,
                onChanged: (value) {
                  focusNode6?.unfocus();
                  final otp = textField1.text +
                      textField2.text +
                      textField3.text +
                      textField4.text +
                      textField5.text +
                      textField6.text;
                  verifyOtp(otp);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const HomePage(),
                  //   ),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  verifyOtp(String otp) async {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );

    await EasyLoading.show(
        status: 'Verifying OTP........', maskType: EasyLoadingMaskType.black);
    final rider = await RemoteServices().verifyOTP(widget.qrCode, otp);
    print(rider);
    EasyLoading.dismiss();
    if (rider?[0].message == "") {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('cnic', rider?[0].data?.cnic ?? '');
      pref.setString('name', rider?[0].data?.name ?? '');
      pref.setString('id', rider?[0].data?.id ?? '');
      pref.setString('token', rider?[0].token ?? '');

      // ignore: use_build_context_synchronously
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      EasyLoading.showError(
        rider?[0].message ?? '',
        duration: const Duration(seconds: 3),
        dismissOnTap: false,
      );
    }
  }
}
