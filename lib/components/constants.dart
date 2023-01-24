// ignore_for_file: constant_identifier_names, prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables, prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:naheed_rider/components/size_config.dart';

// Colos that use in our app
const kPrimaryColorString = '465263';
const kPrimaryColor = Color(0xFF0066A8);
const kSecondaryColor = Color.fromARGB(255, 0, 153, 255);
const kTextColor = Color(0xFF12153D);
const kTextLightColor = Color(0xFF9A9BB2);
const kFillStarColor = Color(0xFFFCC419);
const kErrorBackColor = Color(0xFFC72C41);

const kDefaultPadding = 20.0;

const kDefaultShadow = BoxShadow(
  offset: Offset(0, 0),
  blurRadius: 10,
  color: Colors.black26,
);

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(
    vertical: getProportionateScreenWidth(15),
  ),
  enabledBorder: outlinedBorder(),
  focusedBorder: outlinedBorder(),
);

OutlineInputBorder outlinedBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(
      color: kPrimaryColor,
    ),
  );
}

String RiderID = '';
String InternetError = 'Connect your device with internet first.....';
String SomethingWentWrong = 'Something Went Wrong\nPlease try again.';
String Success = 'Success';
const poweredString = 'Powered by NaheedPk';

//URLs
const BaseURL = "https://insightopsmagento4.naheed.pk/";
const LoginURL = BaseURL + "index.php/rest/V1/naheed-rms/login?rider_qr=";
const VerifyOTP = BaseURL + "index.php/rest/V1/naheed-rms/otpverify?rider_qr=";
const GetLoadSheet = BaseURL + "index.php/rest/V1/naheed-rms/loadsheet?rider_id=";
const UpdateOrder = BaseURL + "index.php/rest/V1/naheed-rms/updateorderstatus?";
const UpdatePaymentMode = BaseURL + "index.php/rest/V1/naheed-rms/updatepaymentmethod?";
