//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naheed_rider/components/constants.dart';
import 'package:naheed_rider/models/load_sheet_model.dart';
import 'package:naheed_rider/pages/alerts/warning_alert.dart';

class LoadsheetCard extends StatefulWidget {
  final RiderLoadSheet rLoadSheet;
  final RiderLoadSheetData rLoadSheetData;
  const LoadsheetCard({super.key, required this.rLoadSheet, required this.rLoadSheetData});

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
              OrderButtons(rLoadSheet: widget.rLoadSheet,),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderButtons extends StatelessWidget {
  final RiderLoadSheet rLoadSheet;
  const OrderButtons({
    Key? key, required this.rLoadSheet
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(context: context, builder: (_) {
              return WarningAlert(sReasons: rLoadSheet.cancelReasons);
            }).then((value) {
              print(value);
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[600],
            minimumSize: Size(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            'Cancelled',
            style: GoogleFonts.montserrat(
                fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            showDialog(context: context, builder: (_) {
              return WarningAlert(sReasons: rLoadSheet.undeliveredReasons);
            }).then((value) {
              print(value);
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            minimumSize: Size(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            'Undelivered',
            style: GoogleFonts.montserrat(
                fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[800],
            minimumSize: Size(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            'Delivered',
            style: GoogleFonts.montserrat(
                fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
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
          child: OrderRightDetails(riderLoadSheetData: rLoadSheet, riderLoadSheet: r,),
        ),
      ],
    );
  }
}
class OrderRightDetails extends StatefulWidget {
  final RiderLoadSheet riderLoadSheet;
  final RiderLoadSheetData riderLoadSheetData;
  const OrderRightDetails({super.key, required this.riderLoadSheetData, required this.riderLoadSheet});

  @override
  State<OrderRightDetails> createState() => _OrderRightDetailsState();
}

class _OrderRightDetailsState extends State<OrderRightDetails> {
  String amountHeading = "";
  String amountValue = "";
  List<String> menu = [];
  @override void initState() {
    super.initState();
    if (widget.riderLoadSheetData.paymentMethod == "Cash" || widget.riderLoadSheetData.paymentMethod == "Card") {
      amountHeading = 'Amount Due';
      amountValue = widget.riderLoadSheetData.amountDue;
    } else {
      amountHeading = 'Amount Refund';
      amountValue = widget.riderLoadSheetData.amountRefund;
    }
    // menu = widget.riderLoadSheet.changePaymentMethod;
    
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
              widget.riderLoadSheetData.paymentMethod,
              style: GoogleFonts.montserrat(
                color: kPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(context: context, builder: (_) {
              return WarningAlert(sReasons: menu);
            }).then((value) {
              print(value);
            });
              },
              child: Text(
                'change',
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
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        child: Text(item),
        value: item,
      );
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
