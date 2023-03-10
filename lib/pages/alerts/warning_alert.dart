// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naheed_rider/components/constants.dart';
import 'package:naheed_rider/components/size_config.dart';

class WarningAlert extends StatefulWidget {
  final List<String> sReasons;
  final String heading;
  const WarningAlert(
      {super.key, required this.sReasons, required this.heading});

  @override
  State<WarningAlert> createState() => _WarningAlertState();
}

class _WarningAlertState extends State<WarningAlert> {
  List<Map<String, dynamic>> cancelled_reason = [];
  var height = 135.0;
  @override
  void initState() {
    super.initState();
    if (widget.heading == 'Payment Method') {
      for (var element in widget.sReasons) {
        String val = '';
        switch (element) {
          case 'cashondelivery':
            val = 'Cash';
            break;
          case 'ccondelivery':
            val = 'Card';
            break;
          case 'banktransfer':
            val = 'Bank';
            break;
        }
        final dictionary = {'key': element, 'value': val, 'isSelected': false};
        cancelled_reason.add(dictionary);
      }
    } else {
      for (var element in widget.sReasons) {
        final dictionary = {'key': '', 'value': element, 'isSelected': false};
        cancelled_reason.add(dictionary);
      }
    }
    height += widget.sReasons.length * 60;
  }

  String selectedValue = "";
  String selectedKey = "";
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
                        widget.heading,
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
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                for (int i = 0;
                                    i < cancelled_reason.length;
                                    i++) {
                                  cancelled_reason[i]['isSelected'] = false;
                                }
                                cancelled_reason[index]['isSelected'] = true;
                                selectedValue = cancelled_reason[index]['value'];
                                selectedKey = '${cancelled_reason[index]['key']}|${cancelled_reason[index]['value']}';
                              });
                            },
                            child: Padding(
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
                                  child: Row(
                                    children: [
                                      Icon(
                                        cancelled_reason[index]['isSelected']
                                            ? Icons.radio_button_on
                                            : Icons.radio_button_off,
                                        color: kPrimaryColor,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 0.0),
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
                                borderRadius: BorderRadius.circular(5),
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
                                if (widget.heading == "Payment Method") {
                                  Navigator.pop(context, selectedKey);
                                } else {
                                  Navigator.pop(context, selectedValue);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                              minimumSize: Size(130, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
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
