import 'dart:convert';

List<RiderLoadSheet> riderLoadSheetFromJson(String str) => List<RiderLoadSheet>.from(json.decode(str).map((x) => RiderLoadSheet.fromJson(x)));

String riderLoadSheetToJson(List<RiderLoadSheet> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RiderLoadSheet {
    RiderLoadSheet({
        required this.status,
        required this.message,
        required this.changePaymentMethod,
        required this.cancelReasons,
        required this.undeliveredReasons,
        required this.data,
    });

    int status;
    String message;
    List<String> changePaymentMethod;
    List<String> cancelReasons;
    List<String> undeliveredReasons;
    List<RiderLoadSheetData> data;

    factory RiderLoadSheet.fromJson(Map<String, dynamic> json) => RiderLoadSheet(
        status: json["status"],
        message: json["message"],
        changePaymentMethod: List<String>.from(json["cancel_reasons"].map((x) => x)),
        cancelReasons: List<String>.from(json["cancel_reasons"].map((x) => x)),
        undeliveredReasons: List<String>.from(json["undelivered_reasons"].map((x) => x)),
        data: List<RiderLoadSheetData>.from(json["data"].map((x) => RiderLoadSheetData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "change_payment_method": List<dynamic>.from(cancelReasons.map((x) => x)),
        "cancel_reasons": List<dynamic>.from(cancelReasons.map((x) => x)),
        "undelivered_reasons": List<dynamic>.from(undeliveredReasons.map((x) => x)),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class RiderLoadSheetData {
    RiderLoadSheetData({
        required this.orderId,
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

    String orderId;
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
        orderId: json["order_id"],
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
        "order_id": orderId,
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
