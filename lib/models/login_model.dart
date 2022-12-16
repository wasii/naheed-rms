import 'dart:convert';

List<LoginModel> loginModelFromJson(String str) => List<LoginModel>.from(json.decode(str).map((x) => LoginModel.fromJson(x)));

String loginModelToJson(List<LoginModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginModel {
    LoginModel({
        required this.status,
        required this.message,
        required this.token,
        required this.data,
    });

    int status;
    String message;
    String token;
    Data data;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.id,
        required this.name,
        required this.contactNumber,
        required this.cnic,
        required this.address,
        required this.vehicleRegistrationNumber,
    });

    String id;
    String name;
    String contactNumber;
    String cnic;
    String address;
    String vehicleRegistrationNumber;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        contactNumber: json["contact_number"],
        cnic: json["CNIC"],
        address: json["address"],
        vehicleRegistrationNumber: json["vehicle_registration_number"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contact_number": contactNumber,
        "CNIC": cnic,
        "address": address,
        "vehicle_registration_number": vehicleRegistrationNumber,
    };
}
