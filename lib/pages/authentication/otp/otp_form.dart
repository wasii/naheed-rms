// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naheed_rider/pages/main/home_page.dart';
import 'package:naheed_rider/services/remote_services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
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
  @override
  void dispose() {
    super.dispose();
  }

  void nextField({String? value, FocusNode? focusNode}) {
    if ((value?.length ?? 0) == 1) {
      focusNode?.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: OTPTextField(
          length: 6,
          width: SizeConfig.screenWidth - 50,
          fieldWidth: 50,
          style: GoogleFonts.montserrat(
            fontSize: 25,
          ),
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldStyle: FieldStyle.box,
          onCompleted: (pin) {
            verifyOtp(pin);
          },
          onChanged: (value) {
            print(value);
          },
        ),
      ),
    );
  }

  verifyOtp(String otp) async {
    // return Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => HomePage(),
    //   ),
    // );

    await EasyLoading.show(
        status: 'Verifying OTP........', maskType: EasyLoadingMaskType.black);
    final rider = await RemoteServices().verifyOTP(widget.qrCode, otp);
    EasyLoading.dismiss();
    if (rider!.isEmpty) {
      EasyLoading.showError(
        InternetError,
        duration: Duration(seconds: 3),
      );
      return;
    }

    if (rider[0].message == "") {
      SharedPreferences pref = await SharedPreferences.getInstance();
      RiderID = rider[0].data?.id ?? '';
      pref.setString('cnic', rider[0].data?.cnic ?? '');
      pref.setString('name', rider[0].data?.name ?? '');
      pref.setString('id', rider[0].data?.id ?? '');
      pref.setString('token', rider[0].token);

      // ignore: use_build_context_synchronously
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      EasyLoading.showError(
        rider[0].message,
        duration: const Duration(seconds: 3),
        dismissOnTap: false,
      );
    }
  }
}
