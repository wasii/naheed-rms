import 'package:naheed_rider/components/constants.dart';
import 'package:naheed_rider/models/login_model.dart';
import 'package:http/http.dart' as http;

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
    var uri = Uri.parse("$VerifyUser$qrCode&otp=$otp");
    print(uri);
    var response = await client.post(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return loginModelFromJson(json);
    }
    return null;
  }
}