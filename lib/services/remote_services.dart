import 'package:naheed_rider/constants.dart';
import 'package:naheed_rider/models/login_model.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  Future<List<LoginModel>?> getUser(String qrCode) async {
    var client = http.Client();

    var uri = Uri.parse(LoginURL+qrCode);
    var response = await client.post(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return loginModelFromJson(json);
    }
  }
}