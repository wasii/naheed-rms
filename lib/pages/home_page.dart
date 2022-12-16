// ignore_for_file: sized_box_for_whitespace, sort_child_properties_last, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naheed_rider/constants.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var getResult = 'QR Code Result';
  @override
  Widget build(BuildContext context) {
    // postData();
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Image.asset('assets/logos/rms_logo.png'),
                ),
                Container(
                  width: 200,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      scanQRCode();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right:8.0),
                          child: Text(
                            'icon',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Text(
                          'Login',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      return kPrimaryColor;
                    })),
                  ),
                ),
              ],
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
          postData();
        }
      });
      print('QRCode Result');
      print(qrCode);
    } on PlatformException {
      getResult = 'Failed to scan QR Code';
    }
  }

  postData() async {
    var apiResponse = await http.post(
      Uri.parse(
          "https://insightopsmagento4.naheed.pk/index.php/rest/V1/naheed-rms/login?rider_qr=94/42301-5102628-1"),
    );
    print(apiResponse.body);
  }
}
