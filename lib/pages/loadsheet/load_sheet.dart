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
  List<RiderLoadSheetData> loadSheet = [];

  final GlobalKey<AnimatedListState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    getLoadSheet();
  }

  void getLoadSheet() async {
    EasyLoading.show(
      status: 'Fetching Loadsheet....',
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
    );
    final ls = await RemoteServices().riderLoadSheet('94');
    EasyLoading.dismiss();
    if (ls.isNotEmpty) {
      if (ls[0].data.isNotEmpty) {
        listCount = ls[0].data.length;
        setState(() {
          isLoaded = true;
        });
        Future.delayed(Duration(milliseconds: 500), () {
          for (int i = 0; i < listCount; i++) {
          loadSheet.insert(i, ls[0].data[i]);
          _key.currentState!.insertItem(i, duration: Duration(milliseconds: 250));
          }
        });
        
      }

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
          isLoaded
              ? SizedBox(
                  height: SizeConfig.screenHeight * 0.92,
                  child: SafeArea(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              'Trip ID: 12321',
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: MyTripHeader(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            // child: AnimatedList(
                            //   key: _listKey,
                            //   initialItemCount:
                            //       (loadSheet.isNotEmpty) ? listCount : 0,
                            //   itemBuilder: ((context, index, animated) {
                            // return LoadsheetCard(
                            //   rLoadSheet: loadSheet[0].data[index],
                            // );
                            //   }),
                            // ),
                            child: AnimatedList(
                              key: _key,
                              initialItemCount: 0,
                              itemBuilder: ((context, index, animation) {
                                return SizeTransition(
                                  key: UniqueKey(),
                                  sizeFactor: animation,
                                  child: LoadsheetCard(
                                    rLoadSheet: loadSheet[index],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    'No\n Load Sheet\n Found',
                    style: GoogleFonts.montserrat(
                      fontSize: 40,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45.0),
                  topRight: Radius.circular(45.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_circle_outlined,
                          color: Colors.white,
                        ),
                        Text(
                          'Akhtar Lava',
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.home_outlined,
                        color: Colors.white,
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

class MyTripHeader extends StatelessWidget {
  const MyTripHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
