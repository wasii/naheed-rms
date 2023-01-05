// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:naheed_rider/components/constants.dart';
import 'package:naheed_rider/models/load_sheet_model.dart';
import 'package:naheed_rider/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/verify_user.dart';

class RemoteServices {
  //Verify Rider
  Future<List<VerifyUser>?> verifyUser(String qrCode) async {
    var client = http.Client();

    var uri = Uri.parse("$LoginURL$qrCode&resend_otp=0");
    print(uri);
    var response = await client.post(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return verifyUserFromJson(json);
    }
    return null;
  }

  //Get Rider Details
  Future<List<LoginModel>?> verifyOTP(String qrCode, String otp) async {
    
    var client = http.Client();
// 94/42301-5102628-1&otp=
    var uri = Uri.parse("$VerifyOTP$qrCode&otp=$otp");
    print(uri);
    var response = await client.post(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return loginModelFromJson(json);
    }
    return null;
  }


  //Get Rider Load Sheet
  Future<List<RiderLoadSheet>> riderLoadSheet(String rider_id) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    var client = http.Client();
    var uri = Uri.parse('$GetLoadSheet$rider_id');
    print(uri);

    var response = await client.post(uri, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var json = response.body;
      return riderLoadSheetFromJson(json);
    }
    return [];
  }
}