// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    getLoadSheet();
  }

  void getLoadSheet() async {
    EasyLoading.show(
      status: 'Fetching Loadsheet....',
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,

    );
    loadSheet = await RemoteServices().riderLoadSheet('94');
    EasyLoading.dismiss();
    if (loadSheet.isNotEmpty) {
      listCount = loadSheet[0].data.length;
      setState(() {
        isLoaded = true;
      });
      return;
    }
    

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
          SizedBox(
            height: SizeConfig.screenHeight * 0.94,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:20.0, right: 20.0),
                      child: MyTripHeader(),
                    ),
                    SizedBox(height: 20,),
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
            ),
          ) : Center(
            child: Text('No\n Load Sheet\n Found', style: GoogleFonts.montserrat(
              fontSize: 40,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              
            ),
            textAlign: TextAlign.center,)
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
