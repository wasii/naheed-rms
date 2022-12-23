//ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naheed_rider/components/constants.dart';

class LoadsheetCard extends StatefulWidget {
  const LoadsheetCard({super.key});

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
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              //Header
              LoadsheetCardHeader(),

              SizedBox(height: 10),

              //Order Details
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        OrderLeftDetails(title: 'Area', value: 'Gulshan e Iqbal',),
                        SizedBox(height: 10,),
                        OrderLeftDetails(title: 'Address', value: 'H.No 1726/324 Block G',),
                        SizedBox(height: 10,),
                        OrderLeftDetails(title: 'City', value: 'Lahore',),
                        SizedBox(height: 10,),
                        OrderLeftDetails(title: 'Phone', value: '92 333 1234567',),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    flex: 4,
                    child: Column(
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
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Cancelled'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Undelivered'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Delivered'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderLeftDetails extends StatelessWidget {
  const OrderLeftDetails({
    Key? key,
    required this.title,
    required this.value
  }) : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: GoogleFonts.montserrat(
              color: Colors.grey[500],
              fontSize: 13,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(left:5.0, right: 5.0),
            child: Text(
              value,
              style: GoogleFonts.montserrat(
                color: Colors.black87,
                fontSize: 13,
                fontWeight: FontWeight.w600
              ),
              maxLines: 2,
            ),
          ),
        ),
      ],
    );
  }
}

class LoadsheetCardHeader extends StatelessWidget {
  const LoadsheetCardHeader({super.key});

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
              'Akhtar Lava',
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
              '090078601',
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
              '12',
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
