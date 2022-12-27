//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naheed_rider/components/constants.dart';
import 'package:naheed_rider/models/load_sheet_model.dart';
import 'package:naheed_rider/pages/alerts/warning_alert.dart';

class LoadsheetCard extends StatefulWidget {
  final RiderLoadSheetData rLoadSheet;
  const LoadsheetCard({super.key, required this.rLoadSheet});

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
                rLoadSheet: widget.rLoadSheet,
              ),
              SizedBox(height: 10),

              //Order Details
              OrderDetails(
                rLoadSheet: widget.rLoadSheet,
              ),
              SizedBox(height: 10),

              //Buttons
              OrderButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderButtons extends StatelessWidget {
  const OrderButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(context: context, builder: (_) => WarningAlert());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            minimumSize: Size(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text('CANCELLED'),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            minimumSize: Size(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text('UNDELIVERED'),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            minimumSize: Size(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text('DELIVERED'),
        ),
      ],
    );
  }
}

class OrderDetails extends StatelessWidget {
  final RiderLoadSheetData rLoadSheet;
  const OrderDetails({super.key, required this.rLoadSheet});

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
          child: OrderRightDetails(),
        ),
      ],
    );
  }
}

class OrderRightDetails extends StatelessWidget {
  const OrderRightDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Mode',
          style: GoogleFonts.montserrat(
            color: Colors.red,
            fontSize: 14,
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
              'Cash',
              style: GoogleFonts.montserrat(
                color: kPrimaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'change',
              style: GoogleFonts.montserrat(
                color: Colors.grey[500],
                fontSize: 11,
                fontWeight: FontWeight.normal,
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
          'Amount Due',
          style: GoogleFonts.montserrat(
            color: Colors.red,
            fontSize: 14,
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
              '5000',
              style: GoogleFonts.montserrat(
                color: kPrimaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ],
    );
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
                    fontSize: 13,
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
                      fontSize: 13,
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
