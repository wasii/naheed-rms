import 'dart:convert';

List<RiderLoadSheet> riderLoadSheetFromJson(String str) => List<RiderLoadSheet>.from(json.decode(str).map((x) => RiderLoadSheet.fromJson(x)));

String riderLoadSheetToJson(List<RiderLoadSheet> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RiderLoadSheet {
    RiderLoadSheet({
        required this.status,
        required this.message,
        required this.data,
    });

    int status;
    String message;
    List<RiderLoadSheetData> data;

    factory RiderLoadSheet.fromJson(Map<String, dynamic> json) => RiderLoadSheet(
        status: json["status"],
        message: json["message"],
        data: List<RiderLoadSheetData>.from(json["data"].map((x) => RiderLoadSheetData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class RiderLoadSheetData {
    RiderLoadSheetData({
        required this.orderNumber,
        required this.paymentMethod,
        required this.amountDue,
        required this.amountRefund,
        required this.shippingName,
        required this.shippingPhone,
        required this.shippingAddress,
        required this.deliveryArea,
        required this.packages,
    });

    String orderNumber;
    String paymentMethod;
    String amountDue;
    String amountRefund;
    String shippingName;
    String shippingPhone;
    String shippingAddress;
    String deliveryArea;
    String packages;

    factory RiderLoadSheetData.fromJson(Map<String, dynamic> json) => RiderLoadSheetData(
        orderNumber: json["order_number"],
        paymentMethod: json["payment_method"],
        amountDue: json["amount_due"],
        amountRefund: json["amount_refund"],
        shippingName: json["shipping_name"],
        shippingPhone: json["shipping_phone"],
        shippingAddress: json["shipping_address"],
        deliveryArea: json["delivery_area"],
        packages: json["packages"],
    );

    Map<String, dynamic> toJson() => {
        "order_number": orderNumber,
        "payment_method": paymentMethod,
        "amount_due": amountDue,
        "amount_refund": amountRefund,
        "shipping_name": shippingName,
        "shipping_phone": shippingPhone,
        "shipping_address": shippingAddress,
        "delivery_area": deliveryArea,
        "packages": packages,
    };
}
