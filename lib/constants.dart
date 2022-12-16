// ignore_for_file: constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';

// Colos that use in our app
const kPrimaryColorString = '465263';
const kPrimaryColor = Color(0xFF0066A8);
const kTextColor = Color(0xFF12153D);
const kTextLightColor = Color(0xFF9A9BB2);
const kFillStarColor = Color(0xFFFCC419);
const kFillButtonColor = Color(0xFF0066A8);

const kDefaultPadding = 20.0;

const kDefaultShadow = BoxShadow(
  offset: Offset(0, 0),
  blurRadius: 10,
  color: Colors.black26,
);


const poweredString = 'Powered by NaheedPk';


//URLs
const BaseURL = "https://insightopsmagento4.naheed.pk/";
const LoginURL = BaseURL+"index.php/rest/V1/naheed-rms/login?rider_qr=";