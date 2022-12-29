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
  List<Map<String,dynamic>> cancelled_reason = [
    {'value' : "Refused to accept", 'isSelected' : false},
    {'value' : "Damaged package", 'isSelected' : false},
    {'value' : "Damaged product", 'isSelected' : false},
    {'value' : "Wrong product", 'isSelected' : false},
    {'value' : "Late delivery", 'isSelected' : false},
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
                height: 460,
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
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Cancel Reasons',
                        style: GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor
                        ),
                      ),
                    ),
                    Container(
                      color: kPrimaryColor,
                      height: 2,
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
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    for(int i = 0; i < cancelled_reason.length; i++) {
                                      cancelled_reason[i]['isSelected'] = false;
                                    }
                                    cancelled_reason[index]['isSelected'] = true;                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        cancelled_reason[index]['isSelected'] ? Icons.radio_button_on : Icons.radio_button_off, 
                                        color: kPrimaryColor,),
                                      SizedBox(width: 10,),
                                      Text(
                                        cancelled_reason[index]['value'],
                                        style: GoogleFonts.montserrat(
                                          fontSize: 23,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Container(
                      color: kPrimaryColor,
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[600],
                              minimumSize: Size(130, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
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
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                              minimumSize: Size(130, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'Submit',
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
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
