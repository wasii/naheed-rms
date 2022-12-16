class LoginModel {
    LoginModel({
        required this.status,
        required this.message,
        required this.token,
        required this.data,
    });

    final int status;
    final String message;
    final String token;
    final UserData data;
}

class UserData {
    UserData({
        required this.id,
        required this.name,
        required this.contactNumber,
        required this.cnic,
        required this.address,
        required this.vehicleRegistrationNumber,
    });

    final String id;
    final String name;
    final String contactNumber;
    final String cnic;
    final String address;
    final String vehicleRegistrationNumber;
}
