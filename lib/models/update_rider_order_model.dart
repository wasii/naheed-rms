import 'dart:convert';
List<UpdateRiderOrder> updateRiderOrderFromJson(String str) => List<UpdateRiderOrder>.from(json.decode(str).map((x) => UpdateRiderOrder.fromJson(x)));

String updateRiderOrderToJson(List<UpdateRiderOrder> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpdateRiderOrder {
    UpdateRiderOrder({
        required this.status,
        required this.message,
    });

    int status;
    String message;

    factory UpdateRiderOrder.fromJson(Map<String, dynamic> json) => UpdateRiderOrder(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}

