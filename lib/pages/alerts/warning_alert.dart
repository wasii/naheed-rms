// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naheed_rider/components/constants.dart';
import 'package:naheed_rider/components/size_config.dart';

class WarningAlert extends StatefulWidget {
  final List<String> sReasons;
  const WarningAlert({super.key, required this.sReasons});

  @override
  State<WarningAlert> createState() => _WarningAlertState();
}

class _WarningAlertState extends State<WarningAlert> {
  List<Map<String,dynamic>> cancelled_reason = [
    // {'value' : "Refused to accept", 'isSelected' : false},
    // {'value' : "Damaged package", 'isSelected' : false},
    // {'value' : "Damaged product", 'isSelected' : false},
    // {'value' : "Wrong product", 'isSelected' : false},
    // {'value' : "Late delivery", 'isSelected' : false},
  ];
  var height = 135.0;
  @override void initState() {
    super.initState();
    for (var element in widget.sReasons) { 
      final dictionary = {'value': element, 'isSelected': false};
      cancelled_reason.add(dictionary);
    }
    height += widget.sReasons.length * 60;
  }
  String selectedValue = "";
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
                height: height,
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
                        'Cancelled Reason',
                        style: GoogleFonts.montserrat(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                        textAlign: TextAlign.center,
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
                                    cancelled_reason[index]['isSelected'] = true;    
                                    selectedValue = cancelled_reason[index]['value'];                              
                                    });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        cancelled_reason[index]['isSelected'] ? Icons.radio_button_on : Icons.radio_button_off, 
                                        color: kPrimaryColor,
                                        size: 20,),
                                      SizedBox(width: 10,),
                                      Text(
                                        cancelled_reason[index]['value'],
                                        style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                        ),
                                        maxLines: 2,
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
                              if (selectedValue != "") {
                                Navigator.pop(context,selectedValue);
                              }
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
