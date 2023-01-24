//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naheed_rider/components/constants.dart';
import 'package:naheed_rider/models/load_sheet_model.dart';
import 'package:naheed_rider/pages/alerts/warning_alert.dart';
import 'package:naheed_rider/services/remote_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/authentication/login_screen.dart';

class LoadsheetCard extends StatefulWidget {
  final int index;
  final RiderLoadSheet rLoadSheet;
  final RiderLoadSheetData rLoadSheetData;
  const LoadsheetCard(
      {super.key,
      required this.rLoadSheet,
      required this.rLoadSheetData,
      required this.index});

  @override
  State<LoadsheetCard> createState() => _LoadsheetCardState();
}

class _LoadsheetCardState extends State<LoadsheetCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        shadowColor: kPrimaryColor,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
          child: Column(
            children: [
              //Header
              LoadsheetCardHeader(
                rLoadSheet: widget.rLoadSheetData,
              ),
              SizedBox(height: 10),

              //Order Details
              OrderDetails(
                rLoadSheet: widget.rLoadSheetData,
                r: widget.rLoadSheet,
              ),
              SizedBox(height: 10),

              //Buttons
              OrderButtons(
                rLoadSheet: widget.rLoadSheet,
                index: widget.index,
                rLoadSheetData: widget.rLoadSheetData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderButtons extends StatelessWidget {
  final int index;
  final RiderLoadSheetData rLoadSheetData;
  final RiderLoadSheet rLoadSheet;
  const OrderButtons(
      {Key? key,
      required this.rLoadSheet,
      required this.index,
      required this.rLoadSheetData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return WarningAlert(
                    sReasons: rLoadSheet.cancelReasons,
                    heading: 'Cancelled Reasons',
                  );
                }).then((value) {
              print(value);
              if (value != null) {
                EasyLoading.show(
                  status: 'Updating your order....',
                  maskType: EasyLoadingMaskType.black,
                  dismissOnTap: false,
                );
                final val = (value as dynamic) as String;
                Map<String, String> data = {
                  'rider_id': RiderID,
                  'order_id': rLoadSheetData.orderId,
                  'order_number': rLoadSheetData.orderNumber,
                  'order_status': 'cancelled',
                  'reason': val
                };
                updateOrderStatus(data).then((value) {
                  EasyLoading.dismiss();
                  if (value == 'Success') {
                    Future.delayed(Duration(milliseconds: 100), () {});
                  } else {
                    if (value == InternetError) {
                      EasyLoading.showError(InternetError);
                    } else {
                      sessionExpired().then((value) => Navigator.of(context)
                          .pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (Route<dynamic> route) => false));
                    }
                  }
                });
              }
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[600],
            minimumSize: Size(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            'Cancelled',
            style: GoogleFonts.montserrat(
                fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) {
                  return WarningAlert(
                    sReasons: rLoadSheet.undeliveredReasons,
                    heading: 'Undelivered Reasons',
                  );
                }).then((value) {
              print(value);
              if (value != null) {
                EasyLoading.show(
                  status: 'Updating your order....',
                  maskType: EasyLoadingMaskType.black,
                  dismissOnTap: false,
                );
                final val = (value as dynamic) as String;
                Map<String, String> data = {
                  'rider_id': RiderID,
                  'order_id': rLoadSheetData.orderId,
                  'order_number': rLoadSheetData.orderNumber,
                  'order_status': 'undelivered',
                  'reason': val
                };
                updateOrderStatus(data).then((value) {
                  EasyLoading.dismiss();
                  if (value == 'Success') {
                    Future.delayed(Duration(milliseconds: 100), () {});
                  } else {
                    if (value == InternetError) {
                      EasyLoading.showError(InternetError);
                    } else {
                      sessionExpired().then((value) => Navigator.of(context)
                          .pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (Route<dynamic> route) => false));
                    }
                  }
                });
              }
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            minimumSize: Size(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            'Undelivered',
            style: GoogleFonts.montserrat(
                fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Order Delivered"),
                content: const Text(
                    "Are you sure you want to mark this order as Delivered?"),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(0, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.montserrat(
                          fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 'Confirm');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[900],
                      minimumSize: Size(0, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Confirm',
                      style: GoogleFonts.montserrat(
                          fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ).then((value) {
              if (value == 'Confirm') {
                EasyLoading.show(
                  status: 'Updating your order....',
                  maskType: EasyLoadingMaskType.black,
                  dismissOnTap: false,
                );
                Map<String, String> data = {
                  'rider_id': RiderID,
                  'order_id': rLoadSheetData.orderId,
                  'order_number': rLoadSheetData.orderNumber,
                  'order_status': 'delivered',
                  'reason': ''
                };
                updateOrderStatus(data).then((value) {
                  EasyLoading.dismiss();
                  if (value == Success) {
                    Future.delayed(Duration(milliseconds: 100), () {});
                  } else {
                    if (value == InternetError) {
                      EasyLoading.showError(InternetError);
                    } else {
                      sessionExpired().then((value) => Navigator.of(context)
                          .pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (Route<dynamic> route) => false));
                    }
                  }
                });
              }
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[800],
            minimumSize: Size(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            'Delivered',
            style: GoogleFonts.montserrat(
                fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  //Network Call to update Order Status.........
  Future<String> updateOrderStatus(Map<String, String> data) async {
    final response = await RemoteServices().updateOrderStatus(data);
    if (response != null) {
      if (response[0].status == 1) {
        return Success;
      } else {
        return InternetError;
      }
    } else {
      return SomethingWentWrong;
    }
  }

  Future<void> sessionExpired() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('token');
    pref.remove('name');
    pref.remove('id');
    pref.remove('cnic');
    EasyLoading.showError('Session Expired....');
    Future.delayed(Duration(seconds: 2), () {
      EasyLoading.dismiss();
      return false;
    });
  }
}

class OrderDetails extends StatelessWidget {
  final RiderLoadSheet r;
  final RiderLoadSheetData rLoadSheet;
  const OrderDetails({super.key, required this.rLoadSheet, required this.r});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            children: [
              OrderLeftDetails(
                title: 'Phone',
                value: rLoadSheet.shippingPhone,
              ),
              OrderLeftDetails(
                title: 'Area',
                value: rLoadSheet.deliveryArea,
              ),
              OrderLeftDetails(
                title: 'Address',
                value: rLoadSheet.shippingAddress,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 4,
          child: OrderRightDetails(
            riderLoadSheetData: rLoadSheet,
            riderLoadSheet: r,
          ),
        ),
      ],
    );
  }
}

class OrderRightDetails extends StatefulWidget {
  final RiderLoadSheet riderLoadSheet;
  final RiderLoadSheetData riderLoadSheetData;
  const OrderRightDetails(
      {super.key,
      required this.riderLoadSheetData,
      required this.riderLoadSheet});

  @override
  State<OrderRightDetails> createState() => _OrderRightDetailsState();
}

class _OrderRightDetailsState extends State<OrderRightDetails> {
  String amountHeading = "";
  String amountValue = "";
  List<String> menu = [];
  String paymentMethodValue = "";
  String paymentMethodKey = "";
  @override
  void initState() {
    super.initState();
    if (widget.riderLoadSheetData.paymentMethod == "Cash" ||
        widget.riderLoadSheetData.paymentMethod == "Card") {
      amountHeading = 'Amount Due';
      amountValue = widget.riderLoadSheetData.amountDue;
    } else {
      amountHeading = 'Amount Refund';
      amountValue = widget.riderLoadSheetData.amountRefund;
    }
    menu = widget.riderLoadSheet.changePaymentMethod;
    // paymentMethodKey =
    paymentMethodValue = widget.riderLoadSheetData.paymentMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Mode',
          style: GoogleFonts.montserrat(
            color: Colors.red,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              paymentMethodValue,
              style: GoogleFonts.montserrat(
                color: kPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return WarningAlert(
                        sReasons: menu,
                        heading: 'Payment Method',
                      );
                    }).then((value) {
                  final splitted = value.toString().split('|');
                  EasyLoading.show(
                    status: 'Updating payment method....',
                    maskType: EasyLoadingMaskType.black,
                    dismissOnTap: false,
                  );
                  Map<String, String> data = {
                    'rider_id': RiderID,
                    'order_id': widget.riderLoadSheetData.orderId,
                    'order_number': widget.riderLoadSheetData.orderNumber,
                    'payment_method': splitted[0],
                  };
                  updatePayment(data).then((value) {
                    EasyLoading.dismiss();
                    if (value == Success) {
                      Future.delayed(Duration(milliseconds: 100), () {
                        setState(() {
                          paymentMethodValue = splitted[1];
                        });
                      });
                    } else {
                      if (value == InternetError) {
                        EasyLoading.showError(InternetError);
                      } else {
                        sessionExpired().then((value) => Navigator.of(context)
                            .pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                                (Route<dynamic> route) => false));
                      }
                    }
                  });
                });
              },
              child: Text(
                widget.riderLoadSheetData.paymentMethod == 'PrePaid'
                    ? ''
                    : 'change',
                style: GoogleFonts.montserrat(
                  color: Colors.grey[500],
                  fontSize: 11,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 2,
        ),
        Container(
          height: 1,
          color: Colors.grey[500],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          amountHeading,
          style: GoogleFonts.montserrat(
            color: Colors.red,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              amountValue,
              style: GoogleFonts.montserrat(
                color: kPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ],
    );
  }
  //Network Call to update Order Status.........
  Future<String> updatePayment(Map<String, String> data) async {
    final response = await RemoteServices().updatePaymentMode(data);
    if (response != null) {
      if (response[0].status == 1) {
        return Success;
      } else {
        return InternetError;
      }
    } else {
      return SomethingWentWrong;
    }
  }

  Future<void> sessionExpired() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('token');
    pref.remove('name');
    pref.remove('id');
    pref.remove('cnic');
    EasyLoading.showError('Session Expired....');
    Future.delayed(Duration(seconds: 2), () {
      EasyLoading.dismiss();
      return false;
    });
  }
}

class OrderLeftDetails extends StatelessWidget {
  const OrderLeftDetails({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Text(
                  value,
                  style: GoogleFonts.montserrat(
                      color: Colors.black87,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                  maxLines: 3,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class LoadsheetCardHeader extends StatelessWidget {
  final RiderLoadSheetData rLoadSheet;
  const LoadsheetCardHeader({super.key, required this.rLoadSheet});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer Name',
              style: GoogleFonts.montserrat(
                color: Colors.grey[500],
                fontSize: 11,
              ),
            ),
            Text(
              rLoadSheet.shippingName,
              style: GoogleFonts.montserrat(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order No.',
              style: GoogleFonts.montserrat(
                color: Colors.grey[500],
                fontSize: 11,
              ),
            ),
            Text(
              rLoadSheet.orderNumber,
              style: GoogleFonts.montserrat(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No. of Boxes',
              style: GoogleFonts.montserrat(
                color: Colors.grey[500],
                fontSize: 11,
              ),
            ),
            Text(
              rLoadSheet.packages,
              style: GoogleFonts.montserrat(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
