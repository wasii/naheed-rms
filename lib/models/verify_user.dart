import 'dart:convert';

List<VerifyUser> verifyUserFromJson(String str) => List<VerifyUser>.from(json.decode(str).map((x) => VerifyUser.fromJson(x)));

String verifyUserToJson(List<VerifyUser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VerifyUser {
    VerifyUser({
        required this.status,
        required this.message,
        required this.contactNumber,
    });

    int status;
    String message;
    String contactNumber;

    factory VerifyUser.fromJson(Map<String, dynamic> json) => VerifyUser(
        status: json["status"],
        message: json["message"],
        contactNumber: json['contact_number'],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "contact_number": contactNumber
    };
}