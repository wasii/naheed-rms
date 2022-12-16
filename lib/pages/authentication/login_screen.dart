// ignore_for_file: sized_box_for_whitespace, sort_child_properties_last, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naheed_rider/constants.dart';
import 'package:http/http.dart' as http;
import 'package:naheed_rider/models/login_model.dart';
import 'package:naheed_rider/pages/home_page.dart';
import 'package:naheed_rider/services/remote_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<LoginModel>? user;
  var isLoaded = false;
  var getResult = 'QR Code Result';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            child: Image.asset(
              'assets/backgrounds/login.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: height * -0.45,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  kDefaultPadding * 4.0, 0, kDefaultPadding * 4.0, 0),
              child: Image.asset('assets/logos/rms_logo.png'),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 15,
            child: Center(
              child: Text(
                poweredString,
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            left: 120,
            right: 120,
            top: height * 0.70,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                boxShadow: [
                  kDefaultShadow,
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  scanQRCode();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/login-icon.png',
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Login',
                      style: GoogleFonts.montserrat(
                          fontSize: 25, fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                  ],
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (states) {
                      return Colors.white;
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          kPrimaryColorString, 'Cancel', false, ScanMode.QR);

      if (!mounted) return;
      setState(() {
        if (qrCode != "-1") {
          getUserDetails(qrCode);
        }
      });
      print('QRCode Result');
      print(qrCode);
    } on PlatformException {
      getResult = 'Failed to scan QR Code';
    }
  }

  getUserDetails(String qrCode) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    user = await RemoteServices().getUser(qrCode);
    if (user != null) {
      print(user?[0].token);
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
    return Navigator.of(context).pop();
  }
}
