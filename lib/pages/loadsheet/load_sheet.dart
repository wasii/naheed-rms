// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naheed_rider/components/constants.dart';
import 'package:naheed_rider/components/size_config.dart';
import 'package:naheed_rider/models/load_sheet_model.dart';
import 'package:naheed_rider/services/remote_services.dart';
import 'package:naheed_rider/widgets/loadsheet_card.dart';

class LoadSheet extends StatefulWidget {
  const LoadSheet({super.key});

  @override
  State<LoadSheet> createState() => _LoadSheetState();
}

class _LoadSheetState extends State<LoadSheet> {
  int listCount = 0;
  bool isLoaded = false;
  List<RiderLoadSheet> loadSheet = [];
  @override void initState() {
    super.initState();
    // timer();
    getLoadSheet();
  }
  void timer() {
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        isLoaded = true;
      });
    });
  }

  void getLoadSheet() async {
    loadSheet = await RemoteServices().riderLoadSheet('94');
    listCount = loadSheet[0].data.length;
    setState(() {
      isLoaded = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            child: Image.asset(
              'assets/backgrounds/my_order.png',
              fit: BoxFit.fill,
            ),
          ),

          isLoaded ? 
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:20.0, right: 20.0),
                    child: MyTripHeader(),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: (loadSheet.isNotEmpty) ? listCount : 0,
                      itemBuilder: ((context, index) { 
                        return LoadsheetCard(rLoadSheet: loadSheet[0].data[index],);
                        }
                      ),
                    ),
                  ) 
                ],
              ),
            ),
          ) : Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45.0),
                  topRight: Radius.circular(45.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                      // Restart.restartApp();
                    },
                    icon: Image.asset('assets/icons/logout-icon.png'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyTripHeader extends StatelessWidget {
  const MyTripHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Trip",
          style: GoogleFonts.montserrat(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/icons/trip-icon.png',
              width: 30,
              height: 30,
            ),
            Text(
              "00:00",
              style: GoogleFonts.montserrat(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )
      ],
    );
  }
}
