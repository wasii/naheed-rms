// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:naheed_rider/components/constants.dart';
import 'package:naheed_rider/models/load_sheet_model.dart';
import 'package:naheed_rider/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:naheed_rider/models/update_rider_order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/verify_user.dart';

class RemoteServices {
  //Verify Rider
  Future<List<VerifyUser>?> verifyUser(String qrCode) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == false) {
      return [];
    }
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
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == false) {
      return [];
    }
    var client = http.Client();
// 94/42301-5102628-1&otp=
    var uri = Uri.parse("$VerifyOTP$qrCode&otp=$otp");
    print(uri);
    var response = await client.post(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      if (json[11] == '0') {
        return [
          LoginModel(status: 0, message: "Invalid OTP", token: '', data: null)
        ];
      }
      return loginModelFromJson(json);
    }
    return [
          LoginModel(status: 0, message: "Something went wrong...", token: '', data: null)
        ];;
  }


  //Get Rider Load Sheet
  Future<List<RiderLoadSheet>> riderLoadSheet(String rider_id) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == false) {
      return [];
    }
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    print(token);
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

  //Update Rider Order Status....
  Future<List<UpdateRiderOrder>> updateOrderStatus(Map<String, String> data) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == false) {
      return [];
    }
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    print(token);
    var client = http.Client();
    String url = "rider_id=${data['rider_id'] ?? ''}&order_id=${data['order_id'] ?? ''}&order_number=${data['order_number'] ?? ''}&order_status=${data['order_status'] ?? ''}&reason=${data['reason'] ?? ''}";
    var uri = Uri.parse('$UpdateOrder$url');
    print(uri);

    var response = await client.post(uri, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var json = response.body;
      return updateRiderOrderFromJson(json);
    }
    return [];
  }
}