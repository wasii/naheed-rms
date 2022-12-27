// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naheed_rider/components/constants.dart';
import 'package:naheed_rider/components/size_config.dart';

class WarningAlert extends StatefulWidget {
  const WarningAlert({super.key});

  @override
  State<WarningAlert> createState() => _WarningAlertState();
}

class _WarningAlertState extends State<WarningAlert> {
  List<String> cancelled_reason = [
    "Refused to accept",
    "Damaged package",
    "Damaged product",
    "Wrong product",
    "Late delivery"
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            color: kPrimaryColor.withOpacity(0.3),
            child: Center(
              child: Container(
                height: 450,
                margin: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ), // Set rounded corner radius
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 10,
                        color: Colors.black,
                        offset: Offset(0, 6))
                  ], // Make rounded corner of border
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: Text(
                        'Cancel Reasons',
                        style: GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.black,
                      height: 1,
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: cancelled_reason.length,
                        itemBuilder: ((_, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 20.0, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ), // Set rounded corner radius
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 2,
                                      color: Colors.black45,
                                      offset: Offset(0, 0))
                                ], // Make rounded corner of border
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  cancelled_reason[index],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          minimumSize: Size(150, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
